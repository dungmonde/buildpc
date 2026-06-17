<?php

namespace App\Http\Controllers;

use App\Models\Component;
use App\Models\ComponentPrice;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class ComponentController extends Controller
{
    public function index(Request $request, $type)
    {
        $typeMap = [
            'cpu' => 1, 'gpu' => 2, 'ram' => 3, 'storage' => 4,
            'motherboard' => 5, 'psu' => 6, 'cooler' => 7, 'case' => 8,
        ];

        if (!array_key_exists($type, $typeMap)) {
            abort(404);
        }

        $typeId = $typeMap[$type];

        $specRelation = match($type) {
            'case' => 'pcCase',
            default => $type,
        };

        // Map type sang tên bảng DB để query Lấy danh sách Lọc động
        $specTable = match($type) {
            'cpu' => 'cpus',
            'gpu' => 'video_cards',
            'ram' => 'memory',
            'storage' => 'internal_hard_drives',
            'motherboard' => 'motherboards',
            'psu' => 'power_supplies',
            'cooler' => 'cpu_coolers',
            'case' => 'cases',
        };

        // Khai báo các cột muốn làm bộ lọc cho từng loại linh kiện
        $filterConfig = match($type) {
            'cpu' => ['socket' => 'Socket', 'microarchitecture' => 'Kiến trúc', 'tdp' => 'TDP (W)'],
            'gpu' => ['memory' => 'VRAM (GB)'],
            'ram' => ['capacity' => 'Dung lượng (GB)', 'speed' => 'Tốc độ (MHz)', 'ddr_gen' => 'Loại DDR'],
            'storage' => ['type' => 'Loại ổ cứng', 'capacity' => 'Dung lượng (GB)', 'form_factor' => 'Kích thước'],
            'motherboard' => ['socket' => 'Socket', 'form_factor' => 'Form Factor', 'ddr_gen' => 'Hỗ trợ RAM (DDR)'],
            'psu' => ['wattage' => 'Công suất (W)', 'efficiency' => 'Chuẩn Hiệu suất'],
            'cooler' => ['size' => 'Kích thước (mm)', 'color' => 'Màu sắc'],
            'case' => ['type' => 'Loại Case', 'color' => 'Màu sắc', 'side_panel' => 'Mặt hông'],
            default => []
        };

        // Tự động quét Database lấy các giá trị đang có thật để làm Checkbox
        $dynamicFilters = [];
        foreach ($filterConfig as $column => $label) {
            $options = DB::table($specTable)
                        ->select($column)
                        ->whereNotNull($column)
                        ->distinct()
                        ->orderBy($column)
                        ->pluck($column)
                        ->filter(fn($val) => (string)$val !== '')
                        ->values()
                        ->toArray();
            
            if (count($options) > 0) {
                $dynamicFilters[$column] = [
                    'label' => $label,
                    'options' => $options
                ];
            }
        }

        $query = Component::with(['cheapestPrice', $specRelation])
            ->where('type_id', $typeId);

        // 1. Lọc theo tên (Search)
        if ($request->filled('search')) {
            $query->where('name', 'ILIKE', '%' . $request->search . '%');
        }

        // 2. Lọc theo khoảng giá
        if ($request->filled('price_range')) {
            $range = explode('-', $request->price_range);
            if (count($range) == 2) {
                $min = (int)$range[0];
                $max = (int)$range[1];
                $query->where(function($q) use ($min, $max) {
                    $q->whereBetween('base_price', [$min, $max])
                        ->orWhereHas('prices', function($priceQuery) use ($min, $max) {
                            $priceQuery->whereBetween('price', [$min, $max]);
                        });
                });
            }
        }

        // 3. Lọc động theo Thông số (Socket, VRAM, Kiến trúc...)
        foreach ($filterConfig as $column => $label) {
            $reqKey = 'f_' . $column;
            if ($request->filled($reqKey)) {
                $query->whereHas($specRelation, function($q) use ($column, $request, $reqKey) {
                    $q->whereIn($column, $request->input($reqKey));
                });
            }
        }

        // 4. Sắp xếp
        if ($request->filled('sort')) {
            $effectivePrice = 'COALESCE(components.base_price, (SELECT MIN(price) FROM component_prices WHERE component_prices.component_id = components.id))';

            switch ($request->sort) {
                case 'price_asc':
                    $query->orderByRaw($effectivePrice . ' is null, ' . $effectivePrice . ' asc');
                    break;
                case 'price_desc':
                    $query->orderByRaw($effectivePrice . ' is null, ' . $effectivePrice . ' desc');
                    break;
                case 'name_asc':
                    $query->orderBy('name', 'asc');
                    break;
            }
        } else {
            $query->orderBy('id', 'desc');
        }

        $components = $query->paginate(16)->withQueryString();

        return view('pages.components.index', compact('components', 'type', 'specRelation', 'dynamicFilters'));
    }

    public function show($type, $id)
    {
        $typeMap = [
            'cpu' => 1, 'gpu' => 2, 'ram' => 3, 'storage' => 4,
            'motherboard' => 5, 'psu' => 6, 'cooler' => 7, 'case' => 8,
        ];

        if (!array_key_exists($type, $typeMap)) {
            abort(404);
        }

        $typeId = $typeMap[$type];

        $specRelation = match($type) {
            'case' => 'pcCase',
            default => $type,
        };

        $component = Component::with(['cheapestPrice', $specRelation])->findOrFail($id);

        // Ensure the component type from URL matches the database
        if ($component->type_id !== $typeId) {
            abort(404);
        }

        $spec = $component->{$specRelation};
        $price = $component->base_price ?? $component->cheapestPrice?->price;

        // Get 4 random related components of the same type
        $relatedComponents = Component::with('cheapestPrice')
            ->where('type_id', $component->type_id)
            ->where('id', '!=', $component->id)
            ->inRandomOrder()
            ->limit(4)
            ->get();

        return view('pages.components.show', compact('component', 'type', 'spec', 'price', 'relatedComponents'));
    }
}
