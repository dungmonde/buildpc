<?php

namespace App\Http\Controllers;

use Illuminate\Support\Facades\DB;

class PHPBuildFallback
{
    // =========================================================================
    // MÃ NGUỒN DỰ PHÒNG PHP FALLBACK 
    // =========================================================================

    /*
    public static function assembleBuild($controller, array $intent, float $budget): array
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
            $cpu = $controller->pickByBudget(1, 'cpus', $cpuMax, function ($q) use ($cpuMin, $ep, $hasMb) {
                $q->whereRaw('LOWER(components.name) LIKE ?', ['%x3d%']);
                if ($cpuMin > 0) $q->whereRaw("{$ep} >= CAST(? AS NUMERIC)", [$cpuMin]);
                $hasMb($q);
            });
        }

        // 1. Try with requested brand within cpuMax
        if (!$cpu) {
            $cpu = $controller->pickByBudget(1, 'cpus', $cpuMax, function ($q) use ($cpuBrand, $cpuMin, $ep, $hasMb) {
                if ($cpuBrand !== 'any') $q->whereRaw('LOWER(components.name) LIKE ?', ['%' . strtolower($cpuBrand) . '%']);
                if ($cpuMin > 0)        $q->whereRaw("{$ep} >= CAST(? AS NUMERIC)", [$cpuMin]);
                $hasMb($q);
            });
        }
        
        // 2. Fallback: Try with any brand within cpuMax
        if (!$cpu && $cpuBrand !== 'any') {
            $cpu = $controller->pickByBudget(1, 'cpus', $cpuMax, function ($q) use ($cpuMin, $ep, $hasMb) {
                if ($cpuMin > 0) $q->whereRaw("{$ep} >= CAST(? AS NUMERIC)", [$cpuMin]);
                $hasMb($q);
            });
        }
        
        // 3. Fallback: Try with requested brand up to remaining budget (reserving other slots)
        if (!$cpu) {
            $cpuLimit = max($cpuMax, $remaining - $reserve);
            $cpu = $controller->pickByBudget(1, 'cpus', $cpuLimit, function ($q) use ($cpuBrand, $cpuMin, $ep, $hasMb) {
                if ($cpuBrand !== 'any') $q->whereRaw('LOWER(components.name) LIKE ?', ['%' . strtolower($cpuBrand) . '%']);
                if ($cpuMin > 0)        $q->whereRaw("{$ep} >= CAST(? AS NUMERIC)", [$cpuMin]);
                $hasMb($q);
            }, true);
        }
        
        // 4. Fallback: Try with any brand up to remaining budget (reserving other slots)
        if (!$cpu) {
            $cpuLimit = max($cpuMax, $remaining - $reserve);
            $cpu = $controller->pickByBudget(1, 'cpus', $cpuLimit, function ($q) use ($cpuMin, $ep, $hasMb) {
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
            $excludedChipsets = ['B550', 'X570', 'B650', 'X670', 'B660', 'B760', 'Z690', 'Z790', 'H770', 'Z890', 'B850', 'X870'];
        }
        $reserve = $remainingFloors(['ram', 'vga', 'storage', 'psu', 'case']);
        $mbMax = min($alloc['mainboard'], $remaining - $reserve);
        
        // 1. Try with chipset filter within mbMax
        $mb = $controller->pickByBudget(5, 'motherboards', $mbMax, function ($q) use ($socket, $excludedChipsets) {
            if ($socket) $q->where('motherboards.socket', $socket);
            foreach ($excludedChipsets as $chip) {
                $q->whereRaw('LOWER(components.name) NOT LIKE ?', ['%' . strtolower($chip) . '%']);
            }
        });
        
        // 2. Fallback: Skip chipset filter within mbMax
        if (!$mb && $socket) {
            $mb = $controller->pickByBudget(5, 'motherboards', $mbMax, function ($q) use ($socket) {
                $q->where('motherboards.socket', $socket);
            });
        }
        
        // 3. Fallback: Try with chipset filter up to remaining budget (reserving other slots)
        if (!$mb && $socket) {
            $reserve = $remainingFloors(['ram', 'vga', 'storage', 'psu', 'case']);
            $mbLimit = max($mbMax, $remaining - $reserve);
            $mb = $controller->pickByBudget(5, 'motherboards', $mbLimit, function ($q) use ($socket, $excludedChipsets) {
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
            $mb = $controller->pickByBudget(5, 'motherboards', $mbLimit, function ($q) use ($socket) {
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
        $ram = $controller->pickByBudget(3, 'memory', $ramMax, function ($q) use ($ramCapacity, $ddrGen) {
            $q->where('memory.capacity', '>=', $ramCapacity);
            if ($ddrGen) $q->where('memory.ddr_gen', $ddrGen);
        });
        
        // 2. Fallback: Try with target capacity and DDR gen up to remaining budget (reserving other slots)
        if (!$ram) {
            $reserve = $remainingFloors(['vga', 'storage', 'psu', 'case']);
            $ramLimit = max($ramMax, $remaining - $reserve);
            $ram = $controller->pickByBudget(3, 'memory', $ramLimit, function ($q) use ($ramCapacity, $ddrGen) {
                $q->where('memory.capacity', '>=', $ramCapacity);
                if ($ddrGen) $q->where('memory.ddr_gen', $ddrGen);
            }, true);
        }
        
        // 3. Fallback: Lower capacity to 8GB (for gaming) within ramMax
        if (!$ram && $ramCapacity > 8) {
            $ram = $controller->pickByBudget(3, 'memory', $ramMax, function ($q) use ($ddrGen) {
                $q->where('memory.capacity', '>=', 8);
                if ($ddrGen) $q->where('memory.ddr_gen', $ddrGen);
            });
        }
        
        // 4. Fallback: Lower capacity to 8GB (for gaming) up to remaining budget (reserving other slots)
        if (!$ram && $ramCapacity > 8) {
            $reserve = $remainingFloors(['vga', 'storage', 'psu', 'case']);
            $ramLimit = max($ramMax, $remaining - $reserve);
            $ram = $controller->pickByBudget(3, 'memory', $ramLimit, function ($q) use ($ramCapacity, $ddrGen) {
                $q->where('memory.capacity', '>=', 8);
                if ($ddrGen) $q->where('memory.ddr_gen', $ddrGen);
            }, true);
        }
        
        // 5. Fallback: Lower capacity to 4GB up to remaining budget (reserving other slots), skipping DDR check if needed
        if (!$ram) {
            $reserve = $remainingFloors(['vga', 'storage', 'psu', 'case']);
            $ramLimit = max($ramMax, $remaining - $reserve);
            $ram = $controller->pickByBudget(3, 'memory', $ramLimit, function ($q) {
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
                $vga = $controller->pickByBudget(2, 'video_cards', $vgaMax);
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
            $vga = $controller->pickByBudget(2, 'video_cards', $vgaLimit, null, true);
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
        $storage = $controller->pickByBudget(4, 'internal_hard_drives', $storageMax, function ($q) use ($storageMin) {
            $q->where('internal_hard_drives.capacity', '>=', $storageMin)
              ->where('internal_hard_drives.type', 'SSD');
        });
        
        // 2. Fallback: SSD lower capacity within storageMax
        if (!$storage && $storageMin > 120) {
            $storage = $controller->pickByBudget(4, 'internal_hard_drives', $storageMax, function ($q) {
                $q->where('internal_hard_drives.capacity', '>=', 120)
                  ->where('internal_hard_drives.type', 'SSD');
            });
        }
        
        // 3. Fallback: SSD even lower capacity (60GB) within storageMax
        if (!$storage) {
            $storage = $controller->pickByBudget(4, 'internal_hard_drives', $storageMax, function ($q) {
                $q->where('internal_hard_drives.capacity', '>=', 60)
                  ->where('internal_hard_drives.type', 'SSD');
            });
        }
        
        // 4. Fallback: SSD standard capacity up to remaining budget (reserving other slots)
        if (!$storage) {
            $reserve = $remainingFloors(['psu', 'case']);
            $storageLimit = max($storageMax, $remaining - $reserve);
            $storage = $controller->pickByBudget(4, 'internal_hard_drives', $storageLimit, function ($q) use ($storageMin) {
                $q->where('internal_hard_drives.capacity', '>=', $storageMin)
                  ->where('internal_hard_drives.type', 'SSD');
            }, true);
        }
        
        // 5. Fallback: SSD lower capacity up to remaining budget (reserving other slots)
        if (!$storage && $storageMin > 120) {
            $reserve = $remainingFloors(['psu', 'case']);
            $storageLimit = max($storageMax, $remaining - $reserve);
            $storage = $controller->pickByBudget(4, 'internal_hard_drives', $storageLimit, function ($q) {
                $q->where('internal_hard_drives.capacity', '>=', 120)
                  ->where('internal_hard_drives.type', 'SSD');
            }, true);
        }

        // 5.1. Fallback: SSD even lower capacity (60GB) up to remaining budget
        if (!$storage) {
            $reserve = $remainingFloors(['psu', 'case']);
            $storageLimit = max($storageMax, $remaining - $reserve);
            $storage = $controller->pickByBudget(4, 'internal_hard_drives', $storageLimit, function ($q) {
                $q->where('internal_hard_drives.capacity', '>=', 60)
                  ->where('internal_hard_drives.type', 'SSD');
            }, true);
        }
        
        // 6. Fallback: HDD standard capacity within storageMax
        if (!$storage) {
            $storage = $controller->pickByBudget(4, 'internal_hard_drives', $storageMax, function ($q) use ($storageMin) {
                $q->where('internal_hard_drives.capacity', '>=', $storageMin);
            });
        }
        
        // 7. Fallback: HDD standard capacity up to remaining budget (reserving other slots)
        if (!$storage) {
            $reserve = $remainingFloors(['psu', 'case']);
            $storageLimit = max($storageMax, $remaining - $reserve);
            $storage = $controller->pickByBudget(4, 'internal_hard_drives', $storageLimit, function ($q) use ($storageMin) {
                $q->where('internal_hard_drives.capacity', '>=', $storageMin);
            }, true);
        }
        
        // 8. Fallback: Any storage up to remaining budget (reserving other slots)
        if (!$storage) {
            $reserve = $remainingFloors(['psu', 'case']);
            $storageLimit = max($storageMax, $remaining - $reserve);
            $storage = $controller->pickByBudget(4, 'internal_hard_drives', $storageLimit, null, true);
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
        $psu = $controller->pickByBudget(6, 'power_supplies', $psuMax, function ($q) use ($requiredWatt) {
            $q->where('power_supplies.wattage', '>=', $requiredWatt);
        });
        if (!$psu) {
            $reserve = $remainingFloors(['case']);
            $psuLimit = max($psuMax, $remaining - $reserve);
            $psu = $controller->pickByBudget(6, 'power_supplies', $psuLimit, function ($q) use ($requiredWatt) {
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
        $case    = $controller->pickByBudget(8, 'cases', $caseMax);
        if (!$case) $case = $controller->pickByBudget(8, 'cases', $remaining, null, true);
        
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

        $build = $controller->upgradeBuild($build, $budget, $buildType, $cpuBrand, $needsGpu);

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
    */
}
