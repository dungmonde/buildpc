<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Http;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;
use App\Models\Component;
use App\Helpers\TextCleaner;

class AiBuildController extends Controller
{
    public function index()
    {
        return view('pages.build_pc.ai-suggest');
    }

    public function suggest(Request $request)
    {
        $request->validate([
            'budget' => 'required|numeric|min:4500000',
            'needs'  => 'required|string|max:500',
        ]);

        try {
            $apiKey = env('GROQ_API_KEY');
        if (!$apiKey) {
            return back()->with('error', 'Tính năng chưa được cấu hình (thiếu API Key trong file .env).');
        }

        $budget = (float)$request->budget;
        $needs  = $request->needs;
        $tools = [
            [
                'type' => 'function',
                'function' => [
                    'name' => 'get_store_catalog',
                    'description' => 'Tra cứu toàn bộ danh sách các linh kiện thực tế đang có sẵn tại cửa hàng phù hợp với ngân sách.',
                    'parameters' => [
                        'type' => 'object',
                        'properties' => [
                            'budget' => ['type' => 'number', 'description' => 'Tổng ngân sách tối đa của khách hàng bằng VNĐ']
                        ],
                        'required' => ['budget']
                    ]
                ]
            ]
        ];

        $messages = [
            [
                'role' => 'system',
                'content' => "Bạn là trợ lý tư vấn cấu hình PC chuyên nghiệp. Hãy sử dụng duy nhất công cụ get_store_catalog để tra cứu toàn bộ danh sách các linh kiện thực tế phù hợp với ngân sách của khách hàng. Sau khi nhận được danh sách linh kiện, bạn PHẢI chọn ra các linh kiện tương thích vật lý (CPU socket khớp Mainboard socket, RAM khớp DDR gen của Mainboard, PSU đủ công suất gánh CPU + VGA), tổng giá nằm trong ngân sách và trả về JSON cấu hình cuối cùng.\n\nFormat JSON cuối cùng bắt buộc (trả về JSON thuần túy, không có markdown):\n{\"builds\":[{\"title\":\"Tên cấu hình\",\"build_type\":\"gaming hoặc workstation hoặc office\",\"components\":{\"cpu\":ID_CPU,\"mainboard\":ID_MAINBOARD,\"ram\":ID_RAM,\"vga\":ID_VGA_OR_NULL,\"storage\":ID_STORAGE,\"psu\":ID_PSU,\"case\":ID_CASE},\"explanation\":\"Mô tả chung...\"}]}\n\nQuy tắc quan trọng cho phần 'explanation': KHÔNG được đề cập đến tên model hoặc hãng sản xuất cụ thể của linh kiện (như 'Core i3 12100F', 'GTX 1650', 'H610', 'Intel', 'AMD', 'Nvidia', v.v.) vào phần mô tả. Hãy viết mô tả hướng đến lợi ích, hiệu năng tổng thể và phân khúc của bộ máy (ví dụ: 'Cấu hình được trang bị bộ vi xử lý đa nhân thế hệ mới, card đồ họa rời mạnh mẽ, ổ cứng SSD tốc độ cao...'). Lý do là các linh kiện có thể được nâng cấp tự động sau đó để tối ưu ngân sách thừa."
            ],
            [
                'role' => 'user',
                'content' => "Ngân sách: " . number_format($budget) . " VNĐ.\nNhu cầu: " . $needs
            ]
        ];

        $aiResult = null;
        $maxIterations = 3;
        $fallbackReason = null;

        try {
            for ($iteration = 1; $iteration <= $maxIterations; $iteration++) {
                $model = 'llama-3.3-70b-versatile';
                
                $response = Http::withoutVerifying()->withHeaders([
                    'Content-Type' => 'application/json',
                    'Authorization' => 'Bearer ' . $apiKey,
                ])->post('https://api.groq.com/openai/v1/chat/completions', [
                    'model'       => $model,
                    'messages'    => $messages,
                    'tools'       => $tools,
                    'tool_choice' => 'auto'
                ]);

                // Nếu rate limit 429, dùng model fallback
                if ($response->status() === 429) {
                    Log::warning("Groq API 429 for {$model} during agent loop. Retrying with llama-3.1-8b-instant...");
                    $model = 'llama-3.1-8b-instant';
                    $response = Http::withoutVerifying()->withHeaders([
                        'Content-Type' => 'application/json',
                        'Authorization' => 'Bearer ' . $apiKey,
                    ])->post('https://api.groq.com/openai/v1/chat/completions', [
                        'model'       => $model,
                        'messages'    => $messages,
                        'tools'       => $tools,
                        'tool_choice' => 'auto'
                    ]);
                }

                if (!$response->successful()) {
                    $fallbackReason = 'Groq API error status ' . $response->status() . ': ' . $response->body();
                    Log::warning($fallbackReason);
                    break;
                }

                $data = $response->json();
                $message = $data['choices'][0]['message'] ?? null;
                if (!$message) {
                    $fallbackReason = 'Empty message from API response';
                    break;
                }

                $messages[] = $message;

                if (!empty($message['tool_calls'])) {
                    foreach ($message['tool_calls'] as $toolCall) {
                        $toolName = $toolCall['function']['name'];
                        $toolArgs = json_decode($toolCall['function']['arguments'], true) ?? [];
                        $toolCallId = $toolCall['id'];

                        $result = null;
                        if ($toolName === 'get_store_catalog') {
                            $result = $this->getStoreCatalog($toolArgs['budget'] ?? $budget);
                        }

                        $messages[] = [
                            'role'         => 'tool',
                            'tool_call_id' => $toolCallId,
                            'name'         => $toolName,
                            'content'      => json_encode($result, JSON_UNESCAPED_UNICODE)
                        ];
                    }
                } else {
                    $jsonStr = $message['content'] ?? '';
                    if (preg_match('/\{.*\}/s', $jsonStr, $matches)) {
                        $jsonStr = $matches[0];
                    }
                    $aiResult = json_decode(trim($jsonStr), true);
                    if (!$aiResult || !isset($aiResult['builds'])) {
                        $fallbackReason = 'Invalid JSON output from AI content: ' . $jsonStr;
                    }
                    break;
                }
            }
        } catch (\Exception $e) {
            $fallbackReason = 'Exception in Agent loop: ' . $e->getMessage();
            Log::error($fallbackReason);
        }

        // Nếu không có kết quả từ AI hoặc kết quả không hợp lệ, thực hiện fallback sang PHP
        if (!$aiResult || !isset($aiResult['builds']) || empty($aiResult['builds'])) {
            Log::warning("AI Suggestion failed/invalid. Reason: " . ($fallbackReason ?? 'No builds returned') . ". Falling back to PHP assembler.");
            
            $needsLower = strtolower($needs);
            $guessedBuildType = 'gaming';
            if (str_contains($needsLower, 'văn phòng') || str_contains($needsLower, 'office') || str_contains($needsLower, 'học tập')) {
                $guessedBuildType = 'office';
            } elseif (str_contains($needsLower, 'đồ họa') || str_contains($needsLower, 'workstation') || str_contains($needsLower, 'render') || str_contains($needsLower, 'lập trình')) {
                $guessedBuildType = 'workstation';
            }

            $guessedCpuBrand = 'any';
            if (str_contains($needsLower, 'intel')) {
                $guessedCpuBrand = 'intel';
            } elseif (str_contains($needsLower, 'amd') || str_contains($needsLower, 'ryzen')) {
                $guessedCpuBrand = 'amd';
            }

            $guessedExplanation = 'Cấu hình tối ưu được thiết kế để đáp ứng mượt mà nhu cầu giải trí và công việc hàng ngày của bạn.';
            if ($guessedBuildType === 'gaming') {
                $guessedExplanation = 'Cấu hình gaming tối ưu hiệu năng trên giá thành với bộ vi xử lý đa nhân mạnh mẽ và card đồ họa rời chuyên dụng, giúp bạn chiến mượt mà các tựa game phổ biến.';
            } elseif ($guessedBuildType === 'workstation') {
                $guessedExplanation = 'Cấu hình tối ưu cho công việc đồ họa, render, lập trình và đa nhiệm hiệu năng cao với CPU nhiều nhân, dung lượng RAM lớn và ổ cứng SSD siêu tốc.';
            } elseif ($guessedBuildType === 'office') {
                $guessedExplanation = 'Cấu hình văn phòng và học tập mượt mà, khởi động cực nhanh và vận hành bền bỉ, tiết kiệm điện năng.';
            }

            $aiResult = [
                'builds' => [
                    [
                        'title' => 'Cấu hình Đề xuất (Tối ưu tự động)',
                        'build_type' => $guessedBuildType,
                        'cpu_brand' => $guessedCpuBrand,
                        'explanation' => $guessedExplanation,
                        'components' => [], // Empty components to force fallback path
                    ]
                ]
            ];
        }

        $suggestedBuilds = [];
        $isOverkill = false;
        $originalBudget = $budget;
        $confirmOverkill = $request->input('confirm_overkill') == '1';

            foreach ($aiResult['builds'] as $build) {
                // Làm sạch tiếng Trung/chữ Hán nếu có trong phần text
                if (isset($build['explanation'])) {
                    $build['explanation'] = TextCleaner::cleanCjk($build['explanation']);
                }
                if (isset($build['title'])) {
                    $build['title'] = TextCleaner::cleanCjk($build['title']);
                }

                $buildType = strtolower($build['build_type'] ?? 'gaming');
                if ($buildType === 'office' && $budget > 15000000 && !$confirmOverkill) {
                    $isOverkill = true;
                    // Tối ưu ngân sách cho văn phòng xuống mức 15.000.000đ và chạy thuật toán cũ
                    $fallbackBuild = $this->assembleBuild($build, 15000000);
                    $fallbackBuild['source'] = 'php_fallback';
                    $suggestedBuilds[] = $fallbackBuild;
                } else {
                    if ($confirmOverkill && $buildType === 'office') {
                        // Nâng cấp lên workstation để build cấu hình xịn có GPU
                        $build['build_type'] = 'workstation';
                        $build['title'] = ($build['title'] ?? 'Cấu hình Đề xuất') . ' (Tối đa Ngân sách)';
                        $buildType = 'workstation';
                    }
                    
                    // Thử lấy linh kiện thực tế theo lựa chọn của AI
                    $selectedIds = $build['components'] ?? [];
                    $components = [];
                    $totalPrice = 0;
                    $requiredTypes = ['cpu', 'mainboard', 'ram', 'storage', 'psu', 'case'];
                    $hasAllRequired = true;

                    foreach ($requiredTypes as $type) {
                        if (empty($selectedIds[$type]) || !is_numeric($selectedIds[$type])) {
                            $hasAllRequired = false;
                            break;
                        }
                        $table = $type === 'ram' ? 'memory' : ($type === 'storage' ? 'internal_hard_drives' : ($type === 'psu' ? 'power_supplies' : ($type === 'case' ? 'cases' : ($type === 'mainboard' ? 'motherboards' : 'cpus'))));
                        
                        $compObj = DB::table('components')
                            ->join($table, "{$table}.component_id", '=', 'components.id')
                            ->leftJoin(
                                DB::raw('(SELECT component_id, MIN(price) as price FROM component_prices GROUP BY component_id) cp'),
                                'cp.component_id', '=', 'components.id'
                            )
                            ->where('components.id', $selectedIds[$type])
                            ->select('components.id', 'components.name', DB::raw('COALESCE(components.base_price, cp.price) as price'))
                            ->first();

                        if (!$compObj || !(float)$compObj->price) {
                            $hasAllRequired = false;
                            break;
                        }

                        $components[$type] = [
                            'id' => $compObj->id,
                            'name' => $compObj->name,
                            'price' => (float)$compObj->price,
                            'image' => true,
                        ];
                        $totalPrice += (float)$compObj->price;
                    }

                    // Linh kiện VGA tùy chọn
                    if ($hasAllRequired && !empty($selectedIds['vga']) && is_numeric($selectedIds['vga'])) {
                        $compObj = DB::table('components')
                            ->join('video_cards', 'video_cards.component_id', '=', 'components.id')
                            ->leftJoin(
                                DB::raw('(SELECT component_id, MIN(price) as price FROM component_prices GROUP BY component_id) cp'),
                                'cp.component_id', '=', 'components.id'
                            )
                            ->where('components.id', $selectedIds['vga'])
                            ->select('components.id', 'components.name', DB::raw('COALESCE(components.base_price, cp.price) as price'))
                            ->first();

                        if ($compObj && (float)$compObj->price) {
                            $components['vga'] = [
                                'id' => $compObj->id,
                                'name' => $compObj->name,
                                'price' => (float)$compObj->price,
                                'image' => true,
                            ];
                            $totalPrice += (float)$compObj->price;
                        }
                    }

                    // Xác thực tính tương thích vật lý bằng PHP
                    $isCompatible = true;
                    if ($hasAllRequired) {
                        $cpuSpec = DB::table('cpus')->where('component_id', $selectedIds['cpu'])->first();
                        $mbSpec  = DB::table('motherboards')->where('component_id', $selectedIds['mainboard'])->first();
                        $ramSpec = DB::table('memory')->where('component_id', $selectedIds['ram'])->first();
                        $psuSpec = DB::table('power_supplies')->where('component_id', $selectedIds['psu'])->first();

                        $cpuSocket = $cpuSpec->socket ?? null;
                        $mbSocket  = $mbSpec->socket ?? null;
                        $mbDdr     = $mbSpec->ddr_gen ?? null;
                        $ramDdr    = $ramSpec->ddr_gen ?? null;
                        $cpuTdp    = $cpuSpec->tdp ?? 65;
                        $psuWatt   = $psuSpec->wattage ?? 0;

                        $vgaTdp = 0;
                        if (!empty($selectedIds['vga']) && is_numeric($selectedIds['vga'])) {
                            $vgaSpec = DB::table('video_cards')->where('component_id', $selectedIds['vga'])->first();
                            $vgaTdp  = $vgaSpec->tdp ?? 0;
                        }

                        // 1. Kiểm tra Socket CPU và Motherboard
                        if ($cpuSocket && $mbSocket && strtolower($cpuSocket) !== strtolower($mbSocket)) {
                            $isCompatible = false;
                        }
                        
                        // 2. Kiểm tra thế hệ DDR của Motherboard và RAM
                        if ($mbDdr && $ramDdr && (int)$mbDdr !== (int)$ramDdr) {
                            $isCompatible = false;
                        }

                        // 3. Kiểm tra công suất nguồn đủ tải (CPU + VGA + hao phí)
                        $requiredWatt = $cpuTdp + $vgaTdp + ($vgaTdp > 0 ? 220 : 150);
                        if ($psuWatt && $psuWatt < $requiredWatt) {
                            $isCompatible = false;
                        }

                        // 4. Kiểm tra loại trừ chipset Mainboard giá rẻ với CPU dòng cao
                        $cpuObj = DB::table('components')
                            ->leftJoin(
                                DB::raw('(SELECT component_id, MIN(price) as price FROM component_prices GROUP BY component_id) cp'),
                                'cp.component_id', '=', 'components.id'
                            )
                            ->where('components.id', $selectedIds['cpu'])
                            ->select('components.name', DB::raw('COALESCE(components.base_price, cp.price) as price'))
                            ->first();
                        
                        $mbObj = DB::table('components')->where('id', $selectedIds['mainboard'])->first();

                        if ($cpuObj && $mbObj) {
                            $cpuPriceVal = (float)$cpuObj->price;
                            $cpuNameVal = strtolower($cpuObj->name);
                            $isHighEndCpuVal = ($cpuPriceVal > 4000000)
                                || preg_match('/\b(k|kf|ks|x3d)\b/i', $cpuNameVal)
                                || str_contains($cpuNameVal, 'ryzen 7')
                                || str_contains($cpuNameVal, 'ryzen 9')
                                || str_contains($cpuNameVal, 'i7-')
                                || str_contains($cpuNameVal, 'i9-');
                            
                            if ($isHighEndCpuVal) {
                                $mbNameVal = strtolower($mbObj->name);
                                $badChipsets = ['h610', 'h510', 'h410', 'a320', 'a620', 'h710', 'b450', 'b460', 'b560'];
                                foreach ($badChipsets as $chip) {
                                    if (str_contains($mbNameVal, $chip)) {
                                        $isCompatible = false;
                                        break;
                                    }
                                }
                            }
                        }
                    }

                    // Nếu AI chọn đúng, tương thích và đủ linh kiện có thật dưới ngân sách (cho phép sai số 5% vượt ngân sách)
                    if ($hasAllRequired && $isCompatible && $totalPrice <= ($budget * 1.05)) {
                        $aiBuild = [
                            'title' => $build['title'] ?? 'Cấu hình Đề xuất',
                            'explanation' => $build['explanation'] ?? '',
                            'budget_allocated' => $budget,
                            'components' => $components,
                            'total_price' => $totalPrice,
                        ];

                        // Nâng cấp cấu hình của AI nếu còn dư ngân sách
                        $needsGpuVal = in_array($buildType, ['gaming', 'workstation']) && $budget >= 9000000;
                        $aiBuild = $this->upgradeBuild($aiBuild, $budget, $buildType, 'any', $needsGpuVal);
                        $aiBuild['source'] = 'ai';

                        // Sắp xếp các linh kiện theo thứ tự tiêu chuẩn
                        $orderedKeys = ['cpu', 'mainboard', 'ram', 'vga', 'storage', 'psu', 'case'];
                        $orderedComponents = [];
                        foreach ($orderedKeys as $key) {
                            if (isset($aiBuild['components'][$key])) {
                                $orderedComponents[$key] = $aiBuild['components'][$key];
                            }
                        }
                        $aiBuild['components'] = $orderedComponents;

                        $suggestedBuilds[] = $aiBuild;
                    } else {
                        // Fallback về thuật toán phân bổ PHP nếu AI chọn sai linh kiện, không tương thích hoặc vượt quá nhiều ngân sách
                        $fallbackBuild = $this->assembleBuild($build, $budget);
                        $fallbackBuild['source'] = 'php_fallback';
                        $suggestedBuilds[] = $fallbackBuild;
                    }
                }
            }

            return view('pages.build_pc.ai-result', compact('suggestedBuilds', 'budget', 'needs', 'isOverkill', 'originalBudget'));

        } catch (\Exception $e) {
            return back()->with('error', 'Có lỗi xảy ra: ' . $e->getMessage());
        }
    }

    // ─────────────────────────────────────────────────────────────────────────
    // CORE: Lắp ráp cấu hình từ template ngân sách — PHP kiểm soát 100%
    // ─────────────────────────────────────────────────────────────────────────
    private function assembleBuild(array $intent, float $budget): array
    {
        $buildType = strtolower($intent['build_type'] ?? 'gaming');
        $cpuBrand  = strtolower($intent['cpu_brand']  ?? 'any');
        $needsGpu  = in_array($buildType, ['gaming', 'workstation']) && $budget >= 9000000;

        $build = [
            'title'            => $intent['title']       ?? 'Cấu hình Đề xuất',
            'explanation'      => $intent['explanation'] ?? '',
            'budget_allocated' => $budget,
            'components'       => [],
            'total_price'      => 0,
        ];

        // ── Phân bổ ngân sách theo template ──────────────────────────────────
        if ($needsGpu) {
            $alloc = [
                'vga'       => $budget * 0.38,
                'cpu'       => $budget * 0.22,
                'mainboard' => max($budget * 0.16, 1500000),
                'ram'       => max($budget * 0.12, 1000000),
                'storage'   => max($budget * 0.07, 900000),
                'psu'       => max($budget * 0.04, 750000),
                'case'      => max($budget * 0.03, 500000),
            ];
            $floors = [
                'vga'       => 1500000,
                'cpu'       => 1500000,
                'mainboard' => 1350000,
                'ram'       => 850000,
                'storage'   => 800000,
                'psu'       => 700000,
                'case'      => 599000,
            ];
        } else {
            $alloc = [
                'cpu'       => $budget * 0.32,
                'mainboard' => max($budget * 0.25, 1300000),
                'ram'       => max($budget * 0.20, 800000),
                'storage'   => max($budget * 0.13, 800000),
                'psu'       => max($budget * 0.06, 600000),
                'case'      => max($budget * 0.04, 400000),
                'vga'       => 0,
            ];
            $floors = [
                'cpu'       => 1200000,
                'mainboard' => 1150000,
                'ram'       => 700000,
                'storage'   => 700000,
                'psu'       => 550000,
                'case'      => 599000,
                'vga'       => 0,
            ];
        }

        // Normalize: nếu tổng alloc vượt budget, co lại theo tỷ lệ (nhưng giữ các linh kiện ở mức tối thiểu an toàn)
        $totalAlloc = array_sum($alloc);
        if ($totalAlloc > $budget) {
            $excess = $totalAlloc - $budget;
            // Giảm theo thứ tự ưu tiên ngược để bảo toàn tính tương thích
            foreach (['vga', 'mainboard', 'cpu', 'ram', 'storage', 'psu', 'case'] as $slot) {
                if (!isset($alloc[$slot]) || $alloc[$slot] <= 0) continue;
                $floorPrice = $floors[$slot] ?? 500000;
                $cut = min($excess, max(0, $alloc[$slot] - $floorPrice));
                $alloc[$slot] -= $cut;
                $excess -= $cut;
                if ($excess <= 0) break;
            }
        }

        $remaining = $budget;
        $ep        = 'COALESCE(components.base_price, cp.price)';
        $socket    = null;
        $ddrGen    = null;
        $cpuTdp    = 65;
        $vgaTdp    = 0;

        // Helper to sum floors of remaining components to avoid overspending in fallbacks
        $remainingFloors = function (array $slots) use ($floors, $alloc) {
            $sum = 0;
            foreach ($slots as $slot) {
                if (isset($alloc[$slot]) && $alloc[$slot] > 0) {
                    $sum += $floors[$slot] ?? 500000;
                }
            }
            return $sum;
        };

        // ── 1. CPU ────────────────────────────────────────────────────────────
        $cpuMin = $needsGpu ? 1200000 : 0;
        $reserve = $remainingFloors(['mainboard', 'ram', 'vga', 'storage', 'psu', 'case']);
        $cpuMax = min($alloc['cpu'], $remaining - $reserve);

        // Subquery helper to make sure picked CPU has at least one matching motherboard in the DB
        $hasMb = function ($q) use ($budget) {
            $q->whereIn('cpus.socket', function ($sub) use ($budget) {
                $sub->select('socket')->from('motherboards');
                if ($budget < 12000000) {
                    $sub->where('socket', '!=', 'AM5');
                }
            });
        };

        // 0. Try AMD X3D CPU first for gaming builds if brand is AMD or any
        $cpu = null;
        if ($buildType === 'gaming' && in_array($cpuBrand, ['amd', 'any'])) {
            $cpu = $this->pickByBudget(1, 'cpus', $cpuMax, function ($q) use ($cpuMin, $ep, $hasMb) {
                $q->whereRaw('LOWER(components.name) LIKE ?', ['%x3d%']);
                if ($cpuMin > 0) $q->whereRaw("{$ep} >= CAST(? AS NUMERIC)", [$cpuMin]);
                $hasMb($q);
            });
        }

        // 1. Try with requested brand within cpuMax
        if (!$cpu) {
            $cpu = $this->pickByBudget(1, 'cpus', $cpuMax, function ($q) use ($cpuBrand, $cpuMin, $ep, $hasMb) {
                if ($cpuBrand !== 'any') $q->whereRaw('LOWER(components.name) LIKE ?', ['%' . strtolower($cpuBrand) . '%']);
                if ($cpuMin > 0)        $q->whereRaw("{$ep} >= CAST(? AS NUMERIC)", [$cpuMin]);
                $hasMb($q);
            });
        }
        
        // 2. Fallback: Try with any brand within cpuMax
        if (!$cpu && $cpuBrand !== 'any') {
            $cpu = $this->pickByBudget(1, 'cpus', $cpuMax, function ($q) use ($cpuMin, $ep, $hasMb) {
                if ($cpuMin > 0) $q->whereRaw("{$ep} >= CAST(? AS NUMERIC)", [$cpuMin]);
                $hasMb($q);
            });
        }
        
        // 3. Fallback: Try with requested brand up to remaining budget (reserving other slots)
        if (!$cpu) {
            $cpuLimit = max($cpuMax, $remaining - $reserve);
            $cpu = $this->pickByBudget(1, 'cpus', $cpuLimit, function ($q) use ($cpuBrand, $cpuMin, $ep, $hasMb) {
                if ($cpuBrand !== 'any') $q->whereRaw('LOWER(components.name) LIKE ?', ['%' . strtolower($cpuBrand) . '%']);
                if ($cpuMin > 0)        $q->whereRaw("{$ep} >= CAST(? AS NUMERIC)", [$cpuMin]);
                $hasMb($q);
            }, true);
        }
        
        // 4. Fallback: Try with any brand up to remaining budget (reserving other slots)
        if (!$cpu) {
            $cpuLimit = max($cpuMax, $remaining - $reserve);
            $cpu = $this->pickByBudget(1, 'cpus', $cpuLimit, function ($q) use ($cpuMin, $ep, $hasMb) {
                if ($cpuMin > 0) $q->whereRaw("{$ep} >= CAST(? AS NUMERIC)", [$cpuMin]);
                $hasMb($q);
            }, true);
        }
        
        // 5. Ultimate Fallback: Select the absolute cheapest compatible CPU in the database
        if (!$cpu) {
            $cpu = DB::table('components')
                ->join('cpus', 'cpus.component_id', '=', 'components.id')
                ->leftJoin(
                    DB::raw('(SELECT component_id, MIN(price) as price FROM component_prices GROUP BY component_id) cp'),
                    'cp.component_id', '=', 'components.id'
                )
                ->where('components.type_id', 1)
                ->whereRaw("{$ep} > 0")
                ->whereIn('cpus.socket', function ($sub) {
                    $sub->select('socket')->from('motherboards');
                })
                ->select('components.id', 'components.name', DB::raw("{$ep} as price"))
                ->orderBy('price')
                ->first();
        }

        if ($cpu) {
            $price = (float)$cpu->price;
            $build['components']['cpu'] = ['id' => $cpu->id, 'name' => $cpu->name, 'price' => $price, 'image' => true];
            $build['total_price'] += $price;
            $remaining -= $price;
            $cpuSpec = DB::table('cpus')->where('component_id', $cpu->id)->first();
            $socket  = $cpuSpec->socket ?? null;
            $cpuTdp  = $cpuSpec->tdp   ?? 65;
        }

        // ── 2. MAINBOARD ──────────────────────────────────────────────────────
        $cpuPrice = isset($cpu) ? (float)$cpu->price : 0;
        $cpuName  = isset($cpu) ? strtolower($cpu->name) : '';
        $isHighEndCpu = ($cpuPrice > 4000000)
            || preg_match('/\b(k|kf|ks|x3d)\b/i', $cpuName)
            || str_contains($cpuName, 'ryzen 7')
            || str_contains($cpuName, 'ryzen 9')
            || str_contains($cpuName, 'i7-')
            || str_contains($cpuName, 'i9-');

        $excludedChipsets = [];
        if ($cpuPrice > 9000000) {
            $excludedChipsets = ['A320','A620','H610','B450','H510','H410','B460','B560','H610','H710'];
        } elseif ($isHighEndCpu) {
            $excludedChipsets = ['A320','A620','H610','H510','H410'];
        } elseif ($cpuPrice > 0 && $cpuPrice < 3000000) {
            // Budget CPU: exclude expensive/mid-range chipsets to prioritize cheaper ones
            $excludedChipsets = ['B550', 'X570', 'B650', 'X670', 'B660', 'B760', 'Z690', 'Z790', 'H770', 'Z890', 'B850', 'X870'];
        }
        $reserve = $remainingFloors(['ram', 'vga', 'storage', 'psu', 'case']);
        $mbMax = min($alloc['mainboard'], $remaining - $reserve);
        
        // 1. Try with chipset filter within mbMax
        $mb = $this->pickByBudget(5, 'motherboards', $mbMax, function ($q) use ($socket, $excludedChipsets) {
            if ($socket) $q->where('motherboards.socket', $socket);
            foreach ($excludedChipsets as $chip) {
                $q->whereRaw('LOWER(components.name) NOT LIKE ?', ['%' . strtolower($chip) . '%']);
            }
        });
        
        // 2. Fallback: Skip chipset filter within mbMax
        if (!$mb && $socket) {
            $mb = $this->pickByBudget(5, 'motherboards', $mbMax, function ($q) use ($socket) {
                $q->where('motherboards.socket', $socket);
            });
        }
        
        // 3. Fallback: Try with chipset filter up to remaining budget (reserving other slots)
        if (!$mb && $socket) {
            $reserve = $remainingFloors(['ram', 'vga', 'storage', 'psu', 'case']);
            $mbLimit = max($mbMax, $remaining - $reserve);
            $mb = $this->pickByBudget(5, 'motherboards', $mbLimit, function ($q) use ($socket, $excludedChipsets) {
                $q->where('motherboards.socket', $socket);
                foreach ($excludedChipsets as $chip) {
                    $q->whereRaw('LOWER(components.name) NOT LIKE ?', ['%' . strtolower($chip) . '%']);
                }
            }, true);
        }
        
        // 4. Fallback: Skip chipset filter up to remaining budget (reserving other slots)
        if (!$mb && $socket) {
            $reserve = $remainingFloors(['ram', 'vga', 'storage', 'psu', 'case']);
            $mbLimit = max($mbMax, $remaining - $reserve);
            $mb = $this->pickByBudget(5, 'motherboards', $mbLimit, function ($q) use ($socket) {
                $q->where('motherboards.socket', $socket);
            }, true);
        }
        
        // 5. Ultimate Fallback: Select the absolute cheapest compatible motherboard in the database
        if (!$mb && $socket) {
            $mb = DB::table('components')
                ->join('motherboards', 'motherboards.component_id', '=', 'components.id')
                ->leftJoin(
                    DB::raw('(SELECT component_id, MIN(price) as price FROM component_prices GROUP BY component_id) cp'),
                    'cp.component_id', '=', 'components.id'
                )
                ->where('components.type_id', 5)
                ->whereRaw("{$ep} > 0")
                ->where('motherboards.socket', $socket)
                ->select('components.id', 'components.name', DB::raw("{$ep} as price"))
                ->orderBy('price')
                ->first();
        }
        
        if ($mb) {
            $price = (float)$mb->price;
            $build['components']['mainboard'] = ['id' => $mb->id, 'name' => $mb->name, 'price' => $price, 'image' => true];
            $build['total_price'] += $price;
            $remaining -= $price;
            $mbSpec = DB::table('motherboards')->where('component_id', $mb->id)->first();
            $ddrGen = $mbSpec->ddr_gen ?? null;
        }

        // ── 3. RAM ────────────────────────────────────────────────────────────
        $ramCapacity = $needsGpu ? 16 : 8;
        $reserve = $remainingFloors(['vga', 'storage', 'psu', 'case']);
        $ramMax      = min($alloc['ram'], $remaining - $reserve);
        
        // 1. Try with target capacity and DDR gen within ramMax
        $ram = $this->pickByBudget(3, 'memory', $ramMax, function ($q) use ($ramCapacity, $ddrGen) {
            $q->where('memory.capacity', '>=', $ramCapacity);
            if ($ddrGen) $q->where('memory.ddr_gen', $ddrGen);
        });
        
        // 2. Fallback: Try with target capacity and DDR gen up to remaining budget (reserving other slots)
        if (!$ram) {
            $reserve = $remainingFloors(['vga', 'storage', 'psu', 'case']);
            $ramLimit = max($ramMax, $remaining - $reserve);
            $ram = $this->pickByBudget(3, 'memory', $ramLimit, function ($q) use ($ramCapacity, $ddrGen) {
                $q->where('memory.capacity', '>=', $ramCapacity);
                if ($ddrGen) $q->where('memory.ddr_gen', $ddrGen);
            }, true);
        }
        
        // 3. Fallback: Lower capacity to 8GB (for gaming) within ramMax
        if (!$ram && $ramCapacity > 8) {
            $ram = $this->pickByBudget(3, 'memory', $ramMax, function ($q) use ($ddrGen) {
                $q->where('memory.capacity', '>=', 8);
                if ($ddrGen) $q->where('memory.ddr_gen', $ddrGen);
            });
        }
        
        // 4. Fallback: Lower capacity to 8GB (for gaming) up to remaining budget (reserving other slots)
        if (!$ram && $ramCapacity > 8) {
            $reserve = $remainingFloors(['vga', 'storage', 'psu', 'case']);
            $ramLimit = max($ramMax, $remaining - $reserve);
            $ram = $this->pickByBudget(3, 'memory', $ramLimit, function ($q) use ($ddrGen) {
                $q->where('memory.capacity', '>=', 8);
                if ($ddrGen) $q->where('memory.ddr_gen', $ddrGen);
            }, true);
        }
        
        // 5. Fallback: Lower capacity to 4GB up to remaining budget (reserving other slots), skipping DDR check if needed
        if (!$ram) {
            $reserve = $remainingFloors(['vga', 'storage', 'psu', 'case']);
            $ramLimit = max($ramMax, $remaining - $reserve);
            $ram = $this->pickByBudget(3, 'memory', $ramLimit, function ($q) {
                $q->where('memory.capacity', '>=', 4);
            }, true);
        }
        
        // 6. Ultimate Fallback: Select the absolute cheapest compatible RAM in the database
        if (!$ram) {
            $ram = DB::table('components')
                ->join('memory', 'memory.component_id', '=', 'components.id')
                ->leftJoin(
                    DB::raw('(SELECT component_id, MIN(price) as price FROM component_prices GROUP BY component_id) cp'),
                    'cp.component_id', '=', 'components.id'
                )
                ->where('components.type_id', 3)
                ->whereRaw("{$ep} > 0")
                ->when($ddrGen, function ($q) use ($ddrGen) {
                    $q->where('memory.ddr_gen', $ddrGen);
                })
                ->select('components.id', 'components.name', DB::raw("{$ep} as price"))
                ->orderBy('price')
                ->first();
        }

        if ($ram) {
            $price = (float)$ram->price;
            $build['components']['ram'] = ['id' => $ram->id, 'name' => $ram->name, 'price' => $price, 'image' => true];
            $build['total_price'] += $price;
            $remaining -= $price;
        }

        // ── 4. VGA ────────────────────────────────────────────────────────────
        if ($needsGpu && $remaining > 1000000) {
            $reserve = $remainingFloors(['storage', 'psu', 'case']);
            $vgaMax = min($alloc['vga'], $remaining - $reserve);
            if ($vgaMax > 0) {
                $vga = $this->pickByBudget(2, 'video_cards', $vgaMax);
                if ($vga) {
                    $price   = (float)$vga->price;
                    $vgaName = $vga->name . (!empty($vga->chipset) ? ' (' . $vga->chipset . ')' : '');
                    $build['components']['vga'] = ['id' => $vga->id, 'name' => $vgaName, 'price' => $price, 'image' => true];
                    $build['total_price'] += $price;
                    $remaining -= $price;
                    $vgaSpec = DB::table('video_cards')->where('component_id', $vga->id)->first();
                    $vgaTdp  = $vgaSpec->tdp ?? 0;
                }
            }
        }
        
        // Fallback: If GPU is required but still missing, force pick cheapest VGA up to remaining (reserving storage/psu/case)
        if ($needsGpu && !isset($build['components']['vga']) && $remaining > 1950000) {
            $reserve = $remainingFloors(['storage', 'psu', 'case']);
            $vgaLimit = max(0.0, $remaining - $reserve);
            $vga = $this->pickByBudget(2, 'video_cards', $vgaLimit, null, true);
            if ($vga) {
                $price   = (float)$vga->price;
                $vgaName = $vga->name . (!empty($vga->chipset) ? ' (' . $vga->chipset . ')' : '');
                $build['components']['vga'] = ['id' => $vga->id, 'name' => $vgaName, 'price' => $price, 'image' => true];
                $build['total_price'] += $price;
                $remaining -= $price;
                $vgaSpec = DB::table('video_cards')->where('component_id', $vga->id)->first();
                $vgaTdp  = $vgaSpec->tdp ?? 0;
            }
        }

        // ── 5. STORAGE ────────────────────────────────────────────────────────
        $storageMin = $needsGpu ? 256 : 120;
        $reserve = $remainingFloors(['psu', 'case']);
        $storageMax = min($alloc['storage'], $remaining - $reserve);
        
        // 1. Try SSD with standard capacity within storageMax
        $storage = $this->pickByBudget(4, 'internal_hard_drives', $storageMax, function ($q) use ($storageMin) {
            $q->where('internal_hard_drives.capacity', '>=', $storageMin)
              ->where('internal_hard_drives.type', 'SSD');
        });
        
        // 2. Fallback: SSD lower capacity within storageMax
        if (!$storage && $storageMin > 120) {
            $storage = $this->pickByBudget(4, 'internal_hard_drives', $storageMax, function ($q) {
                $q->where('internal_hard_drives.capacity', '>=', 120)
                  ->where('internal_hard_drives.type', 'SSD');
            });
        }
        
        // 3. Fallback: SSD even lower capacity (60GB) within storageMax
        if (!$storage) {
            $storage = $this->pickByBudget(4, 'internal_hard_drives', $storageMax, function ($q) {
                $q->where('internal_hard_drives.capacity', '>=', 60)
                  ->where('internal_hard_drives.type', 'SSD');
            });
        }
        
        // 4. Fallback: SSD standard capacity up to remaining budget (reserving other slots)
        if (!$storage) {
            $reserve = $remainingFloors(['psu', 'case']);
            $storageLimit = max($storageMax, $remaining - $reserve);
            $storage = $this->pickByBudget(4, 'internal_hard_drives', $storageLimit, function ($q) use ($storageMin) {
                $q->where('internal_hard_drives.capacity', '>=', $storageMin)
                  ->where('internal_hard_drives.type', 'SSD');
            }, true);
        }
        
        // 5. Fallback: SSD lower capacity up to remaining budget (reserving other slots)
        if (!$storage && $storageMin > 120) {
            $reserve = $remainingFloors(['psu', 'case']);
            $storageLimit = max($storageMax, $remaining - $reserve);
            $storage = $this->pickByBudget(4, 'internal_hard_drives', $storageLimit, function ($q) {
                $q->where('internal_hard_drives.capacity', '>=', 120)
                  ->where('internal_hard_drives.type', 'SSD');
            }, true);
        }

        // 5.1. Fallback: SSD even lower capacity (60GB) up to remaining budget
        if (!$storage) {
            $reserve = $remainingFloors(['psu', 'case']);
            $storageLimit = max($storageMax, $remaining - $reserve);
            $storage = $this->pickByBudget(4, 'internal_hard_drives', $storageLimit, function ($q) {
                $q->where('internal_hard_drives.capacity', '>=', 60)
                  ->where('internal_hard_drives.type', 'SSD');
            }, true);
        }
        
        // 6. Fallback: HDD standard capacity within storageMax
        if (!$storage) {
            $storage = $this->pickByBudget(4, 'internal_hard_drives', $storageMax, function ($q) use ($storageMin) {
                $q->where('internal_hard_drives.capacity', '>=', $storageMin);
            });
        }
        
        // 7. Fallback: HDD standard capacity up to remaining budget (reserving other slots)
        if (!$storage) {
            $reserve = $remainingFloors(['psu', 'case']);
            $storageLimit = max($storageMax, $remaining - $reserve);
            $storage = $this->pickByBudget(4, 'internal_hard_drives', $storageLimit, function ($q) use ($storageMin) {
                $q->where('internal_hard_drives.capacity', '>=', $storageMin);
            }, true);
        }
        
        // 8. Fallback: Any storage up to remaining budget (reserving other slots)
        if (!$storage) {
            $reserve = $remainingFloors(['psu', 'case']);
            $storageLimit = max($storageMax, $remaining - $reserve);
            $storage = $this->pickByBudget(4, 'internal_hard_drives', $storageLimit, null, true);
        }
        
        // 9. Ultimate Fallback: Try cheapest SSD first, then any cheapest storage
        if (!$storage) {
            $storage = DB::table('components')
                ->join('internal_hard_drives', 'internal_hard_drives.component_id', '=', 'components.id')
                ->leftJoin(
                    DB::raw('(SELECT component_id, MIN(price) as price FROM component_prices GROUP BY component_id) cp'),
                    'cp.component_id', '=', 'components.id'
                )
                ->where('components.type_id', 4)
                ->whereRaw("{$ep} > 0")
                ->where('internal_hard_drives.type', 'SSD')
                ->select('components.id', 'components.name', 'internal_hard_drives.capacity', 'internal_hard_drives.type', DB::raw("{$ep} as price"))
                ->orderBy('price')
                ->first();
        }
        if (!$storage) {
            $storage = DB::table('components')
                ->join('internal_hard_drives', 'internal_hard_drives.component_id', '=', 'components.id')
                ->leftJoin(
                    DB::raw('(SELECT component_id, MIN(price) as price FROM component_prices GROUP BY component_id) cp'),
                    'cp.component_id', '=', 'components.id'
                )
                ->where('components.type_id', 4)
                ->whereRaw("{$ep} > 0")
                ->select('components.id', 'components.name', 'internal_hard_drives.capacity', 'internal_hard_drives.type', DB::raw("{$ep} as price"))
                ->orderBy('price')
                ->first();
        }
        
        if ($storage) {
            $price = (float)$storage->price;
            $capStr = ($storage->capacity >= 1000) ? (($storage->capacity / 1000) . 'TB') : ($storage->capacity . 'GB');
            $storageName = $storage->name;
            if (!empty($storage->capacity) && !empty($storage->type)) {
                $storageName .= ' (' . $capStr . ' ' . $storage->type . ')';
            }
            $build['components']['storage'] = ['id' => $storage->id, 'name' => $storageName, 'price' => $price, 'image' => true];
            $build['total_price'] += $price;
            $remaining -= $price;
        }

        // ── 6. PSU ────────────────────────────────────────────────────────────
        $requiredWatt = $cpuTdp + $vgaTdp + ($vgaTdp > 0 ? 220 : 150);
        $reserve = $remainingFloors(['case']);
        $psuMax       = min($alloc['psu'], $remaining - $reserve);
        $psu = $this->pickByBudget(6, 'power_supplies', $psuMax, function ($q) use ($requiredWatt) {
            $q->where('power_supplies.wattage', '>=', $requiredWatt);
        });
        if (!$psu) {
            $reserve = $remainingFloors(['case']);
            $psuLimit = max($psuMax, $remaining - $reserve);
            $psu = $this->pickByBudget(6, 'power_supplies', $psuLimit, function ($q) use ($requiredWatt) {
                $q->where('power_supplies.wattage', '>=', $requiredWatt);
            }, true);
        }
        
        // 3. Ultimate Fallback: Select the absolute cheapest PSU in the database
        if (!$psu) {
            $psu = DB::table('components')
                ->join('power_supplies', 'power_supplies.component_id', '=', 'components.id')
                ->leftJoin(
                    DB::raw('(SELECT component_id, MIN(price) as price FROM component_prices GROUP BY component_id) cp'),
                    'cp.component_id', '=', 'components.id'
                )
                ->where('components.type_id', 6)
                ->whereRaw("{$ep} > 0")
                ->select('components.id', 'components.name', DB::raw("{$ep} as price"))
                ->orderBy('price')
                ->first();
        }
        
        if ($psu) {
            $price = (float)$psu->price;
            $build['components']['psu'] = ['id' => $psu->id, 'name' => $psu->name, 'price' => $price, 'image' => true];
            $build['total_price'] += $price;
            $remaining -= $price;
        }

        // ── 7. CASE ───────────────────────────────────────────────────────────
        $caseMax = min($alloc['case'], $remaining);
        $case    = $this->pickByBudget(8, 'cases', $caseMax);
        if (!$case) $case = $this->pickByBudget(8, 'cases', $remaining, null, true);
        
        // Ultimate Fallback: Select the absolute cheapest case in the database
        if (!$case) {
            $case = DB::table('components')
                ->join('cases', 'cases.component_id', '=', 'components.id')
                ->leftJoin(
                    DB::raw('(SELECT component_id, MIN(price) as price FROM component_prices GROUP BY component_id) cp'),
                    'cp.component_id', '=', 'components.id'
                )
                ->where('components.type_id', 8)
                ->whereRaw("{$ep} > 0")
                ->select('components.id', 'components.name', DB::raw("{$ep} as price"))
                ->orderBy('price')
                ->first();
        }
        
        if ($case) {
            $price = (float)$case->price;
            $build['components']['case'] = ['id' => $case->id, 'name' => $case->name, 'price' => $price, 'image' => true];
            $build['total_price'] += $price;
            $remaining -= $price;
        }

        $build = $this->upgradeBuild($build, $budget, $buildType, $cpuBrand, $needsGpu);

        // Sắp xếp các linh kiện theo thứ tự tiêu chuẩn
        $orderedKeys = ['cpu', 'mainboard', 'ram', 'vga', 'storage', 'psu', 'case'];
        $orderedComponents = [];
        foreach ($orderedKeys as $key) {
            if (isset($build['components'][$key])) {
                $orderedComponents[$key] = $build['components'][$key];
            }
        }
        $build['components'] = $orderedComponents;

        return $build;
    }

    // ─────────────────────────────────────────────────────────────────────────
    // HELPER: Chọn linh kiện tốt nhất trong budget
    // ─────────────────────────────────────────────────────────────────────────
    private function pickByBudget(int $typeId, string $specTable, float $maxBudget, ?\Closure $filter = null, bool $asc = false): ?object
    {
        $ep          = 'COALESCE(components.base_price, cp.price)';
        $selectExtra = [];
        if ($specTable === 'video_cards') {
            $selectExtra = ['video_cards.chipset'];
        } elseif ($specTable === 'internal_hard_drives') {
            $selectExtra = ['internal_hard_drives.capacity', 'internal_hard_drives.type'];
        }

        $q = DB::table('components')
            ->join($specTable, "{$specTable}.component_id", '=', 'components.id')
            ->leftJoin(
                DB::raw('(SELECT component_id, MIN(price) as price FROM component_prices GROUP BY component_id) cp'),
                'cp.component_id', '=', 'components.id'
            )
            ->where('components.type_id', $typeId)
            ->whereRaw("{$ep} > 0")
            ->whereRaw("{$ep} <= CAST(? AS NUMERIC)", [$maxBudget])
            ->select(array_merge(['components.id', 'components.name', DB::raw("{$ep} as price")], $selectExtra));

        if ($filter) $filter($q);

        if ($asc) {
            $q->orderBy('price');
        } else {
            $q->orderByDesc('price');
        }

        return $q->first();
    }

    // ─────────────────────────────────────────────────────────────────────────
    // HELPERS: Tra cứu linh kiện phục vụ AI Function Calling (Agent Tool Use)
    // ─────────────────────────────────────────────────────────────────────────
    private function searchCpus(float $maxPrice, ?string $socket = null): array
    {
        $ep = 'COALESCE(components.base_price, cp.price)';
        return DB::table('components')
            ->join('cpus', 'cpus.component_id', '=', 'components.id')
            ->leftJoin(
                DB::raw('(SELECT component_id, MIN(price) as price FROM component_prices GROUP BY component_id) cp'),
                'cp.component_id', '=', 'components.id'
            )
            ->where('components.type_id', 1)
            ->whereRaw("{$ep} > 0")
            ->whereRaw("{$ep} <= ?", [$maxPrice])
            ->when($socket, function($q) use ($socket) {
                $q->where('cpus.socket', $socket);
            })
            ->select('components.id', 'components.name', DB::raw("{$ep} as price"), 'cpus.socket', 'cpus.tdp')
            ->orderByDesc('price')
            ->limit(2)
            ->get()
            ->toArray();
    }

    private function searchMotherboards(?string $socket = null, ?int $ddrGen = null, ?float $maxPrice = null): array
    {
        $ep = 'COALESCE(components.base_price, cp.price)';
        return DB::table('components')
            ->join('motherboards', 'motherboards.component_id', '=', 'components.id')
            ->leftJoin(
                DB::raw('(SELECT component_id, MIN(price) as price FROM component_prices GROUP BY component_id) cp'),
                'cp.component_id', '=', 'components.id'
            )
            ->where('components.type_id', 5)
            ->whereRaw("{$ep} > 0")
            ->when($maxPrice, function($q) use ($maxPrice) {
                $q->whereRaw("COALESCE(components.base_price, cp.price) <= ?", [$maxPrice]);
            })
            ->when($socket, function($q) use ($socket) {
                $q->where('motherboards.socket', $socket);
            })
            ->when($ddrGen, function($q) use ($ddrGen) {
                $q->where('motherboards.ddr_gen', $ddrGen);
            })
            ->select('components.id', 'components.name', DB::raw("{$ep} as price"), 'motherboards.socket', 'motherboards.ddr_gen')
            ->orderByDesc('price')
            ->limit(2)
            ->get()
            ->toArray();
    }

    private function searchVideoCards(?float $maxPrice = null): array
    {
        $ep = 'COALESCE(components.base_price, cp.price)';
        return DB::table('components')
            ->join('video_cards', 'video_cards.component_id', '=', 'components.id')
            ->leftJoin(
                DB::raw('(SELECT component_id, MIN(price) as price FROM component_prices GROUP BY component_id) cp'),
                'cp.component_id', '=', 'components.id'
            )
            ->where('components.type_id', 2)
            ->whereRaw("{$ep} > 0")
            ->when($maxPrice, function($q) use ($maxPrice) {
                $q->whereRaw("COALESCE(components.base_price, cp.price) <= ?", [$maxPrice]);
            })
            ->select('components.id', 'components.name', DB::raw("{$ep} as price"), 'video_cards.tdp', 'video_cards.chipset')
            ->orderByDesc('price')
            ->limit(2)
            ->get()
            ->toArray();
    }

    private function searchMemory(?int $ddrGen = null, ?float $maxPrice = null): array
    {
        $ep = 'COALESCE(components.base_price, cp.price)';
        return DB::table('components')
            ->join('memory', 'memory.component_id', '=', 'components.id')
            ->leftJoin(
                DB::raw('(SELECT component_id, MIN(price) as price FROM component_prices GROUP BY component_id) cp'),
                'cp.component_id', '=', 'components.id'
            )
            ->where('components.type_id', 3)
            ->whereRaw("{$ep} > 0")
            ->when($maxPrice, function($q) use ($maxPrice) {
                $q->whereRaw("COALESCE(components.base_price, cp.price) <= ?", [$maxPrice]);
            })
            ->when($ddrGen, function($q) use ($ddrGen) {
                $q->where('memory.ddr_gen', $ddrGen);
            })
            ->select('components.id', 'components.name', DB::raw("{$ep} as price"), 'memory.capacity', 'memory.ddr_gen')
            ->orderByDesc('price')
            ->limit(2)
            ->get()
            ->toArray();
    }

    private function searchPowerSupplies(?float $wattage = null, ?float $maxPrice = null): array
    {
        $ep = 'COALESCE(components.base_price, cp.price)';
        return DB::table('components')
            ->join('power_supplies', 'power_supplies.component_id', '=', 'components.id')
            ->leftJoin(
                DB::raw('(SELECT component_id, MIN(price) as price FROM component_prices GROUP BY component_id) cp'),
                'cp.component_id', '=', 'components.id'
            )
            ->where('components.type_id', 6)
            ->whereRaw("{$ep} > 0")
            ->when($maxPrice, function($q) use ($maxPrice) {
                $q->whereRaw("COALESCE(components.base_price, cp.price) <= ?", [$maxPrice]);
            })
            ->when($wattage, function($q) use ($wattage) {
                $q->where('power_supplies.wattage', '>=', $wattage);
            })
            ->select('components.id', 'components.name', DB::raw("{$ep} as price"), 'power_supplies.wattage')
            ->orderBy('price')
            ->limit(2)
            ->get()
            ->toArray();
    }

    private function getStoreCatalog(float $budget): array
    {
        return [
            'cpus'           => $this->searchCpus($budget * 0.4),
            'motherboards'   => $this->searchMotherboards(null, null, $budget * 0.3),
            'video_cards'    => $this->searchVideoCards($budget * 0.6),
            'memory'         => $this->searchMemory(null, $budget * 0.15),
            'power_supplies' => $this->searchPowerSupplies(null, $budget * 0.1),
            'storage'        => $this->searchStorage(null, $budget * 0.15),
            'cases'          => $this->searchCases($budget * 0.08)
        ];
    }

    private function searchStorage(?string $type = 'SSD', ?float $maxPrice = null): array
    {
        $ep = 'COALESCE(components.base_price, cp.price)';
        return DB::table('components')
            ->join('internal_hard_drives', 'internal_hard_drives.component_id', '=', 'components.id')
            ->leftJoin(
                DB::raw('(SELECT component_id, MIN(price) as price FROM component_prices GROUP BY component_id) cp'),
                'cp.component_id', '=', 'components.id'
            )
            ->where('components.type_id', 4)
            ->whereRaw("{$ep} > 0")
            ->when($maxPrice, function($q) use ($maxPrice) {
                $q->whereRaw("COALESCE(components.base_price, cp.price) <= ?", [$maxPrice]);
            })
            ->when($type, function($q) use ($type) {
                $q->where('internal_hard_drives.type', $type);
            })
            ->select('components.id', 'components.name', DB::raw("{$ep} as price"), 'internal_hard_drives.capacity', 'internal_hard_drives.type')
            ->orderByDesc('price')
            ->limit(2)
            ->get()
            ->toArray();
    }

    private function searchCases(?float $maxPrice = null): array
    {
        $ep = 'COALESCE(components.base_price, cp.price)';
        return DB::table('components')
            ->join('cases', 'cases.component_id', '=', 'components.id')
            ->leftJoin(
                DB::raw('(SELECT component_id, MIN(price) as price FROM component_prices GROUP BY component_id) cp'),
                'cp.component_id', '=', 'components.id'
            )
            ->where('components.type_id', 8)
            ->whereRaw("{$ep} > 0")
            ->when($maxPrice, function($q) use ($maxPrice) {
                $q->whereRaw("COALESCE(components.base_price, cp.price) <= ?", [$maxPrice]);
            })
            ->select('components.id', 'components.name', DB::raw("{$ep} as price"))
            ->orderByDesc('price')
            ->limit(2)
            ->get()
            ->toArray();
    }

    // ─────────────────────────────────────────────────────────────────────────
    // Helper: Nâng cấp tuần hoàn các linh kiện để tối ưu hóa ngân sách thừa
    // ─────────────────────────────────────────────────────────────────────────
    private function upgradeBuild(array $build, float $budget, string $buildType, string $cpuBrand, bool $needsGpu): array
    {
        $remaining = $budget - $build['total_price'];
        if ($remaining < 200000) {
            return $build;
        }

        $cpuSpec = isset($build['components']['cpu']) ? DB::table('cpus')->where('component_id', $build['components']['cpu']['id'])->first() : null;
        $mbSpec  = isset($build['components']['mainboard']) ? DB::table('motherboards')->where('component_id', $build['components']['mainboard']['id'])->first() : null;
        $ramSpec = isset($build['components']['ram']) ? DB::table('memory')->where('component_id', $build['components']['ram']['id'])->first() : null;

        $socket  = $cpuSpec->socket ?? $mbSpec->socket ?? null;
        $ddrGen  = $mbSpec->ddr_gen ?? $ramSpec->ddr_gen ?? null;
        $cpuMin  = $needsGpu ? 1200000 : 0;
        $storageMin = $needsGpu ? 256 : 120;
        $ep      = 'COALESCE(components.base_price, cp.price)';

        $cpuTdp  = $cpuSpec->tdp ?? 65;
        $vgaSpec = isset($build['components']['vga']) ? DB::table('video_cards')->where('component_id', $build['components']['vga']['id'])->first() : null;
        $vgaTdp  = $vgaSpec->tdp ?? 0;

        $hasMb = function ($q) use ($budget) {
            $q->whereIn('cpus.socket', function ($sub) use ($budget) {
                $sub->select('socket')->from('motherboards');
                if ($budget < 12000000) {
                    $sub->where('socket', '!=', 'AM5');
                }
            });
        };

        $upgradedAny = true;
        while ($remaining >= 200000 && $upgradedAny) {
            $upgradedAny = false;

            // 1. Nâng cấp hoặc Thêm VGA (nếu needsGpu và còn thừa tiền)
            if ($needsGpu && $remaining >= 200000) {
                if (isset($build['components']['vga'])) {
                    $currentVgaPrice = $build['components']['vga']['price'];
                    $betterVga       = $this->pickByBudget(2, 'video_cards', $currentVgaPrice + $remaining);
                    if ($betterVga && (float)$betterVga->price > $currentVgaPrice) {
                        $diff    = (float)$betterVga->price - $currentVgaPrice;
                        
                        // Check if PSU wattage needs to increase
                        $betterVgaSpec = DB::table('video_cards')->where('component_id', $betterVga->id)->first();
                        $betterVgaTdp = $betterVgaSpec->tdp ?? 0;
                        $requiredWatt = $cpuTdp + $betterVgaTdp + ($betterVgaTdp > 0 ? 220 : 150);
                        
                        $currentPsuPrice = $build['components']['psu']['price'] ?? 0;
                        $psuSpec = isset($build['components']['psu']) ? DB::table('power_supplies')->where('component_id', $build['components']['psu']['id'])->first() : null;
                        $psuWatt = $psuSpec->wattage ?? 0;
                        
                        if ($psuWatt < $requiredWatt) {
                            $betterPsu = $this->pickByBudget(6, 'power_supplies', $currentPsuPrice + ($remaining - $diff), function ($q) use ($requiredWatt) {
                                $q->where('power_supplies.wattage', '>=', $requiredWatt);
                            }, true);
                            if ($betterPsu) {
                                $psuDiff = (float)$betterPsu->price - $currentPsuPrice;
                                $vgaName = $betterVga->name . (!empty($betterVga->chipset) ? ' (' . $betterVga->chipset . ')' : '');
                                $build['components']['vga'] = ['id' => $betterVga->id, 'name' => $vgaName, 'price' => (float)$betterVga->price, 'image' => true];
                                $build['components']['psu'] = ['id' => $betterPsu->id, 'name' => $betterPsu->name, 'price' => (float)$betterPsu->price, 'image' => true];
                                $build['total_price'] += ($diff + $psuDiff);
                                $remaining -= ($diff + $psuDiff);
                                $vgaTdp = $betterVgaTdp;
                                $upgradedAny = true;
                            }
                        } else {
                            $vgaName = $betterVga->name . (!empty($betterVga->chipset) ? ' (' . $betterVga->chipset . ')' : '');
                            $build['components']['vga'] = ['id' => $betterVga->id, 'name' => $vgaName, 'price' => (float)$betterVga->price, 'image' => true];
                            $build['total_price'] += $diff;
                            $remaining -= $diff;
                            $vgaTdp = $betterVgaTdp;
                            $upgradedAny = true;
                        }
                    }
                } else {
                    // No VGA present but needsGpu is true. Add a VGA from scratch!
                    $betterVga = $this->pickByBudget(2, 'video_cards', $remaining);
                    if ($betterVga) {
                        $diff = (float)$betterVga->price;
                        
                        // Check PSU compatibility
                        $betterVgaSpec = DB::table('video_cards')->where('component_id', $betterVga->id)->first();
                        $betterVgaTdp = $betterVgaSpec->tdp ?? 0;
                        $requiredWatt = $cpuTdp + $betterVgaTdp + ($betterVgaTdp > 0 ? 220 : 150);
                        
                        $currentPsuPrice = $build['components']['psu']['price'] ?? 0;
                        $psuSpec = isset($build['components']['psu']) ? DB::table('power_supplies')->where('component_id', $build['components']['psu']['id'])->first() : null;
                        $psuWatt = $psuSpec->wattage ?? 0;
                        
                        if ($psuWatt < $requiredWatt) {
                            $betterPsu = $this->pickByBudget(6, 'power_supplies', $currentPsuPrice + ($remaining - $diff), function ($q) use ($requiredWatt) {
                                $q->where('power_supplies.wattage', '>=', $requiredWatt);
                            }, true);
                            if ($betterPsu) {
                                $psuDiff = (float)$betterPsu->price - $currentPsuPrice;
                                $vgaName = $betterVga->name . (!empty($betterVga->chipset) ? ' (' . $betterVga->chipset . ')' : '');
                                $build['components']['vga'] = ['id' => $betterVga->id, 'name' => $vgaName, 'price' => $diff, 'image' => true];
                                $build['components']['psu'] = ['id' => $betterPsu->id, 'name' => $betterPsu->name, 'price' => (float)$betterPsu->price, 'image' => true];
                                $build['total_price'] += ($diff + $psuDiff);
                                $remaining -= ($diff + $psuDiff);
                                $vgaTdp = $betterVgaTdp;
                                $upgradedAny = true;
                            }
                        } else {
                            $vgaName = $betterVga->name . (!empty($betterVga->chipset) ? ' (' . $betterVga->chipset . ')' : '');
                            $build['components']['vga'] = ['id' => $betterVga->id, 'name' => $vgaName, 'price' => $diff, 'image' => true];
                            $build['total_price'] += $diff;
                            $remaining -= $diff;
                            $vgaTdp = $betterVgaTdp;
                            $upgradedAny = true;
                        }
                    }
                }
            }

            // 2. Nâng cấp CPU (đảm bảo cùng socket với mainboard đã chọn)
            if ($remaining >= 200000 && isset($build['components']['cpu'])) {
                $currentCpuPrice = $build['components']['cpu']['price'];
                $betterCpu = null;
                if ($buildType === 'gaming' && in_array($cpuBrand, ['amd', 'any'])) {
                    $betterCpu = $this->pickByBudget(1, 'cpus', $currentCpuPrice + $remaining, function ($q) use ($cpuBrand, $cpuMin, $ep, $hasMb, $socket) {
                        $q->whereRaw('LOWER(components.name) LIKE ?', ['%x3d%']);
                        if ($socket)            $q->where('cpus.socket', $socket);
                        $hasMb($q);
                    });
                }
                if (!$betterCpu) {
                    $betterCpu = $this->pickByBudget(1, 'cpus', $currentCpuPrice + $remaining, function ($q) use ($cpuBrand, $cpuMin, $ep, $hasMb, $socket) {
                        if ($cpuBrand !== 'any') $q->whereRaw('LOWER(components.name) LIKE ?', ['%' . strtolower($cpuBrand) . '%']);
                        if ($cpuMin > 0)        $q->whereRaw("{$ep} >= CAST(? AS NUMERIC)", [$cpuMin]);
                        if ($socket)            $q->where('cpus.socket', $socket);
                        $hasMb($q);
                    });
                }
                if ($betterCpu && (float)$betterCpu->price > $currentCpuPrice) {
                    $diff = (float)$betterCpu->price - $currentCpuPrice;
                    
                    // Check PSU compatibility
                    $betterCpuSpec = DB::table('cpus')->where('component_id', $betterCpu->id)->first();
                    $betterCpuTdp = $betterCpuSpec->tdp ?? 65;
                    $requiredWatt = $betterCpuTdp + $vgaTdp + ($vgaTdp > 0 ? 220 : 150);
                    
                    $currentPsuPrice = $build['components']['psu']['price'] ?? 0;
                    $psuSpec = isset($build['components']['psu']) ? DB::table('power_supplies')->where('component_id', $build['components']['psu']['id'])->first() : null;
                    $psuWatt = $psuSpec->wattage ?? 0;
                    
                    if ($psuWatt < $requiredWatt) {
                        $betterPsu = $this->pickByBudget(6, 'power_supplies', $currentPsuPrice + ($remaining - $diff), function ($q) use ($requiredWatt) {
                            $q->where('power_supplies.wattage', '>=', $requiredWatt);
                        }, true);
                        if ($betterPsu) {
                            $psuDiff = (float)$betterPsu->price - $currentPsuPrice;
                            $build['components']['cpu'] = ['id' => $betterCpu->id, 'name' => $betterCpu->name, 'price' => (float)$betterCpu->price, 'image' => true];
                            $build['components']['psu'] = ['id' => $betterPsu->id, 'name' => $betterPsu->name, 'price' => (float)$betterPsu->price, 'image' => true];
                            $build['total_price'] += ($diff + $psuDiff);
                            $remaining -= ($diff + $psuDiff);
                            $cpuTdp = $betterCpuTdp;
                            $upgradedAny = true;
                            // Cập nhật lại socket của CPU mới
                            $socket = $betterCpuSpec->socket ?? $socket;
                        }
                    } else {
                        $build['components']['cpu'] = ['id' => $betterCpu->id, 'name' => $betterCpu->name, 'price' => (float)$betterCpu->price, 'image' => true];
                        $build['total_price'] += $diff;
                        $remaining -= $diff;
                        $cpuTdp = $betterCpuTdp;
                        $upgradedAny = true;
                        // Cập nhật lại socket của CPU mới
                        $socket = $betterCpuSpec->socket ?? $socket;
                    }
                }
            }

            // 3. Nâng cấp Mainboard (đảm bảo cùng socket với CPU đã chọn)
            if ($remaining >= 200000 && isset($build['components']['mainboard'])) {
                $currentMbPrice = $build['components']['mainboard']['price'];
                
                $currentCpuPrice = isset($build['components']['cpu']) ? (float)$build['components']['cpu']['price'] : 0;
                $currentCpuName  = isset($build['components']['cpu']) ? strtolower($build['components']['cpu']['name']) : '';
                $isHighEndCpu = ($currentCpuPrice > 4000000)
                    || preg_match('/\b(k|kf|ks|x3d)\b/i', $currentCpuName)
                    || str_contains($currentCpuName, 'ryzen 7')
                    || str_contains($currentCpuName, 'ryzen 9')
                    || str_contains($currentCpuName, 'i7-')
                    || str_contains($currentCpuName, 'i9-');

                $excludedChipsets = [];
                if ($currentCpuPrice > 9000000) {
                    $excludedChipsets = ['A320','A620','H610','B450','H510','H410','B460','B560','H610','H710'];
                } elseif ($isHighEndCpu) {
                    $excludedChipsets = ['A320','A620','H610','H510','H410'];
                } elseif ($currentCpuPrice > 0 && $currentCpuPrice < 3000000) {
                    $excludedChipsets = ['B550', 'X570', 'B650', 'X670', 'B660', 'B760', 'Z690', 'Z790', 'H770', 'Z890', 'B850', 'X870'];
                }

                $betterMb = $this->pickByBudget(5, 'motherboards', $currentMbPrice + $remaining, function ($q) use ($socket, $excludedChipsets) {
                    if ($socket) $q->where('motherboards.socket', $socket);
                    foreach ($excludedChipsets as $chip) {
                        $q->whereRaw('LOWER(components.name) NOT LIKE ?', ['%' . strtolower($chip) . '%']);
                    }
                });
                if ($betterMb && (float)$betterMb->price > $currentMbPrice) {
                    $diff = (float)$betterMb->price - $currentMbPrice;
                    $build['components']['mainboard'] = ['id' => $betterMb->id, 'name' => $betterMb->name, 'price' => (float)$betterMb->price, 'image' => true];
                    $build['total_price'] += $diff;
                    $remaining -= $diff;
                    $upgradedAny = true;
                    // Cập nhật lại DDR gen và socket của mainboard mới
                    $mbSpec = DB::table('motherboards')->where('component_id', $betterMb->id)->first();
                    $ddrGen = $mbSpec->ddr_gen ?? $ddrGen;
                    $socket = $mbSpec->socket ?? $socket;
                }
            }

            // 4. Nâng cấp RAM (đảm bảo tương thích DDR Gen với mainboard đã chọn)
            if ($remaining >= 200000 && isset($build['components']['ram'])) {
                $currentRamPrice = $build['components']['ram']['price'];
                $betterRam = $this->pickByBudget(3, 'memory', $currentRamPrice + $remaining, function ($q) use ($ddrGen) {
                    if ($ddrGen) $q->where('memory.ddr_gen', $ddrGen);
                });
                if ($betterRam && (float)$betterRam->price > $currentRamPrice) {
                    $diff = (float)$betterRam->price - $currentRamPrice;
                    $build['components']['ram'] = ['id' => $betterRam->id, 'name' => $betterRam->name, 'price' => (float)$betterRam->price, 'image' => true];
                    $build['total_price'] += $diff;
                    $remaining -= $diff;
                    $upgradedAny = true;
                }
            }

            // 5. Nâng cấp Storage (Ưu tiên SSD hơn HDD ngay cả khi dung lượng thấp hơn)
            if ($remaining >= 200000 && isset($build['components']['storage'])) {
                $currentStoragePrice = $build['components']['storage']['price'];
                $currentStorageSpec = DB::table('internal_hard_drives')->where('component_id', $build['components']['storage']['id'])->first();
                $currCapacity = $currentStorageSpec->capacity ?? $storageMin;
                $currType = $currentStorageSpec->type ?? 'SSD';

                $betterStorage = null;

                // Nếu linh kiện hiện tại là HDD, ưu tiên tìm cách nâng cấp/chuyển sang SSD (tối thiểu 120GB) trong ngân sách mới
                if ($currType === 'HDD') {
                    $betterStorage = $this->pickByBudget(4, 'internal_hard_drives', $currentStoragePrice + $remaining, function ($q) {
                        $q->where('internal_hard_drives.type', 'SSD')
                          ->where('internal_hard_drives.capacity', '>=', 120);
                    });
                }

                // Nếu không cần chuyển từ HDD sang SSD, hoặc nếu hiện tại đã là SSD, tìm SSD tốt hơn
                if (!$betterStorage) {
                    $betterStorage = $this->pickByBudget(4, 'internal_hard_drives', $currentStoragePrice + $remaining, function ($q) use ($currCapacity) {
                        $q->where('internal_hard_drives.capacity', '>=', $currCapacity)
                          ->where('internal_hard_drives.type', 'SSD');
                    });
                }

                // Dự phòng cuối: Nếu không tìm thấy SSD nào phù hợp ngân sách, mới chấp nhận nâng cấp HDD lên HDD tốt hơn
                if (!$betterStorage && $currType === 'HDD') {
                    $betterStorage = $this->pickByBudget(4, 'internal_hard_drives', $currentStoragePrice + $remaining, function ($q) use ($currCapacity) {
                        $q->where('internal_hard_drives.capacity', '>=', $currCapacity)
                          ->where('internal_hard_drives.type', 'HDD');
                    });
                }

                if ($betterStorage && (float)$betterStorage->price > $currentStoragePrice) {
                    $diff = (float)$betterStorage->price - $currentStoragePrice;
                    $betterCapStr = ($betterStorage->capacity >= 1000) ? (($betterStorage->capacity / 1000) . 'TB') : ($betterStorage->capacity . 'GB');
                    $betterStorageName = $betterStorage->name;
                    if (!empty($betterStorage->capacity) && !empty($betterStorage->type)) {
                        $betterStorageName .= ' (' . $betterCapStr . ' ' . $betterStorage->type . ')';
                    }
                    $build['components']['storage'] = ['id' => $betterStorage->id, 'name' => $betterStorageName, 'price' => (float)$betterStorage->price, 'image' => true];
                    $build['total_price'] += $diff;
                    $remaining -= $diff;
                    $upgradedAny = true;
                }
            }

            // 6. Nâng cấp PSU
            if ($remaining >= 100000 && isset($build['components']['psu'])) {
                $currentPsuPrice = $build['components']['psu']['price'];
                $requiredWatt = $cpuTdp + $vgaTdp + ($vgaTdp > 0 ? 220 : 150);
                $betterPsu = $this->pickByBudget(6, 'power_supplies', $currentPsuPrice + $remaining, function ($q) use ($requiredWatt) {
                    $q->where('power_supplies.wattage', '>=', $requiredWatt);
                });
                if ($betterPsu && (float)$betterPsu->price > $currentPsuPrice) {
                    $diff = (float)$betterPsu->price - $currentPsuPrice;
                    $build['components']['psu'] = ['id' => $betterPsu->id, 'name' => $betterPsu->name, 'price' => (float)$betterPsu->price, 'image' => true];
                    $build['total_price'] += $diff;
                    $remaining -= $diff;
                    $upgradedAny = true;
                }
            }

            // 7. Nâng cấp Case
            if ($remaining >= 100000 && isset($build['components']['case'])) {
                $currentCasePrice = $build['components']['case']['price'];
                $betterCase = $this->pickByBudget(8, 'cases', $currentCasePrice + $remaining);
                if ($betterCase && (float)$betterCase->price > $currentCasePrice) {
                    $diff = (float)$betterCase->price - $currentCasePrice;
                    $build['components']['case'] = ['id' => $betterCase->id, 'name' => $betterCase->name, 'price' => (float)$betterCase->price, 'image' => true];
                    $build['total_price'] += $diff;
                    $remaining -= $diff;
                    $upgradedAny = true;
                }
            }
        }

        return $build;
    }

    // ─────────────────────────────────────────────────────────────────────────
    public function applyAiBuild(Request $request)
    {
        $components = $request->input('components', []);
        $build = [];
        foreach ($components as $cat => $id) {
            $comp = Component::with(['cheapestPrice'])->find($id);
            if ($comp) {
                $build[$cat] = [
                    'id'    => $comp->id,
                    'name'  => trim($comp->name),
                    'price' => $comp->base_price ?? $comp->cheapestPrice?->price ?? 0,
                    'image' => $comp->image_url ?? null,
                ];
            }
        }
        session()->put('build_pc', $build);
        return redirect()->route('build.index')->with('success', 'Đã áp dụng cấu hình đề xuất!');
    }
}
