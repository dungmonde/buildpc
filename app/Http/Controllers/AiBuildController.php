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
    private $searchLimit = 15;
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
            return back()->with('error', 'Tính năng chưa được cấu hình (thiếu GROQ_API_KEY trong file .env).');
        }

        $budget = (float)$request->budget;
        $needs  = $request->needs;
        $catalog = $this->getStoreCatalog($budget, $needs);

        $messages = [
            [
                'role' => 'system',
                'content' => "Bạn là AI tư vấn cấu hình PC chuyên nghiệp. Dưới đây là danh sách linh kiện thực tế đang có sẵn tại cửa hàng (giá 'price', các thông số 'socket', 'ddr_gen', 'tdp', 'wattage'):\n" . json_encode($catalog, JSON_UNESCAPED_UNICODE) . "\n\nNhiệm vụ của bạn là chọn ra 1 bộ máy TỐT NHẤT trong tầm giá và trả về JSON. Các quy tắc BẮT BUỘC (vi phạm sẽ bị từ chối):\n1. NGÂN SÁCH: Tổng giá trị (sum of price) của tất cả 7 linh kiện được chọn TUYỆT ĐỐI KHÔNG ĐƯỢC VƯỢT QUÁ ngân sách người dùng. Hãy tính toán cộng dồn thật kỹ.\n2. TƯƠNG THÍCH VẬT LÝ: CPU 'socket' PHẢI giống hệt Mainboard 'socket'. RAM 'ddr_gen' PHẢI giống hệt Mainboard 'ddr_gen'.\n3. NGUỒN ĐIỆN (PSU): PSU 'wattage' phải >= (CPU 'tdp' + VGA 'tdp' + 220W).\n4. VGA: Nhu cầu 'gaming'/'workstation' (ngân sách >= 9tr) BẮT BUỘC phải có VGA rời (không null). Nhu cầu 'văn phòng' luôn set VGA là null.\n\nBẮT BUỘC trả về đúng định dạng JSON chuẩn như sau (thay thế các số ID ví dụ bằng ID số nguyên thực tế từ danh sách linh kiện bên trên):\n{\n  \"builds\": [\n    {\n      \"title\": \"Cấu hình chơi game mạnh mẽ\",\n      \"build_type\": \"gaming\",\n      \"components\": {\n        \"cpu\": 123,\n        \"mainboard\": 456,\n        \"ram\": 789,\n        \"vga\": 101,\n        \"storage\": 202,\n        \"psu\": 303,\n        \"case\": 404\n      },\n      \"explanation\": \"Mô tả lợi ích cấu hình chung chung về hiệu năng và công dụng (Ví dụ: 'Cấu hình được thiết kế để đáp ứng tốt nhu cầu học tập, làm việc văn phòng và giải trí nhẹ nhàng. Hệ thống hoạt động mát mẻ, ổn định và tiết kiệm điện năng.'). TUYỆT ĐỐI KHÔNG nhắc đến tên hãng hoặc tên model linh kiện cụ thể nào (như AMD, Intel, NVIDIA, Gigabyte, Asus, MSI, Ryzen, Core, RTX, GTX, Radeon...) trong phần mô tả này.\"\n    }\n  ]\n}\n\nChú ý: Trường 'vga' nhận giá trị ID số nguyên hoặc null (nếu không có vga rời). KHÔNG được sử dụng cú pháp JavaScript (như thiếu dấu ngoặc kép ở key hoặc dùng dấu '=' thay cho ':'). Tất cả các key và value chuỗi phải nằm trong dấu ngoặc kép song song."
            ],
            [
                'role' => 'user',
                'content' => "Ngân sách: " . number_format($budget) . " VNĐ.\nNhu cầu: " . $needs
            ]
        ];

        $originalBudget = $budget;
        $maxAttempts = 3;
        $lastError = 'Không thể khởi tạo cấu hình.';
        $model = 'llama-3.1-8b-instant';

        for ($attemptNo = 1; $attemptNo <= $maxAttempts; $attemptNo++) {
            $aiResult = null;
            $fallbackReason = null;
            $response = null;

            try {
                $maxRetries = 5;
                $retryDelay = 4; // seconds

                for ($attempt = 1; $attempt <= $maxRetries; $attempt++) {
                    $response = Http::timeout(60)->withoutVerifying()->withHeaders([
                        'Content-Type' => 'application/json',
                        'Authorization' => 'Bearer ' . $apiKey,
                    ])->post('https://api.groq.com/openai/v1/chat/completions', [
                        'model'           => $model,
                        'messages'        => $messages,
                        'response_format' => ['type' => 'json_object'],
                        'max_tokens'      => 2048
                    ]);

                    if (!$response->successful() && $attempt < $maxRetries) {
                        $status = $response->status();
                        $body = $response->body();
                        if ($status === 429 && (str_contains($body, 'TPD') || str_contains($body, 'tokens per day') || str_contains($body, 'RPD') || str_contains($body, 'requests per day'))) {
                            Log::warning("Groq API returned daily rate limit (TPD/RPD) for {$model}. Breaking retry loop.");
                            break;
                        }
                        Log::warning("Groq API returned status {$status}. Retrying attempt {$attempt} after {$retryDelay}s...");
                        sleep($retryDelay);
                        $retryDelay *= 2; // exponential backoff
                        continue;
                    }
                    break;
                }

                if (!$response || !$response->successful()) {
                    $fallbackReason = 'Groq API error status ' . ($response ? $response->status() : 'N/A') . ': ' . ($response ? $response->body() : 'No response');
                    Log::warning($fallbackReason);
                } else {
                    $data = $response->json();
                    $content = $data['choices'][0]['message']['content'] ?? '';
                    $aiResult = json_decode(trim($content), true);
                    if (!$aiResult || !isset($aiResult['builds'])) {
                        $fallbackReason = 'Invalid JSON output from AI: ' . $content;
                    }
                }
            } catch (\Exception $e) {
                $fallbackReason = 'Exception in API call: ' . $e->getMessage();
                Log::error($fallbackReason);
            }

            if (!$aiResult || !isset($aiResult['builds']) || empty($aiResult['builds'])) {
                $lastError = 'Lỗi phản hồi từ AI: ' . ($fallbackReason ?? 'JSON không hợp lệ hoặc rỗng.');
                Log::warning("Validation attempt {$attemptNo} failed on API call: {$lastError}");
                continue;
            }

            $suggestedBuilds = [];
            $build = $aiResult['builds'][0] ?? null;
            if (!$build) {
                $lastError = 'AI không trả về cấu hình nào.';
                continue;
            }

            if (isset($build['explanation'])) {
                $build['explanation'] = TextCleaner::cleanCjk($build['explanation']);
            }
            if (isset($build['title'])) {
                $build['title'] = TextCleaner::cleanCjk($build['title']);
            }

            $buildType = strtolower($build['build_type'] ?? 'gaming');
            
            // Thử lấy linh kiện thực tế theo lựa chọn của AI
            $selectedIds = $build['components'] ?? [];
            $components = [];
            $totalPrice = 0;
            $requiredTypes = ['cpu', 'mainboard', 'ram', 'storage', 'psu', 'case'];
            $hasAllRequired = true;

            foreach ($requiredTypes as $type) {
                $table = $type === 'ram' ? 'memory' : ($type === 'storage' ? 'internal_hard_drives' : ($type === 'psu' ? 'power_supplies' : ($type === 'case' ? 'cases' : ($type === 'mainboard' ? 'motherboards' : 'cpus'))));
                $typeId = $type === 'ram' ? 3 : ($type === 'storage' ? 4 : ($type === 'psu' ? 6 : ($type === 'case' ? 8 : ($type === 'mainboard' ? 5 : 1))));
                
                $selectCols = ['components.id', 'components.name', DB::raw('COALESCE(components.base_price, cp.price) as price')];
                if ($type === 'storage') {
                    $selectCols[] = 'internal_hard_drives.capacity';
                    $selectCols[] = 'internal_hard_drives.type';
                } elseif ($type === 'psu') {
                    $selectCols[] = 'power_supplies.wattage';
                }

                $id = $selectedIds[$type] ?? null;
                $compObj = null;
                if ($id && is_numeric($id)) {
                    $compObj = DB::table('components')
                        ->join($table, "{$table}.component_id", '=', 'components.id')
                        ->leftJoin(
                            DB::raw('(SELECT component_id, MIN(price) as price FROM component_prices GROUP BY component_id) cp'),
                            'cp.component_id', '=', 'components.id'
                        )
                        ->where('components.id', $id)
                        ->select($selectCols)
                        ->first();
                }

                // Auto-Correct if missing, invalid, or price is 0
                if (!$compObj || !(float)$compObj->price) {
                    $compObj = $this->pickByBudget($typeId, $table, 5000000, null, true);
                }

                if (!$compObj || !(float)$compObj->price) {
                    $hasAllRequired = false;
                    break;
                }

                $selectedIds[$type] = $compObj->id;

                $compName = $compObj->name;
                if ($type === 'storage') {
                    $capStr = ($compObj->capacity >= 1000) ? (($compObj->capacity / 1000) . 'TB') : ($compObj->capacity . 'GB');
                    if (!empty($compObj->capacity) && !empty($compObj->type)) {
                        $compName .= ' (' . $capStr . ' ' . $compObj->type . ')';
                    }
                } elseif ($type === 'psu') {
                    if (!empty($compObj->wattage)) {
                        $compName .= ' (' . $compObj->wattage . 'W)';
                    }
                }

                $components[$type] = [
                    'id' => $compObj->id,
                    'name' => $compName,
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
                    ->select('components.id', 'components.name', 'video_cards.tdp', 'video_cards.chipset', DB::raw('COALESCE(components.base_price, cp.price) as price'))
                    ->first();

                if ($compObj && (float)$compObj->price) {
                    $vgaName = $compObj->name . (!empty($compObj->chipset) ? ' (' . $compObj->chipset . ')' : '');
                    $components['vga'] = [
                        'id' => $compObj->id,
                        'name' => $vgaName,
                        'price' => (float)$compObj->price,
                        'image' => true,
                    ];
                    $totalPrice += (float)$compObj->price;
                }
            }

            // Xác thực tính tương thích vật lý bằng PHP
            $isCompatible = true;
            $incompatibilities = [];
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
                    // AUTO CORRECT: Đổi Mainboard để khớp Socket CPU
                    $correctedMb = $this->pickByBudget(5, 'motherboards', 5000000, function ($q) use ($cpuSocket) {
                        $q->where('motherboards.socket', $cpuSocket);
                    }, true);

                    if ($correctedMb) {
                        $totalPrice -= $components['mainboard']['price'];
                        $components['mainboard'] = [
                            'id' => $correctedMb->id,
                            'name' => $correctedMb->name,
                            'price' => (float)$correctedMb->price,
                            'image' => true,
                        ];
                        $totalPrice += (float)$correctedMb->price;
                        $selectedIds['mainboard'] = $correctedMb->id;
                        $mbSpec = DB::table('motherboards')->where('component_id', $correctedMb->id)->first();
                        $mbSocket = $mbSpec->socket ?? null;
                        $mbDdr = $mbSpec->ddr_gen ?? null;
                    } else {
                        $isCompatible = false;
                        $incompatibilities[] = "Socket lệch (CPU: $cpuSocket vs Main: $mbSocket)";
                    }
                }
                
                // 2. Kiểm tra thế hệ DDR của Motherboard và RAM
                if ($mbDdr && $ramDdr && (int)$mbDdr !== (int)$ramDdr) {
                    // AUTO CORRECT: Đổi RAM để khớp DDR Mainboard
                    $ramCapacity = $ramSpec->capacity ?? 8;
                    
                    $correctedRam = $this->pickByBudget(3, 'memory', 5000000, function ($q) use ($ramCapacity, $mbDdr) {
                        $q->where('memory.capacity', '>=', $ramCapacity);
                        $q->where('memory.ddr_gen', $mbDdr);
                    }, true);
                    
                    if (!$correctedRam) {
                        $correctedRam = $this->pickByBudget(3, 'memory', 5000000, function ($q) use ($mbDdr) {
                            $q->where('memory.ddr_gen', $mbDdr);
                        }, true);
                    }

                    if ($correctedRam) {
                        $totalPrice -= $components['ram']['price'];
                        $components['ram'] = [
                            'id' => $correctedRam->id,
                            'name' => $correctedRam->name,
                            'price' => (float)$correctedRam->price,
                            'image' => true,
                        ];
                        $totalPrice += (float)$correctedRam->price;
                        $selectedIds['ram'] = $correctedRam->id;
                        $ramDdr = $mbDdr;
                    } else {
                        $isCompatible = false;
                        $incompatibilities[] = "DDR lệch (Main: DDR$mbDdr vs RAM: DDR$ramDdr)";
                    }
                }

                // 3. Kiểm tra công suất nguồn đủ tải (CPU + VGA + hao phí)
                $requiredWatt = $cpuTdp + $vgaTdp + ($vgaTdp > 0 ? 220 : 150);
                if ($psuWatt && $psuWatt < $requiredWatt) {
                    // AUTO CORRECT: Đổi PSU cho đủ công suất
                    $correctedPsu = $this->pickByBudget(6, 'power_supplies', 5000000, function ($q) use ($requiredWatt) {
                        $q->where('power_supplies.wattage', '>=', $requiredWatt);
                    }, true);

                    if ($correctedPsu) {
                        $totalPrice -= $components['psu']['price'];
                        $psuSpecNew = DB::table('power_supplies')->where('component_id', $correctedPsu->id)->first();
                        $psuWattNew = $psuSpecNew->wattage ?? 0;
                        $psuName = $correctedPsu->name . ($psuWattNew ? " ({$psuWattNew}W)" : '');
                        
                        $components['psu'] = [
                            'id' => $correctedPsu->id,
                            'name' => $psuName,
                            'price' => (float)$correctedPsu->price,
                            'image' => true,
                        ];
                        $totalPrice += (float)$correctedPsu->price;
                        $selectedIds['psu'] = $correctedPsu->id;
                        $psuWatt = $psuWattNew;
                    } else {
                        $isCompatible = false;
                        $incompatibilities[] = "Nguồn quá yếu (PSU: {$psuWatt}W < Yêu cầu: {$requiredWatt}W)";
                    }
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
                        $hasBadChip = false;
                        foreach ($badChipsets as $chip) {
                            if (str_contains($mbNameVal, $chip)) {
                                $hasBadChip = true;
                                break;
                            }
                        }
                        if ($hasBadChip) {
                            // AUTO CORRECT: Đổi Mainboard lên dòng cao hơn cùng socket (không thuộc badChipsets)
                            $correctedMb = $this->pickByBudget(5, 'motherboards', 5000000, function ($q) use ($cpuSocket, $badChipsets) {
                                $q->where('motherboards.socket', $cpuSocket);
                                foreach ($badChipsets as $chip) {
                                    $q->whereRaw('LOWER(components.name) NOT LIKE ?', ['%' . strtolower($chip) . '%']);
                                }
                            }, true);

                            if ($correctedMb) {
                                $totalPrice -= $components['mainboard']['price'];
                                $components['mainboard'] = [
                                    'id' => $correctedMb->id,
                                    'name' => $correctedMb->name,
                                    'price' => (float)$correctedMb->price,
                                    'image' => true,
                                ];
                                $totalPrice += (float)$correctedMb->price;
                                $selectedIds['mainboard'] = $correctedMb->id;
                                $mbSpec = DB::table('motherboards')->where('component_id', $correctedMb->id)->first();
                                $mbSocket = $mbSpec->socket ?? null;
                                $mbDdr = $mbSpec->ddr_gen ?? null;
                            } else {
                                $isCompatible = false;
                                $incompatibilities[] = "Chipset rẻ tiền ($mbNameVal) nghẽn cổ chai CPU dòng cao cấp và không tìm thấy bo mạch chủ thay thế tốt hơn";
                            }
                        }
                    }
                }
            }

            if ($hasAllRequired && $isCompatible && $totalPrice <= ($budget * 1.15)) {
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
                return view('pages.build_pc.ai-result', compact('suggestedBuilds', 'budget', 'needs', 'originalBudget'));
            } else {
                // AI build bị từ chối, ghi nhận lý do và thử lại
                $reasons = [];
                if (!$hasAllRequired) $reasons[] = 'Thiếu linh kiện bắt buộc';
                if (isset($isCompatible) && !$isCompatible) {
                    $reasons[] = 'Linh kiện không tương thích vật lý: [' . implode(' | ', $incompatibilities) . ']';
                }
                if ($totalPrice > ($budget * 1.15)) {
                    $reasons[] = 'Tổng giá vượt ngân sách sau khi Auto-Correct (' . number_format($totalPrice) . 'đ > ' . number_format($budget * 1.15) . 'đ)';
                }
                
                $lastError = 'Cấu hình AI chọn bị từ chối do: ' . implode(', ', $reasons);
                Log::warning("Validation attempt {$attemptNo} failed: {$lastError}. Retrying a new build from AI...");
            }
        }

        // Nếu tất cả các lần thử lại đều bị từ chối
        return back()->with('error', $lastError);

        } catch (\Exception $e) {
            return back()->with('error', 'Có lỗi xảy ra: ' . $e->getMessage());
        }
    }

    // ─────────────────────────────────────────────────────────────────────────
    // HELPER: Chọn linh kiện tốt nhất trong budget
    // ─────────────────────────────────────────────────────────────────────────
    public function pickByBudget(int $typeId, string $specTable, float $maxBudget, ?\Closure $filter = null, bool $asc = false): ?object
    {
        $ep          = 'COALESCE(components.base_price, cp.price)';
        $selectExtra = [];
        if ($specTable === 'video_cards') {
            $selectExtra = ['video_cards.chipset'];
        } elseif ($specTable === 'internal_hard_drives') {
            $selectExtra = ['internal_hard_drives.capacity', 'internal_hard_drives.type'];
        } elseif ($specTable === 'power_supplies') {
            $selectExtra = ['power_supplies.wattage'];
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
        $query = DB::table('components')
            ->join('cpus', 'cpus.component_id', '=', 'components.id')
            ->leftJoin(
                DB::raw('(SELECT component_id, MIN(price) as price FROM component_prices GROUP BY component_id) cp'),
                'cp.component_id', '=', 'components.id'
            )
            ->where('components.type_id', 1)
            ->whereRaw("{$ep} > 0");

        $mainQuery = clone $query;
        $mainQuery->whereRaw("{$ep} <= ?", [$maxPrice]);
        if ($socket) {
            $mainQuery->where('cpus.socket', $socket);
        }
        $results = $mainQuery->select('components.id', 'components.name', DB::raw("{$ep} as price"), 'cpus.socket', 'cpus.tdp')
            ->orderByDesc('price')
            ->limit($this->searchLimit)
            ->get()
            ->toArray();

        if (count($results) < 5) {
            $fallbackQuery = clone $query;
            if ($socket) {
                $fallbackQuery->where('cpus.socket', $socket);
            }
            $results = $fallbackQuery->select('components.id', 'components.name', DB::raw("{$ep} as price"), 'cpus.socket', 'cpus.tdp')
                ->orderBy('price')
                ->limit(5)
                ->get()
                ->toArray();
        }
        return $results;
    }

    private function searchMotherboards(?string $socket = null, ?int $ddrGen = null, ?float $maxPrice = null): array
    {
        $ep = 'COALESCE(components.base_price, cp.price)';
        $query = DB::table('components')
            ->join('motherboards', 'motherboards.component_id', '=', 'components.id')
            ->leftJoin(
                DB::raw('(SELECT component_id, MIN(price) as price FROM component_prices GROUP BY component_id) cp'),
                'cp.component_id', '=', 'components.id'
            )
            ->where('components.type_id', 5)
            ->whereRaw("{$ep} > 0");

        $mainQuery = clone $query;
        if ($maxPrice) {
            $mainQuery->whereRaw("COALESCE(components.base_price, cp.price) <= ?", [$maxPrice]);
        }
        if ($socket) {
            $mainQuery->where('motherboards.socket', $socket);
        }
        if ($ddrGen) {
            $mainQuery->where('motherboards.ddr_gen', $ddrGen);
        }
        $results = $mainQuery->select('components.id', 'components.name', DB::raw("{$ep} as price"), 'motherboards.socket', 'motherboards.ddr_gen')
            ->orderByDesc('price')
            ->limit($this->searchLimit)
            ->get()
            ->toArray();

        if (count($results) < 5) {
            $fallbackQuery = clone $query;
            if ($socket) {
                $fallbackQuery->where('motherboards.socket', $socket);
            }
            if ($ddrGen) {
                $fallbackQuery->where('motherboards.ddr_gen', $ddrGen);
            }
            $results = $fallbackQuery->select('components.id', 'components.name', DB::raw("{$ep} as price"), 'motherboards.socket', 'motherboards.ddr_gen')
                ->orderBy('price')
                ->limit(5)
                ->get()
                ->toArray();
        }
        return $results;
    }

    private function searchVideoCards(?float $maxPrice = null): array
    {
        $ep = 'COALESCE(components.base_price, cp.price)';
        $query = DB::table('components')
            ->join('video_cards', 'video_cards.component_id', '=', 'components.id')
            ->leftJoin(
                DB::raw('(SELECT component_id, MIN(price) as price FROM component_prices GROUP BY component_id) cp'),
                'cp.component_id', '=', 'components.id'
            )
            ->where('components.type_id', 2)
            ->whereRaw("{$ep} > 0");

        $mainQuery = clone $query;
        if ($maxPrice) {
            $mainQuery->whereRaw("COALESCE(components.base_price, cp.price) <= ?", [$maxPrice]);
        }
        $results = $mainQuery->select('components.id', 'components.name', DB::raw("{$ep} as price"), 'video_cards.tdp', 'video_cards.chipset')
            ->orderByDesc('price')
            ->limit($this->searchLimit)
            ->get()
            ->toArray();

        if (count($results) < 5) {
            $results = $query->select('components.id', 'components.name', DB::raw("{$ep} as price"), 'video_cards.tdp', 'video_cards.chipset')
                ->orderBy('price')
                ->limit(5)
                ->get()
                ->toArray();
        }
        return $results;
    }

    private function searchMemory(?int $ddrGen = null, ?float $maxPrice = null): array
    {
        $ep = 'COALESCE(components.base_price, cp.price)';
        $query = DB::table('components')
            ->join('memory', 'memory.component_id', '=', 'components.id')
            ->leftJoin(
                DB::raw('(SELECT component_id, MIN(price) as price FROM component_prices GROUP BY component_id) cp'),
                'cp.component_id', '=', 'components.id'
            )
            ->where('components.type_id', 3)
            ->whereRaw("{$ep} > 0");

        $mainQuery = clone $query;
        if ($maxPrice) {
            $mainQuery->whereRaw("COALESCE(components.base_price, cp.price) <= ?", [$maxPrice]);
        }
        if ($ddrGen) {
            $mainQuery->where('memory.ddr_gen', $ddrGen);
        }
        $results = $mainQuery->select('components.id', 'components.name', DB::raw("{$ep} as price"), 'memory.capacity', 'memory.ddr_gen')
            ->orderByDesc('price')
            ->limit($this->searchLimit)
            ->get()
            ->toArray();

        if (count($results) < 5) {
            $fallbackQuery = clone $query;
            if ($ddrGen) {
                $fallbackQuery->where('memory.ddr_gen', $ddrGen);
            }
            $results = $fallbackQuery->select('components.id', 'components.name', DB::raw("{$ep} as price"), 'memory.capacity', 'memory.ddr_gen')
                ->orderBy('price')
                ->limit(5)
                ->get()
                ->toArray();
        }
        return $results;
    }

    private function searchPowerSupplies(?float $wattage = null, ?float $maxPrice = null): array
    {
        $ep = 'COALESCE(components.base_price, cp.price)';
        $query = DB::table('components')
            ->join('power_supplies', 'power_supplies.component_id', '=', 'components.id')
            ->leftJoin(
                DB::raw('(SELECT component_id, MIN(price) as price FROM component_prices GROUP BY component_id) cp'),
                'cp.component_id', '=', 'components.id'
            )
            ->where('components.type_id', 6)
            ->whereRaw("{$ep} > 0");

        $mainQuery = clone $query;
        if ($maxPrice) {
            $mainQuery->whereRaw("COALESCE(components.base_price, cp.price) <= ?", [$maxPrice]);
        }
        if ($wattage) {
            $mainQuery->where('power_supplies.wattage', '>=', $wattage);
        }
        $results = $mainQuery->select('components.id', 'components.name', DB::raw("{$ep} as price"), 'power_supplies.wattage')
            ->orderByDesc('price')
            ->limit($this->searchLimit)
            ->get()
            ->toArray();

        if (count($results) < 5) {
            $fallbackQuery = clone $query;
            if ($wattage) {
                $fallbackQuery->where('power_supplies.wattage', '>=', $wattage);
            }
            $results = $fallbackQuery->select('components.id', 'components.name', DB::raw("{$ep} as price"), 'power_supplies.wattage')
                ->orderBy('price')
                ->limit(5)
                ->get()
                ->toArray();
        }
        return $results;
    }

    private function getStoreCatalog(float $budget, string $needs): array
    {
        $needsLower = strtolower($needs);
        $needsGpu = true;
        
        // Cấu hình văn phòng/học tập thông dụng thì không cần VGA rời
        if (str_contains($needsLower, 'văn phòng') || str_contains($needsLower, 'office') || str_contains($needsLower, 'học tập') || str_contains($needsLower, 'gia đình')) {
            $needsGpu = false;
        }

        if ($needsGpu) {
            // Cân đối ngân sách tối ưu cho Gaming/Workstation (ưu tiên VGA)
            // Tổng hệ số = 0.20 + 0.15 + 0.38 + 0.10 + 0.07 + 0.07 + 0.05 = 1.02 (Bảo đảm AI không thể chọn vượt ngân sách quá 2%)
            $cpuLimit = max($budget * 0.23, 1500000);
            $mbLimit = max($budget * 0.12, 1350000);
            $vgaLimit = max($budget * 0.38, 1500000);
            $ramLimit = max($budget * 0.14, 800000);
            $psuLimit = max($budget * 0.07, 650000);
            $storageLimit = max($budget * 0.05, 800000);
            $caseLimit = max($budget * 0.05, 500000);

            return [
                'cpus'           => $this->searchCpus($cpuLimit),
                'motherboards'   => $this->searchMotherboards(null, null, $mbLimit),
                'video_cards'    => $this->searchVideoCards($vgaLimit),
                'memory'         => $this->searchMemory(null, $ramLimit),
                'power_supplies' => $this->searchPowerSupplies(550, $psuLimit),
                'storage'        => $this->searchStorage('SSD', $storageLimit),
                'cases'          => $this->searchCases($caseLimit)
            ];
        } else {
            // Tối ưu ngân sách cho Office (không dùng VGA, dồn tiền cho CPU/RAM/SSD)
            // Tổng hệ số = 0.32 + 0.22 + 0.15 + 0.10 + 0.15 + 0.06 = 1.00
            $cpuLimit = max($budget * 0.32, 1500000);
            $mbLimit = max($budget * 0.22, 1150000);
            $ramLimit = max($budget * 0.15, 700000);
            $psuLimit = max($budget * 0.10, 550000);
            $storageLimit = max($budget * 0.15, 700000);
            $caseLimit = max($budget * 0.06, 400000);

            return [
                'cpus'           => $this->searchCpus($cpuLimit),
                'motherboards'   => $this->searchMotherboards(null, null, $mbLimit),
                'video_cards'    => [], // Không cần VGA
                'memory'         => $this->searchMemory(null, $ramLimit),
                'power_supplies' => $this->searchPowerSupplies(null, $psuLimit),
                'storage'        => $this->searchStorage('SSD', $storageLimit),
                'cases'          => $this->searchCases($caseLimit)
            ];
        }
    }

    private function searchStorage(?string $type = 'SSD', ?float $maxPrice = null): array
    {
        $ep = 'COALESCE(components.base_price, cp.price)';
        $query = DB::table('components')
            ->join('internal_hard_drives', 'internal_hard_drives.component_id', '=', 'components.id')
            ->leftJoin(
                DB::raw('(SELECT component_id, MIN(price) as price FROM component_prices GROUP BY component_id) cp'),
                'cp.component_id', '=', 'components.id'
            )
            ->where('components.type_id', 4)
            ->whereRaw("{$ep} > 0");

        $mainQuery = clone $query;
        if ($maxPrice) {
            $mainQuery->whereRaw("COALESCE(components.base_price, cp.price) <= ?", [$maxPrice]);
        }
        if ($type) {
            $mainQuery->where('internal_hard_drives.type', $type);
        }
        $results = $mainQuery->select('components.id', 'components.name', DB::raw("{$ep} as price"), 'internal_hard_drives.capacity', 'internal_hard_drives.type')
            ->orderByDesc('price')
            ->limit($this->searchLimit)
            ->get()
            ->toArray();

        if (count($results) < 5) {
            $fallbackQuery = clone $query;
            if ($type) {
                $fallbackQuery->where('internal_hard_drives.type', $type);
            }
            $results = $fallbackQuery->select('components.id', 'components.name', DB::raw("{$ep} as price"), 'internal_hard_drives.capacity', 'internal_hard_drives.type')
                ->orderBy('price')
                ->limit(5)
                ->get()
                ->toArray();
        }
        return $results;
    }

    private function searchCases(?float $maxPrice = null): array
    {
        $ep = 'COALESCE(components.base_price, cp.price)';
        $query = DB::table('components')
            ->join('cases', 'cases.component_id', '=', 'components.id')
            ->leftJoin(
                DB::raw('(SELECT component_id, MIN(price) as price FROM component_prices GROUP BY component_id) cp'),
                'cp.component_id', '=', 'components.id'
            )
            ->where('components.type_id', 8)
            ->whereRaw("{$ep} > 0");

        $mainQuery = clone $query;
        if ($maxPrice) {
            $mainQuery->whereRaw("COALESCE(components.base_price, cp.price) <= ?", [$maxPrice]);
        }
        $results = $mainQuery->select('components.id', 'components.name', DB::raw("{$ep} as price"))
            ->orderByDesc('price')
            ->limit($this->searchLimit)
            ->get()
            ->toArray();

        if (count($results) < 5) {
            $results = $query->select('components.id', 'components.name', DB::raw("{$ep} as price"))
                ->orderBy('price')
                ->limit(5)
                ->get()
                ->toArray();
        }
        return $results;
    }

    // ─────────────────────────────────────────────────────────────────────────
    // Helper: Nâng cấp tuần hoàn các linh kiện để tối ưu hóa ngân sách thừa
    // ─────────────────────────────────────────────────────────────────────────
    public function upgradeBuild(array $build, float $budget, string $buildType, string $cpuBrand, bool $needsGpu): array
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

            // 1. Nâng cấp RAM (đảm bảo tương thích DDR Gen với mainboard đã chọn)
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

            // 2. Nâng cấp CPU (đảm bảo cùng socket với mainboard đã chọn)
            if ($remaining >= 200000 && isset($build['components']['cpu'])) {
                $currentCpuPrice = $build['components']['cpu']['price'];
                
                $mbObj = isset($build['components']['mainboard']) ? DB::table('components')->where('id', $build['components']['mainboard']['id'])->first() : null;
                $isCheapMb = false;
                if ($mbObj) {
                    $mbNameVal = strtolower($mbObj->name);
                    $badChipsets = ['h610', 'h510', 'h410', 'a320', 'a620', 'h710', 'b450', 'b460', 'b560'];
                    foreach ($badChipsets as $chip) {
                        if (str_contains($mbNameVal, $chip)) {
                            $isCheapMb = true;
                            break;
                        }
                    }
                }

                $betterCpu = null;
                if ($buildType === 'gaming' && in_array($cpuBrand, ['amd', 'any']) && !$isCheapMb) {
                    $betterCpu = $this->pickByBudget(1, 'cpus', $currentCpuPrice + $remaining, function ($q) use ($cpuBrand, $cpuMin, $ep, $hasMb, $socket) {
                        $q->whereRaw('LOWER(components.name) LIKE ?', ['%x3d%']);
                        if ($socket)            $q->where('cpus.socket', $socket);
                        $hasMb($q);
                    });
                }
                if (!$betterCpu) {
                    $betterCpu = $this->pickByBudget(1, 'cpus', $currentCpuPrice + $remaining, function ($q) use ($cpuBrand, $cpuMin, $ep, $hasMb, $socket, $isCheapMb) {
                        if ($cpuBrand !== 'any') $q->whereRaw('LOWER(components.name) LIKE ?', ['%' . strtolower($cpuBrand) . '%']);
                        if ($cpuMin > 0)        $q->whereRaw("{$ep} >= CAST(? AS NUMERIC)", [$cpuMin]);
                        if ($socket)            $q->where('cpus.socket', $socket);
                        $hasMb($q);
                        if ($isCheapMb) {
                            $q->whereRaw("COALESCE(components.base_price, cp.price) <= 4000000");
                            $q->whereRaw("LOWER(components.name) NOT LIKE '%k'");
                            $q->whereRaw("LOWER(components.name) NOT LIKE '%kf'");
                            $q->whereRaw("LOWER(components.name) NOT LIKE '%ks'");
                            $q->whereRaw("LOWER(components.name) NOT LIKE '%x3d%'");
                            $q->whereRaw("LOWER(components.name) NOT LIKE '%ryzen 7%'");
                            $q->whereRaw("LOWER(components.name) NOT LIKE '%ryzen 9%'");
                            $q->whereRaw("LOWER(components.name) NOT LIKE '%i7-%'");
                            $q->whereRaw("LOWER(components.name) NOT LIKE '%i9-%'");
                        }
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
                            $psuName = $betterPsu->name . (!empty($betterPsu->wattage) ? ' (' . $betterPsu->wattage . 'W)' : '');
                            $build['components']['psu'] = ['id' => $betterPsu->id, 'name' => $psuName, 'price' => (float)$betterPsu->price, 'image' => true];
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

            // 2. Nâng cấp hoặc Thêm VGA (nếu needsGpu và còn thừa tiền)
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
                                $psuName = $betterPsu->name . (!empty($betterPsu->wattage) ? ' (' . $betterPsu->wattage . 'W)' : '');
                                $build['components']['psu'] = ['id' => $betterPsu->id, 'name' => $psuName, 'price' => (float)$betterPsu->price, 'image' => true];
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
                                $psuName = $betterPsu->name . (!empty($betterPsu->wattage) ? ' (' . $betterPsu->wattage . 'W)' : '');
                                $build['components']['psu'] = ['id' => $betterPsu->id, 'name' => $psuName, 'price' => (float)$betterPsu->price, 'image' => true];
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

            // 4. (Đã chuyển lên bước 1)

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
                    $psuName = $betterPsu->name . (!empty($betterPsu->wattage) ? ' (' . $betterPsu->wattage . 'W)' : '');
                    $build['components']['psu'] = ['id' => $betterPsu->id, 'name' => $psuName, 'price' => (float)$betterPsu->price, 'image' => true];
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
