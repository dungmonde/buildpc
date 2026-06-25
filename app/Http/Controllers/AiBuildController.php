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
            'budget' => 'required|numeric|min:5000000',
            'needs'  => 'required|string|max:500',
        ]);

        try {
            $apiKey = env('GROQ_API_KEY');
            if (!$apiKey) {
                return back()->with('error', 'Tính năng chưa được cấu hình (thiếu GROQ_API_KEY trong file .env).');
            }

            $budget   = (float)$request->budget;
            $needs    = $request->needs;
            $catalog  = $this->getStoreCatalog($budget, $needs);
            $needsGpu = !empty($catalog['video_cards']);

            // Phân bổ ngân sách cho 2 linh kiện AI chọn
            $cpuBudget = $needsGpu ? $budget * 0.23 : $budget * 0.32;
            $vgaBudget = $needsGpu ? $budget * 0.38 : 0;

            $catalogJson    = json_encode($catalog, JSON_UNESCAPED_UNICODE);
            $vgaInstruction = $needsGpu ? '"vga": 101' : '"vga": null';

            $messages = [
                [
                    'role'    => 'system',
                    'content' => "Bạn là AI tư vấn cấu hình PC. Dưới đây là danh sách CPU và VGA đang có sẵn tại cửa hàng:\n"
                        . $catalogJson
                        . "\n\nNhiệm vụ: Chọn 1 CPU phù hợp nhất (tối đa " . number_format($cpuBudget) . " VNĐ)"
                        . ($needsGpu ? " và 1 VGA phù hợp nhất (tối đa " . number_format($vgaBudget) . " VNĐ)" : ", KHÔNG cần VGA rời")
                        . " dựa trên nhu cầu người dùng.\n\n"
                        . "TUYỆT ĐỐI trả về đúng định dạng JSON sau (chỉ điền ID số nguyên thực tế từ danh sách):\n"
                        . "{\n"
                        . "  \"cpu\": 123,\n"
                        . "  {$vgaInstruction},\n"
                        . "  \"title\": \"Tên cấu hình ngắn gọn\",\n"
                        . "  \"explanation\": \"Mô tả lợi ích chung chung về hiệu năng và công dụng. TUYỆT ĐỐI KHÔNG nhắc tên hãng hoặc model cụ thể (AMD, Intel, NVIDIA, Ryzen, Core, RTX, Radeon...).\"\n"
                        . "}"
                ],
                [
                    'role'    => 'user',
                    'content' => "Ngân sách: " . number_format($budget) . " VNĐ.\nNhu cầu: " . $needs
                ]
            ];

            $originalBudget = $budget;
            $maxAttempts    = 3;
            $lastError      = 'Không thể khởi tạo cấu hình.';
            $model          = 'llama-3.1-8b-instant';

            for ($attemptNo = 1; $attemptNo <= $maxAttempts; $attemptNo++) {
                $aiResult       = null;
                $fallbackReason = null;
                $response       = null;

                try {
                    $maxRetries = 5;
                    $retryDelay = 4;

                    for ($attempt = 1; $attempt <= $maxRetries; $attempt++) {
                        $response = Http::timeout(60)->withoutVerifying()->withHeaders([
                            'Content-Type'  => 'application/json',
                            'Authorization' => 'Bearer ' . $apiKey,
                        ])->post('https://api.groq.com/openai/v1/chat/completions', [
                            'model'           => $model,
                            'messages'        => $messages,
                            'response_format' => ['type' => 'json_object'],
                            'max_tokens'      => 512,
                        ]);

                        if (!$response->successful() && $attempt < $maxRetries) {
                            $status = $response->status();
                            $body   = $response->body();
                            if ($status === 429 && (str_contains($body, 'TPD') || str_contains($body, 'tokens per day') || str_contains($body, 'RPD') || str_contains($body, 'requests per day'))) {
                                Log::warning("Groq API daily rate limit for {$model}. Breaking.");
                                break;
                            }
                            Log::warning("Groq API status {$status}. Retry {$attempt} after {$retryDelay}s...");
                            sleep($retryDelay);
                            $retryDelay *= 2;
                            continue;
                        }
                        break;
                    }

                    if (!$response || !$response->successful()) {
                        $fallbackReason = 'Groq API error status ' . ($response ? $response->status() : 'N/A') . ': ' . ($response ? $response->body() : 'No response');
                        Log::warning($fallbackReason);
                    } else {
                        $data     = $response->json();
                        $content  = $data['choices'][0]['message']['content'] ?? '';
                        $aiResult = json_decode(trim($content), true);
                        if (!$aiResult || !isset($aiResult['cpu'])) {
                            $fallbackReason = 'Invalid JSON from AI: ' . $content;
                        }
                    }
                } catch (\Exception $e) {
                    $fallbackReason = 'Exception in API call: ' . $e->getMessage();
                    Log::error($fallbackReason);
                }

                if (!$aiResult || !isset($aiResult['cpu'])) {
                    $lastError = 'Lỗi phản hồi từ AI: ' . ($fallbackReason ?? 'JSON không hợp lệ hoặc rỗng.');
                    Log::warning("Attempt {$attemptNo} failed: {$lastError}");
                    continue;
                }

                $title       = TextCleaner::cleanCjk($aiResult['title'] ?? 'Cấu hình Đề xuất');
                $explanation = TextCleaner::cleanCjk($aiResult['explanation'] ?? '');

                // Xác thực CPU từ DB
                $cpuId  = $aiResult['cpu'] ?? null;
                $cpuObj = null;
                if ($cpuId && is_numeric($cpuId)) {
                    $cpuObj = DB::table('components')
                        ->join('cpus', 'cpus.component_id', '=', 'components.id')
                        ->leftJoin(
                            DB::raw('(SELECT component_id, MIN(price) as price FROM component_prices GROUP BY component_id) cp'),
                            'cp.component_id', '=', 'components.id'
                        )
                        ->where('components.id', $cpuId)
                        ->select('components.id', 'components.name', 'cpus.socket', 'cpus.tdp', DB::raw('COALESCE(components.base_price, cp.price) as price'))
                        ->first();
                }
                // Fallback: lấy CPU đắt nhất trong tầm giá
                if (!$cpuObj || !(float)($cpuObj->price ?? 0)) {
                    $cpuObj = DB::table('components')
                        ->join('cpus', 'cpus.component_id', '=', 'components.id')
                        ->leftJoin(
                            DB::raw('(SELECT component_id, MIN(price) as price FROM component_prices GROUP BY component_id) cp'),
                            'cp.component_id', '=', 'components.id'
                        )
                        ->where('components.type_id', 1)
                        ->whereRaw('COALESCE(components.base_price, cp.price) > 0')
                        ->whereRaw('COALESCE(components.base_price, cp.price) <= ?', [$cpuBudget])
                        ->select('components.id', 'components.name', 'cpus.socket', 'cpus.tdp', DB::raw('COALESCE(components.base_price, cp.price) as price'))
                        ->orderByDesc('price')
                        ->first();
                }

                if (!$cpuObj) {
                    $lastError = 'Không tìm được CPU phù hợp.';
                    Log::warning("Attempt {$attemptNo}: {$lastError}");
                    continue;
                }

                // Xác thực VGA từ DB (nếu cần)
                $vgaId  = $aiResult['vga'] ?? null;
                $vgaObj = null;
                if ($needsGpu && $vgaId && is_numeric($vgaId)) {
                    $vgaObj = DB::table('components')
                        ->join('video_cards', 'video_cards.component_id', '=', 'components.id')
                        ->leftJoin(
                            DB::raw('(SELECT component_id, MIN(price) as price FROM component_prices GROUP BY component_id) cp'),
                            'cp.component_id', '=', 'components.id'
                        )
                        ->where('components.id', $vgaId)
                        ->select('components.id', 'components.name', 'video_cards.tdp', 'video_cards.chipset', DB::raw('COALESCE(components.base_price, cp.price) as price'))
                        ->first();
                }
                // Fallback: lấy VGA đắt nhất trong tầm giá
                if ($needsGpu && (!$vgaObj || !(float)($vgaObj->price ?? 0))) {
                    $vgaObj = DB::table('components')
                        ->join('video_cards', 'video_cards.component_id', '=', 'components.id')
                        ->leftJoin(
                            DB::raw('(SELECT component_id, MIN(price) as price FROM component_prices GROUP BY component_id) cp'),
                            'cp.component_id', '=', 'components.id'
                        )
                        ->where('components.type_id', 2)
                        ->whereRaw('COALESCE(components.base_price, cp.price) > 0')
                        ->whereRaw('COALESCE(components.base_price, cp.price) <= ?', [$vgaBudget])
                        ->select('components.id', 'components.name', 'video_cards.tdp', 'video_cards.chipset', DB::raw('COALESCE(components.base_price, cp.price) as price'))
                        ->orderByDesc('price')
                        ->first();
                }

                $cpuPrice    = (float)($cpuObj->price ?? 0);
                $vgaPrice    = $vgaObj ? (float)($vgaObj->price ?? 0) : 0;
                $spentOnCore = $cpuPrice + $vgaPrice;

                if ($spentOnCore > $budget * 0.80) {
                    $lastError = 'CPU + VGA chiếm quá nhiều ngân sách (' . number_format($spentOnCore) . 'đ), không đủ tiền ghép linh kiện còn lại.';
                    Log::warning("Attempt {$attemptNo}: {$lastError}");
                    continue;
                }

                // PHP tự ghép Mainboard, RAM, PSU, Storage, Case
                $remainingBudget = $budget - $spentOnCore;
                $assembled       = $this->assembleRemainingComponents($cpuObj, $vgaObj, $remainingBudget);

                if (!$assembled['success']) {
                    $lastError = $assembled['error'];
                    Log::warning("Attempt {$attemptNo}: PHP assembly failed: {$lastError}");
                    continue;
                }

                // Tổng hợp cấu hình hoàn chỉnh
                $components = [];
                $totalPrice = 0;

                $components['cpu'] = ['id' => $cpuObj->id, 'name' => $cpuObj->name, 'price' => $cpuPrice, 'image' => true];
                $totalPrice += $cpuPrice;

                $mb = $assembled['mainboard'];
                $components['mainboard'] = ['id' => $mb->id, 'name' => $mb->name, 'price' => (float)$mb->price, 'image' => true];
                $totalPrice += (float)$mb->price;

                $ram = $assembled['ram'];
                $components['ram'] = ['id' => $ram->id, 'name' => $ram->name, 'price' => (float)$ram->price, 'image' => true];
                $totalPrice += (float)$ram->price;

                if ($vgaObj) {
                    $vgaName = $vgaObj->name . (!empty($vgaObj->chipset) ? ' (' . $vgaObj->chipset . ')' : '');
                    $components['vga'] = ['id' => $vgaObj->id, 'name' => $vgaName, 'price' => $vgaPrice, 'image' => true];
                    $totalPrice += $vgaPrice;
                }

                $storage = $assembled['storage'];
                $capStr  = ($storage->capacity >= 1000) ? (($storage->capacity / 1000) . 'TB') : ($storage->capacity . 'GB');
                $components['storage'] = [
                    'id'    => $storage->id,
                    'name'  => $storage->name . (!empty($storage->capacity) && !empty($storage->type) ? ' (' . $capStr . ' ' . $storage->type . ')' : ''),
                    'price' => (float)$storage->price,
                    'image' => true,
                ];
                $totalPrice += (float)$storage->price;

                $psu     = $assembled['psu'];
                $psuWatt = $psu->wattage ?? 0;
                $components['psu'] = ['id' => $psu->id, 'name' => $psu->name . ($psuWatt ? " ({$psuWatt}W)" : ''), 'price' => (float)$psu->price, 'image' => true];
                $totalPrice += (float)$psu->price;

                $case = $assembled['case'];
                $components['case'] = ['id' => $case->id, 'name' => $case->name, 'price' => (float)$case->price, 'image' => true];
                $totalPrice += (float)$case->price;

                // Kiểm tra ngân sách cuối
                if ($totalPrice > $budget * 1.15) {
                    $lastError = 'Tổng giá vượt ngân sách (' . number_format($totalPrice) . 'đ > ' . number_format($budget * 1.15) . 'đ)';
                    Log::warning("Attempt {$attemptNo}: {$lastError}");
                    continue;
                }

                $aiBuild = [
                    'title'            => $title,
                    'explanation'      => $explanation,
                    'budget_allocated' => $budget,
                    'components'       => $components,
                    'total_price'      => $totalPrice,
                ];

                $buildType = strtolower($aiResult['build_type'] ?? ($needsGpu ? 'gaming' : 'office'));
                $aiBuild   = $this->upgradeBuild($aiBuild, $budget, $buildType, 'any', $needsGpu);
                $aiBuild['source'] = 'ai';

                $orderedKeys       = ['cpu', 'mainboard', 'ram', 'vga', 'storage', 'psu', 'case'];
                $orderedComponents = [];
                foreach ($orderedKeys as $key) {
                    if (isset($aiBuild['components'][$key])) {
                        $orderedComponents[$key] = $aiBuild['components'][$key];
                    }
                }
                $aiBuild['components'] = $orderedComponents;

                $suggestedBuilds = [$aiBuild];
                return view('pages.build_pc.ai-result', compact('suggestedBuilds', 'budget', 'needs', 'originalBudget'));
            }

            return back()->with('error', $lastError);

        } catch (\Exception $e) {
            return back()->with('error', 'Có lỗi xảy ra: ' . $e->getMessage());
        }
    }

    // ─────────────────────────────────────────────────────────────────────────
    // HELPER: PHP tự ghép Mainboard, RAM, PSU, Storage, Case dựa vào CPU/VGA
    // Đảm bảo tương thích vật lý 100% (socket, DDR, wattage)
    // ─────────────────────────────────────────────────────────────────────────
    private function assembleRemainingComponents(object $cpuObj, ?object $vgaObj, float $remainingBudget): array
    {
        $cpuSocket = $cpuObj->socket ?? null;
        $cpuTdp    = (int)($cpuObj->tdp ?? 65);
        $vgaTdp    = $vgaObj ? (int)($vgaObj->tdp ?? 0) : 0;

        // Phân bổ ngân sách còn lại: MB 29%, RAM 22%, PSU 17%, Storage 12%, Case 8%
        $mbBudget      = $remainingBudget * 0.29;
        $ramBudget     = $remainingBudget * 0.22;
        $psuBudget     = $remainingBudget * 0.17;
        $storageBudget = $remainingBudget * 0.12;
        $caseBudget    = $remainingBudget * 0.08;

        // 1. Chọn Mainboard khớp Socket CPU
        $mb = $this->pickByBudget(5, 'motherboards', $mbBudget, function ($q) use ($cpuSocket) {
            if ($cpuSocket) $q->where('motherboards.socket', $cpuSocket);
        });
        if (!$mb && $cpuSocket) {
            $mb = $this->pickByBudget(5, 'motherboards', 5000000, function ($q) use ($cpuSocket) {
                $q->where('motherboards.socket', $cpuSocket);
            }, true);
        }
        if (!$mb) {
            return ['success' => false, 'error' => 'Không tìm được Mainboard phù hợp với socket ' . ($cpuSocket ?? 'unknown')];
        }

        // 2. Chọn RAM khớp DDR của Mainboard, ưu tiên >= 16GB
        $mbSpec = DB::table('motherboards')->where('component_id', $mb->id)->first();
        $mbDdr  = $mbSpec->ddr_gen ?? null;

        $ram = $this->pickByBudget(3, 'memory', $ramBudget, function ($q) use ($mbDdr) {
            if ($mbDdr) $q->where('memory.ddr_gen', $mbDdr);
            $q->where('memory.capacity', '>=', 16);
        });
        if (!$ram && $mbDdr) {
            $ram = $this->pickByBudget(3, 'memory', $ramBudget, function ($q) use ($mbDdr) {
                $q->where('memory.ddr_gen', $mbDdr);
            });
        }
        if (!$ram && $mbDdr) {
            $ram = $this->pickByBudget(3, 'memory', 5000000, function ($q) use ($mbDdr) {
                $q->where('memory.ddr_gen', $mbDdr);
            }, true);
        }
        if (!$ram) {
            return ['success' => false, 'error' => 'Không tìm được RAM phù hợp DDR' . ($mbDdr ?? '')];
        }

        // 3. Chọn PSU đủ công suất
        $requiredWatt = $cpuTdp + $vgaTdp + ($vgaTdp > 0 ? 220 : 150);
        $psu = $this->pickByBudget(6, 'power_supplies', $psuBudget, function ($q) use ($requiredWatt) {
            $q->where('power_supplies.wattage', '>=', $requiredWatt);
        });
        if (!$psu) {
            $psu = $this->pickByBudget(6, 'power_supplies', 5000000, function ($q) use ($requiredWatt) {
                $q->where('power_supplies.wattage', '>=', $requiredWatt);
            }, true);
        }
        if (!$psu) {
            return ['success' => false, 'error' => "Không tìm được PSU đủ {$requiredWatt}W"];
        }

        // 4. Chọn Storage (ưu tiên SSD)
        $storage = $this->pickByBudget(4, 'internal_hard_drives', $storageBudget, function ($q) {
            $q->where('internal_hard_drives.type', 'SSD');
        });
        if (!$storage) {
            $storage = $this->pickByBudget(4, 'internal_hard_drives', 5000000, function ($q) {
                $q->where('internal_hard_drives.type', 'SSD');
            }, true);
        }
        if (!$storage) {
            return ['success' => false, 'error' => 'Không tìm được ổ cứng phù hợp'];
        }

        // 5. Chọn Case
        $case = $this->pickByBudget(8, 'cases', $caseBudget);
        if (!$case) {
            $case = $this->pickByBudget(8, 'cases', 5000000, null, true);
        }
        if (!$case) {
            return ['success' => false, 'error' => 'Không tìm được vỏ case phù hợp'];
        }

        return [
            'success'   => true,
            'mainboard' => $mb,
            'ram'       => $ram,
            'psu'       => $psu,
            'storage'   => $storage,
            'case'      => $case,
        ];
    }


    // CATALOG: Chỉ trả về CPU và VGA để gửi cho AI
    private function getStoreCatalog(float $budget, string $needs): array
    {
        $needsLower = strtolower($needs);
        $needsGpu   = true;

        if (str_contains($needsLower, 'văn phòng') || str_contains($needsLower, 'office')
            || str_contains($needsLower, 'học tập') || str_contains($needsLower, 'gia đình')) {
            $needsGpu = false;
        }

        $cpuLimit = max($budget * ($needsGpu ? 0.23 : 0.32), 1500000);
        $vgaLimit = max($budget * 0.38, 1500000);

        return [
            'cpus'        => $this->searchCpus($cpuLimit),
            'video_cards' => $needsGpu ? $this->searchVideoCards($vgaLimit) : [],
        ];
    }

    // HELPER: Chọn linh kiện tốt nhất trong budget
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

    // Tra cứu linh kiện phục vụ AI Function Calling (Agent Tool Use)
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

    private function searchVideoCards(float $maxPrice): array
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

        $results = (clone $query)
            ->whereRaw("{$ep} <= ?", [$maxPrice])
            ->select('components.id', 'components.name', DB::raw("{$ep} as price"), 'video_cards.tdp', 'video_cards.chipset')
            ->orderByDesc('price')
            ->limit($this->searchLimit)
            ->get()->toArray();

        if (count($results) < 5) {
            $results = $query
                ->select('components.id', 'components.name', DB::raw("{$ep} as price"), 'video_cards.tdp', 'video_cards.chipset')
                ->orderBy('price')->limit(5)->get()->toArray();
        }
        return $results;
    }



    public function upgradeBuild(array $build, float $budget, string $buildType, string $cpuBrand, bool $needsGpu): array
    {
        $remaining = $budget - $build['total_price'];
        if ($remaining < 200000) return $build;

        $cpuSpec = isset($build['components']['cpu'])
            ? DB::table('cpus')->where('component_id', $build['components']['cpu']['id'])->first() : null;
        $mbSpec  = isset($build['components']['mainboard'])
            ? DB::table('motherboards')->where('component_id', $build['components']['mainboard']['id'])->first() : null;

        $socket  = $cpuSpec->socket ?? $mbSpec->socket ?? null;
        $ddrGen  = $mbSpec->ddr_gen ?? null;
        $cpuTdp  = $cpuSpec->tdp ?? 65;

        $vgaSpec = isset($build['components']['vga'])
            ? DB::table('video_cards')->where('component_id', $build['components']['vga']['id'])->first() : null;
        $vgaTdp  = $vgaSpec->tdp ?? 0;

        $upgradePsuIfNeeded = function (int $newCpuTdp, int $newVgaTdp) use (&$build, &$remaining): bool {
            $requiredWatt    = $newCpuTdp + $newVgaTdp + ($newVgaTdp > 0 ? 220 : 150);
            $currentPsuPrice = $build['components']['psu']['price'] ?? 0;
            $psuSpec         = isset($build['components']['psu'])
                ? DB::table('power_supplies')->where('component_id', $build['components']['psu']['id'])->first() : null;
            if (($psuSpec->wattage ?? 0) >= $requiredWatt) return true; // PSU đã đủ, không cần upgrade

            $betterPsu = $this->pickByBudget(6, 'power_supplies', $currentPsuPrice + $remaining, function ($q) use ($requiredWatt) {
                $q->where('power_supplies.wattage', '>=', $requiredWatt);
            }, true);
            if (!$betterPsu) return false; // Không tìm được PSU đủ mạnh

            $psuDiff = (float)$betterPsu->price - $currentPsuPrice;
            $psuName = $betterPsu->name . (!empty($betterPsu->wattage) ? ' (' . $betterPsu->wattage . 'W)' : '');
            $build['components']['psu'] = ['id' => $betterPsu->id, 'name' => $psuName, 'price' => (float)$betterPsu->price, 'image' => true];
            $build['total_price'] += $psuDiff;
            $remaining -= $psuDiff;
            return true;
        };

        $upgradedAny = true;
        while ($remaining >= 200000 && $upgradedAny) {
            $upgradedAny = false;

            // Nâng cấp RAM
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

            // 2. Nâng cấp CPU
            if ($remaining >= 200000 && isset($build['components']['cpu'])) {
                $currentCpuPrice = $build['components']['cpu']['price'];
                $betterCpu = null;

                //X3D
                if ($buildType === 'gaming') {
                    $betterCpu = $this->pickByBudget(1, 'cpus', $currentCpuPrice + $remaining, function ($q) use ($socket) {
                        $q->whereRaw('LOWER(components.name) LIKE ?', ['%x3d%']);
                        if ($socket) $q->where('cpus.socket', $socket);
                    });
                }
                if (!$betterCpu) {
                    $betterCpu = $this->pickByBudget(1, 'cpus', $currentCpuPrice + $remaining, function ($q) use ($socket) {
                        if ($socket) $q->where('cpus.socket', $socket);
                    });
                }

                if ($betterCpu && (float)$betterCpu->price > $currentCpuPrice) {
                    $diff         = (float)$betterCpu->price - $currentCpuPrice;
                    $newCpuSpec   = DB::table('cpus')->where('component_id', $betterCpu->id)->first();
                    $newCpuTdp    = $newCpuSpec->tdp ?? 65;

                    if ($upgradePsuIfNeeded($newCpuTdp, $vgaTdp)) {
                        $build['components']['cpu'] = ['id' => $betterCpu->id, 'name' => $betterCpu->name, 'price' => (float)$betterCpu->price, 'image' => true];
                        $build['total_price'] += $diff;
                        $remaining  -= $diff;
                        $cpuTdp      = $newCpuTdp;
                        $socket      = $newCpuSpec->socket ?? $socket;
                        $upgradedAny = true;
                    }
                }
            }

            // 3. Nâng cấp VGA
            if ($needsGpu && $remaining >= 200000) {
                $currentVgaPrice = $build['components']['vga']['price'] ?? 0;
                $betterVga = $this->pickByBudget(2, 'video_cards', $currentVgaPrice + $remaining);

                if ($betterVga && (float)$betterVga->price > $currentVgaPrice) {
                    $diff       = (float)$betterVga->price - $currentVgaPrice;
                    $newVgaSpec = DB::table('video_cards')->where('component_id', $betterVga->id)->first();
                    $newVgaTdp  = $newVgaSpec->tdp ?? 0;

                    if ($upgradePsuIfNeeded($cpuTdp, $newVgaTdp)) {
                        $vgaName = $betterVga->name . (!empty($betterVga->chipset) ? ' (' . $betterVga->chipset . ')' : '');
                        $build['components']['vga'] = ['id' => $betterVga->id, 'name' => $vgaName, 'price' => (float)$betterVga->price, 'image' => true];
                        $build['total_price'] += $diff;
                        $remaining  -= $diff;
                        $vgaTdp      = $newVgaTdp;
                        $upgradedAny = true;
                    }
                }
            }

            // 4. Nâng cấp Mainboard
            if ($remaining >= 200000 && isset($build['components']['mainboard'])) {
                $currentMbPrice = $build['components']['mainboard']['price'];
                $betterMb = $this->pickByBudget(5, 'motherboards', $currentMbPrice + $remaining, function ($q) use ($socket) {
                    if ($socket) $q->where('motherboards.socket', $socket);
                });
                if ($betterMb && (float)$betterMb->price > $currentMbPrice) {
                    $diff = (float)$betterMb->price - $currentMbPrice;
                    $build['components']['mainboard'] = ['id' => $betterMb->id, 'name' => $betterMb->name, 'price' => (float)$betterMb->price, 'image' => true];
                    $build['total_price'] += $diff;
                    $remaining  -= $diff;
                    $upgradedAny = true;
                    $newMbSpec = DB::table('motherboards')->where('component_id', $betterMb->id)->first();
                    $ddrGen = $newMbSpec->ddr_gen ?? $ddrGen;
                    $socket = $newMbSpec->socket ?? $socket;
                }
            }

            // 5. Nâng cấp Storage
            if ($remaining >= 200000 && isset($build['components']['storage'])) {
                $currentStoragePrice = $build['components']['storage']['price'];
                $currentStorageSpec  = DB::table('internal_hard_drives')->where('component_id', $build['components']['storage']['id'])->first();
                $currCapacity = $currentStorageSpec->capacity ?? 256;

                $betterStorage = $this->pickByBudget(4, 'internal_hard_drives', $currentStoragePrice + $remaining, function ($q) use ($currCapacity) {
                    $q->where('internal_hard_drives.type', 'SSD')
                      ->where('internal_hard_drives.capacity', '>=', $currCapacity);
                });

                if ($betterStorage && (float)$betterStorage->price > $currentStoragePrice) {
                    $diff         = (float)$betterStorage->price - $currentStoragePrice;
                    $betterCapStr = ($betterStorage->capacity >= 1000) ? (($betterStorage->capacity / 1000) . 'TB') : ($betterStorage->capacity . 'GB');
                    $storageName  = $betterStorage->name . (!empty($betterStorage->capacity) && !empty($betterStorage->type) ? ' (' . $betterCapStr . ' ' . $betterStorage->type . ')' : '');
                    $build['components']['storage'] = ['id' => $betterStorage->id, 'name' => $storageName, 'price' => (float)$betterStorage->price, 'image' => true];
                    $build['total_price'] += $diff;
                    $remaining  -= $diff;
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
