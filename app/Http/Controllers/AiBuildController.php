<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Http;
use App\Models\Component;

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

        $apiKey = env('GROQ_API_KEY');
        if (!$apiKey) {
            return back()->with('error', 'Tính năng chưa được cấu hình (thiếu API Key trong file .env).');
        }

        $budget = (float)$request->budget;
        $needs  = $request->needs;

        // AI chỉ cần quyết định: tên, mô tả, thương hiệu CPU, loại build
        $systemPrompt = <<<EOT
Bạn là chuyên gia tư vấn cấu hình PC. Đọc nhu cầu và ngân sách, trả về JSON thuần túy (không có markdown).
Quy tắc:
1. build_type chỉ được là: "gaming", "office", "workstation".
2. cpu_brand chỉ được là: "intel", "amd", "any".
3. Xử lý các yêu cầu lệch lệch/không thực tế:
   - Nếu ngân sách quá cao so với nhu cầu (ví dụ: 30-50 triệu cho văn phòng cơ bản), hãy tự động chuyển đổi build_type thành "workstation" để phân bổ thêm card đồ họa chuyên dụng và linh kiện cao cấp, đồng thời giải thích rõ trong explanation về sự nâng cấp này để tận dụng tối đa ngân sách và tránh lãng phí.
   - Nếu ngân sách quá thấp so với nhu cầu (ví dụ: 10 triệu chơi game AAA nặng), hãy chọn build_type phù hợp nhất và giải thích rõ trong explanation về giới hạn hiệu năng của cấu hình và khuyến nghị nâng cấp sau này.
4. explanation phải viết bằng 100% tiếng Việt tự nhiên và chuẩn xác, không được pha trộn hoặc sử dụng bất kỳ từ ngữ hay ký tự nước ngoài nào khác (ví dụ: tiếng Hàn như "설정", tiếng Trung, tiếng Nhật,...), không nhắc tên linh kiện cụ thể.
5. Chỉ trả về đúng 1 build.

Format bắt buộc:
{"builds":[{"title":"Tên cấu hình","explanation":"Mô tả và giải thích chi tiết...","cpu_brand":"any","build_type":"gaming"}]}
EOT;

        $prompt = "Ngân sách: " . number_format($budget) . " VNĐ.\nNhu cầu: " . $needs;

        try {
            $response = Http::withoutVerifying()->withHeaders([
                'Content-Type' => 'application/json',
                'Authorization' => 'Bearer ' . $apiKey,
            ])->post('https://api.groq.com/openai/v1/chat/completions', [
                'model'           => 'llama-3.3-70b-versatile',
                'messages'        => [
                    ['role' => 'system', 'content' => $systemPrompt],
                    ['role' => 'user',   'content' => $prompt],
                ],
                'response_format' => ['type' => 'json_object'],
            ]);

            if (!$response->successful()) {
                \Log::error('Groq API Error: ' . $response->body());
                if ($response->status() === 429) {
                    return back()->with('error', 'Hệ thống đang quá tải. Vui lòng chờ sau ít phút.');
                }
                return back()->with('error', 'Lỗi kết nối hệ thống. Vui lòng thử lại sau.');
            }

            $aiData   = $response->json();
            $jsonStr  = $aiData['choices'][0]['message']['content'] ?? '';
            $aiResult = json_decode(trim(str_replace(['```json','```'], '', $jsonStr)), true);

            if (!$aiResult || !isset($aiResult['builds'])) {
                return back()->with('error', 'Dữ liệu trả về không hợp lệ. Vui lòng thử lại.');
            }

            $suggestedBuilds = [];
            foreach ($aiResult['builds'] as $build) {
                $suggestedBuilds[] = $this->assembleBuild($build, $budget);
            }

            return view('pages.build_pc.ai-result', compact('suggestedBuilds', 'budget', 'needs'));

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
        $needsGpu  = ($buildType === 'gaming' && $budget >= 9000000)
                  || ($buildType === 'workstation' && $budget >= 20000000);

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
        $hasMb = function ($q) {
            $q->whereIn('cpus.socket', function ($sub) {
                $sub->select('socket')->from('motherboards');
            });
        };

        // 1. Try with requested brand within cpuMax
        $cpu = $this->pickByBudget(1, 'cpus', $cpuMax, function ($q) use ($cpuBrand, $cpuMin, $ep, $hasMb) {
            if ($cpuBrand !== 'any') $q->where('components.name', 'ILIKE', "%{$cpuBrand}%");
            if ($cpuMin > 0)        $q->whereRaw("{$ep} >= ?", [$cpuMin]);
            $hasMb($q);
        });
        
        // 2. Fallback: Try with any brand within cpuMax
        if (!$cpu && $cpuBrand !== 'any') {
            $cpu = $this->pickByBudget(1, 'cpus', $cpuMax, function ($q) use ($cpuMin, $ep, $hasMb) {
                if ($cpuMin > 0) $q->whereRaw("{$ep} >= ?", [$cpuMin]);
                $hasMb($q);
            });
        }
        
        // 3. Fallback: Try with requested brand up to remaining budget (reserving other slots)
        if (!$cpu) {
            $cpuLimit = max($cpuMax, $remaining - $reserve);
            $cpu = $this->pickByBudget(1, 'cpus', $cpuLimit, function ($q) use ($cpuBrand, $cpuMin, $ep, $hasMb) {
                if ($cpuBrand !== 'any') $q->where('components.name', 'ILIKE', "%{$cpuBrand}%");
                if ($cpuMin > 0)        $q->whereRaw("{$ep} >= ?", [$cpuMin]);
                $hasMb($q);
            }, true);
        }
        
        // 4. Fallback: Try with any brand up to remaining budget (reserving other slots)
        if (!$cpu) {
            $cpuLimit = max($cpuMax, $remaining - $reserve);
            $cpu = $this->pickByBudget(1, 'cpus', $cpuLimit, function ($q) use ($cpuMin, $ep, $hasMb) {
                if ($cpuMin > 0) $q->whereRaw("{$ep} >= ?", [$cpuMin]);
                $hasMb($q);
            }, true);
        }
        
        // 5. Ultimate Fallback: Select the absolute cheapest compatible CPU in the database
        if (!$cpu) {
            $cpu = \DB::table('components')
                ->join('cpus', 'cpus.component_id', '=', 'components.id')
                ->leftJoin(
                    \DB::raw('(SELECT component_id, MIN(price) as price FROM component_prices GROUP BY component_id) cp'),
                    'cp.component_id', '=', 'components.id'
                )
                ->where('components.type_id', 1)
                ->whereRaw("{$ep} > 0")
                ->whereIn('cpus.socket', function ($sub) {
                    $sub->select('socket')->from('motherboards');
                })
                ->select('components.id', 'components.name', \DB::raw("{$ep} as price"))
                ->orderBy('price')
                ->first();
        }

        if ($cpu) {
            $price = (float)$cpu->price;
            $build['components']['cpu'] = ['id' => $cpu->id, 'name' => $cpu->name, 'price' => $price, 'image' => null];
            $build['total_price'] += $price;
            $remaining -= $price;
            $cpuSpec = \DB::table('cpus')->where('component_id', $cpu->id)->first();
            $socket  = $cpuSpec->socket ?? null;
            $cpuTdp  = $cpuSpec->tdp   ?? 65;
        }

        // ── 2. MAINBOARD ──────────────────────────────────────────────────────
        $cpuPrice = isset($cpu) ? (float)$cpu->price : 0;
        $excludedChipsets = [];
        if ($cpuPrice > 10000000) {
            $excludedChipsets = ['A320','A620','H610','B450','H510','H410','B460'];
        } elseif ($cpuPrice > 6000000) {
            $excludedChipsets = ['A320','A620','H610'];
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
                $q->where('components.name', 'NOT ILIKE', "%{$chip}%");
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
                    $q->where('components.name', 'NOT ILIKE', "%{$chip}%");
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
            $mb = \DB::table('components')
                ->join('motherboards', 'motherboards.component_id', '=', 'components.id')
                ->leftJoin(
                    \DB::raw('(SELECT component_id, MIN(price) as price FROM component_prices GROUP BY component_id) cp'),
                    'cp.component_id', '=', 'components.id'
                )
                ->where('components.type_id', 5)
                ->whereRaw("{$ep} > 0")
                ->where('motherboards.socket', $socket)
                ->select('components.id', 'components.name', \DB::raw("{$ep} as price"))
                ->orderBy('price')
                ->first();
        }
        
        if ($mb) {
            $price = (float)$mb->price;
            $build['components']['mainboard'] = ['id' => $mb->id, 'name' => $mb->name, 'price' => $price, 'image' => null];
            $build['total_price'] += $price;
            $remaining -= $price;
            $mbSpec = \DB::table('motherboards')->where('component_id', $mb->id)->first();
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
            $ram = \DB::table('components')
                ->join('memory', 'memory.component_id', '=', 'components.id')
                ->leftJoin(
                    \DB::raw('(SELECT component_id, MIN(price) as price FROM component_prices GROUP BY component_id) cp'),
                    'cp.component_id', '=', 'components.id'
                )
                ->where('components.type_id', 3)
                ->whereRaw("{$ep} > 0")
                ->select('components.id', 'components.name', \DB::raw("{$ep} as price"))
                ->orderBy('price')
                ->first();
        }

        if ($ram) {
            $price = (float)$ram->price;
            $build['components']['ram'] = ['id' => $ram->id, 'name' => $ram->name, 'price' => $price, 'image' => null];
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
                    $build['components']['vga'] = ['id' => $vga->id, 'name' => $vgaName, 'price' => $price, 'image' => null];
                    $build['total_price'] += $price;
                    $remaining -= $price;
                    $vgaSpec = \DB::table('video_cards')->where('component_id', $vga->id)->first();
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
                $build['components']['vga'] = ['id' => $vga->id, 'name' => $vgaName, 'price' => $price, 'image' => null];
                $build['total_price'] += $price;
                $remaining -= $price;
                $vgaSpec = \DB::table('video_cards')->where('component_id', $vga->id)->first();
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
        
        // 9. Ultimate Fallback: Select the absolute cheapest storage in the database
        if (!$storage) {
            $storage = \DB::table('components')
                ->join('internal_hard_drives', 'internal_hard_drives.component_id', '=', 'components.id')
                ->leftJoin(
                    \DB::raw('(SELECT component_id, MIN(price) as price FROM component_prices GROUP BY component_id) cp'),
                    'cp.component_id', '=', 'components.id'
                )
                ->where('components.type_id', 4)
                ->whereRaw("{$ep} > 0")
                ->select('components.id', 'components.name', \DB::raw("{$ep} as price"))
                ->orderBy('price')
                ->first();
        }
        
        if ($storage) {
            $price = (float)$storage->price;
            $build['components']['storage'] = ['id' => $storage->id, 'name' => $storage->name, 'price' => $price, 'image' => null];
            $build['total_price'] += $price;
            $remaining -= $price;
        }

        // ── 6. PSU ────────────────────────────────────────────────────────────
        $requiredWatt = $cpuTdp + $vgaTdp + 150;
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
            $psu = \DB::table('components')
                ->join('power_supplies', 'power_supplies.component_id', '=', 'components.id')
                ->leftJoin(
                    \DB::raw('(SELECT component_id, MIN(price) as price FROM component_prices GROUP BY component_id) cp'),
                    'cp.component_id', '=', 'components.id'
                )
                ->where('components.type_id', 6)
                ->whereRaw("{$ep} > 0")
                ->select('components.id', 'components.name', \DB::raw("{$ep} as price"))
                ->orderBy('price')
                ->first();
        }
        
        if ($psu) {
            $price = (float)$psu->price;
            $build['components']['psu'] = ['id' => $psu->id, 'name' => $psu->name, 'price' => $price, 'image' => null];
            $build['total_price'] += $price;
            $remaining -= $price;
        }

        // ── 7. CASE ───────────────────────────────────────────────────────────
        $caseMax = min($alloc['case'], $remaining);
        $case    = $this->pickByBudget(8, 'cases', $caseMax);
        if (!$case) $case = $this->pickByBudget(8, 'cases', $remaining, null, true);
        
        // Ultimate Fallback: Select the absolute cheapest case in the database
        if (!$case) {
            $case = \DB::table('components')
                ->join('cases', 'cases.component_id', '=', 'components.id')
                ->leftJoin(
                    \DB::raw('(SELECT component_id, MIN(price) as price FROM component_prices GROUP BY component_id) cp'),
                    'cp.component_id', '=', 'components.id'
                )
                ->where('components.type_id', 8)
                ->whereRaw("{$ep} > 0")
                ->select('components.id', 'components.name', \DB::raw("{$ep} as price"))
                ->orderBy('price')
                ->first();
        }
        
        if ($case) {
            $price = (float)$case->price;
            $build['components']['case'] = ['id' => $case->id, 'name' => $case->name, 'price' => $price, 'image' => null];
            $build['total_price'] += $price;
            $remaining -= $price;
        }

        // ── 8. Nâng cấp VGA với tiền thừa ────────────────────────────────────
        if ($needsGpu && $remaining >= 500000 && isset($build['components']['vga'])) {
            $currentVgaPrice = $build['components']['vga']['price'];
            $betterVga       = $this->pickByBudget(2, 'video_cards', $currentVgaPrice + $remaining);
            if ($betterVga && (float)$betterVga->price > $currentVgaPrice) {
                $diff    = (float)$betterVga->price - $currentVgaPrice;
                $vgaName = $betterVga->name . (!empty($betterVga->chipset) ? ' (' . $betterVga->chipset . ')' : '');
                $build['components']['vga'] = ['id' => $betterVga->id, 'name' => $vgaName, 'price' => (float)$betterVga->price, 'image' => null];
                $build['total_price'] += $diff;
                $remaining -= $diff;
            }
        }

        return $build;
    }

    // ─────────────────────────────────────────────────────────────────────────
    // HELPER: Chọn linh kiện tốt nhất trong budget
    // ─────────────────────────────────────────────────────────────────────────
    private function pickByBudget(int $typeId, string $specTable, float $maxBudget, ?\Closure $filter = null, bool $asc = false): ?object
    {
        $ep          = 'COALESCE(components.base_price, cp.price)';
        $selectExtra = $specTable === 'video_cards' ? ['video_cards.chipset'] : [];

        $q = \DB::table('components')
            ->join($specTable, "{$specTable}.component_id", '=', 'components.id')
            ->leftJoin(
                \DB::raw('(SELECT component_id, MIN(price) as price FROM component_prices GROUP BY component_id) cp'),
                'cp.component_id', '=', 'components.id'
            )
            ->where('components.type_id', $typeId)
            ->whereRaw("{$ep} > 0")
            ->whereRaw("{$ep} <= ?", [$maxBudget])
            ->select(array_merge(['components.id', 'components.name', \DB::raw("{$ep} as price")], $selectExtra));

        if ($filter) $filter($q);

        if ($asc) {
            $q->orderBy('price');
        } else {
            $q->orderByDesc('price');
        }

        return $q->first();
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
