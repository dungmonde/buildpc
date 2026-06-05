<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class RecommendController extends Controller
{
    public function index()
    {
        return view('pages.builder.recommend');
    }

    public function recommend(Request $request)
    {
        $budget   = (int) $request->input('budget', 10000000);
        $usage    = $request->input('usage', 'gaming');
        $priority = $request->input('priority', 'balanced');

        $slots = [
            'CPU'         => 'cpus',
            'GPU'         => 'video_cards',
            'MOTHERBOARD' => 'motherboards',
            'RAM'         => 'memory',
            'STORAGE'     => 'internal_hard_drives',
            'PSU'         => 'power_supplies',
            'COOLER'      => 'cpu_coolers',
            'CASE'        => 'cases',
        ];

        $types = DB::table('component_types')->pluck('id', 'type_name');
        $ratios = $this->getBudgetRatios($usage, $priority);

        // === VÒNG 1: Chọn linh kiện theo tỉ lệ ban đầu ===
        $result     = [];
        $spent      = [];

        foreach ($slots as $typeName => $specTable) {
            $typeId   = $types[$typeName] ?? null;
            if (!$typeId) continue;

            $ratioKey = strtolower($typeName);
            $maxPrice = $budget * ($ratios[$ratioKey] ?? 0.05);

            $component = $this->pickBestComponent($typeId, $maxPrice, $specTable, $usage, $priority);

            if ($component) {
                $result[$typeName] = $component;
                $spent[$typeName]  = $component->price;
            }
        }

        // === VÒNG 2: Phân phối ngân sách dư vào linh kiện quan trọng ===
        $totalSpent  = array_sum($spent);
        $remaining   = $budget - $totalSpent;

        if ($remaining > 0) {
            // Thứ tự ưu tiên nhận ngân sách dư theo nhu cầu
            $upgradeOrder = match($usage) {
                'gaming'    => ['GPU', 'CPU', 'RAM', 'STORAGE'],
                'render'    => ['CPU', 'RAM', 'GPU', 'STORAGE'],
                'streaming' => ['CPU', 'GPU', 'RAM', 'STORAGE'],
                'office'    => ['CPU', 'RAM', 'STORAGE', 'MOTHERBOARD'],
                default     => ['GPU', 'CPU', 'RAM'],
            };

            foreach ($upgradeOrder as $typeName) {
                if ($remaining <= 0) break;
                if (!isset($slots[$typeName])) continue;

                $typeId    = $types[$typeName] ?? null;
                if (!$typeId) continue;

                $specTable = $slots[$typeName];

                // Ngân sách mới = giá hiện tại đang dùng + toàn bộ dư
                $currentPrice = $spent[$typeName] ?? 0;
                $newMaxPrice  = $currentPrice + $remaining;

                $upgraded = $this->pickBestComponent($typeId, $newMaxPrice, $specTable, $usage, $priority);

                if ($upgraded && $upgraded->price > $currentPrice) {
                    $diff = $upgraded->price - $currentPrice;
                    $remaining -= $diff;
                    $result[$typeName] = $upgraded;
                    $spent[$typeName]  = $upgraded->price;
                }
            }
        }

        $totalPrice = array_sum($spent);

        return view('pages.builder.recommend', compact('result', 'totalPrice', 'budget', 'usage', 'priority'));
    }

    private function pickBestComponent(int $typeId, float $maxPrice, string $specTable, string $usage, string $priority): ?object
    {
        $effectivePrice = 'COALESCE(components.base_price, cp.price)';

        $query = DB::table('components')
            ->join($specTable, $specTable . '.component_id', '=', 'components.id')
            ->leftJoin(
                DB::raw('(SELECT component_id, MIN(price) as price FROM component_prices GROUP BY component_id) cp'),
                'cp.component_id', '=', 'components.id'
            )
            ->where('components.type_id', $typeId)
            ->whereRaw($effectivePrice . ' <= ?', [$maxPrice])
            ->whereRaw($effectivePrice . ' > 0')
            ->select('components.id', 'components.name', DB::raw($effectivePrice . ' as price'));

        if ($specTable === 'cpus') {
            if (in_array($usage, ['render', 'streaming'])) {
                $query->orderByDesc('cpus.core_count');
            } else {
                $query->orderByDesc('cpus.boost_clock');
            }
        } elseif ($specTable === 'video_cards') {
            $query->orderByDesc('video_cards.memory')
                  ->orderByDesc('video_cards.boost_clock');
        } elseif ($specTable === 'memory') {
            $query->orderByDesc('memory.capacity')
                  ->orderByDesc('memory.speed');
        } elseif ($specTable === 'internal_hard_drives') {
            $query->orderByDesc('internal_hard_drives.capacity');
        } elseif ($specTable === 'power_supplies') {
            $query->orderByDesc('power_supplies.wattage');
        } elseif ($specTable === 'cpu_coolers') {
            if ($priority === 'quiet') {
                $query->orderBy('cpu_coolers.noise_level');
            }
        }

        $query->orderByDesc('price');

        return $query->first();
    }

    private function getBudgetRatios(string $usage, string $priority): array
    {
        $base = match($usage) {
            'gaming' => [
                'cpu'         => 0.20,
                'gpu'         => 0.33,
                'motherboard' => 0.11,
                'ram'         => 0.09,
                'storage'     => 0.07,
                'psu'         => 0.08,
                'cooler'      => 0.05,
                'case'        => 0.07,
            ],
            'render' => [
                'cpu'         => 0.27,
                'gpu'         => 0.22,
                'motherboard' => 0.11,
                'ram'         => 0.16,
                'storage'     => 0.09,
                'psu'         => 0.07,
                'cooler'      => 0.04,
                'case'        => 0.04,
            ],
            'office' => [
                'cpu'         => 0.27,
                'gpu'         => 0.08,
                'motherboard' => 0.14,
                'ram'         => 0.14,
                'storage'     => 0.13,
                'psu'         => 0.10,
                'cooler'      => 0.06,
                'case'        => 0.08,
            ],
            'streaming' => [
                'cpu'         => 0.25,
                'gpu'         => 0.25,
                'motherboard' => 0.11,
                'ram'         => 0.13,
                'storage'     => 0.08,
                'psu'         => 0.08,
                'cooler'      => 0.04,
                'case'        => 0.06,
            ],
            default => [
                'cpu'         => 0.21,
                'gpu'         => 0.30,
                'motherboard' => 0.12,
                'ram'         => 0.10,
                'storage'     => 0.08,
                'psu'         => 0.08,
                'cooler'      => 0.05,
                'case'        => 0.06,
            ],
        };

        if ($priority === 'performance') {
            $base['cpu']    = min($base['cpu'] + 0.05, 0.38);
            $base['gpu']    = min($base['gpu'] + 0.05, 0.42);
            $base['case']   = max($base['case']   - 0.03, 0.02);
            $base['cooler'] = max($base['cooler'] - 0.02, 0.02);
        }

        return $base;
    }

    public function applyRecommend(Request $request)
    {
        $components = $request->input('components', []);

        $typeMap = [
            'CPU'         => 'cpu',
            'GPU'         => 'vga',
            'MOTHERBOARD' => 'mainboard',
            'RAM'         => 'ram',
            'STORAGE'     => 'storage',
            'PSU'         => 'psu',
            'COOLER'      => 'cooler',
            'CASE'        => 'case',
        ];

        foreach ($components as $typeName => $componentId) {
            $key = $typeMap[$typeName] ?? null;
            if (!$key) continue;

            $component = DB::table('components')
                ->leftJoin(
                    DB::raw('(SELECT component_id, MIN(price) as price FROM component_prices GROUP BY component_id) cp'),
                    'cp.component_id', '=', 'components.id'
                )
                ->where('components.id', $componentId)
                ->select(
                    'components.id',
                    'components.name',
                    DB::raw('COALESCE(components.base_price, cp.price) as price')
                )
                ->first();

            if ($component) {
                session(["build.{$key}" => [
                    'id'    => $component->id,
                    'name'  => $component->name,
                    'price' => $component->price,
                ]]);
            }
        }

        return redirect()->route('builder.manual')
            ->with('success', 'Đã áp dụng');
    }
}
