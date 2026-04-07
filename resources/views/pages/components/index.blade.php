@extends('layouts.app')

@php
$categoryConfig = [
    'cpu' => [
        'label'   => 'CPU',
        'cols'    => [
            ['title' => 'Số nhân',    'key' => 'core_count',        'suffix' => ' nhân'],
            ['title' => 'Xung cơ bản','key' => 'core_clock',        'suffix' => ' GHz'],
            ['title' => 'Xung boost', 'key' => 'boost_clock',       'suffix' => ' GHz'],
            ['title' => 'Kiến trúc',  'key' => 'microarchitecture', 'suffix' => ''],
            ['title' => 'TDP',        'key' => 'tdp',               'suffix' => 'W'],
            ['title' => 'Socket',     'key' => 'socket',            'suffix' => ''],
        ],
        'filters' => [
            'Socket'    => ['AM5', 'AM4', 'LGA1700', 'LGA1851'],
            'Kiến trúc' => ['Zen 5', 'Zen 4', 'Zen 3', 'Raptor Lake', 'Arrow Lake'],
            'TDP'       => ['Dưới 65W', '65W - 125W', 'Trên 125W'],
        ],
    ],
    'gpu' => [
        'label'   => 'Card đồ họa',
        'cols'    => [
            ['title' => 'Chipset',    'key' => 'chipset',     'suffix' => ''],
            ['title' => 'VRAM',       'key' => 'memory',      'suffix' => 'GB'],
            ['title' => 'Xung cơ bản','key' => 'core_clock',  'suffix' => ' MHz'],
            ['title' => 'Xung boost', 'key' => 'boost_clock', 'suffix' => ' MHz'],
            ['title' => 'Chiều dài',  'key' => 'length',      'suffix' => 'mm'],
        ],
        'filters' => [
            'VRAM'      => ['4GB', '6GB', '8GB', '12GB', '16GB', '24GB'],
            'Phân khúc' => ['Cao cấp', 'Tầm trung', 'Phổ thông'],
        ],
    ],
    'ram' => [
        'label'   => 'RAM',
        'cols'    => [
            ['title' => 'Dung lượng', 'key' => 'capacity',     'suffix' => 'GB'],
            ['title' => 'Tốc độ',     'key' => 'speed',        'suffix' => ' MHz'],
            ['title' => 'Modules',    'key' => 'module_count', 'suffix' => ''],
            ['title' => 'CAS',        'key' => 'cas_latency',  'suffix' => ''],
            ['title' => 'DDR',        'key' => 'ddr_gen',      'suffix' => ''],
        ],
        'filters' => [
            'Loại'      => ['DDR5', 'DDR4', 'DDR3'],
            'Dung lượng'=> ['8GB', '16GB', '32GB', '64GB'],
            'Tốc độ'    => ['3200MHz', '3600MHz', '4800MHz', '5600MHz', '6000MHz+'],
        ],
    ],
    'storage' => [
        'label'   => 'Ổ cứng',
        'cols'    => [
            ['title' => 'Dung lượng', 'key' => 'capacity',    'suffix' => 'GB'],
            ['title' => 'Loại',       'key' => 'type',        'suffix' => ''],
            ['title' => 'Form factor','key' => 'form_factor', 'suffix' => ''],
            ['title' => 'Giao tiếp', 'key' => 'interface',   'suffix' => ''],
            ['title' => 'Cache',      'key' => 'cache',       'suffix' => 'MB'],
        ],
        'filters' => [
            'Loại'      => ['NVMe SSD', 'SATA SSD', 'HDD'],
            'Dung lượng'=> ['500GB', '1TB', '2TB', '4TB'],
            'Giao tiếp' => ['PCIe 4.0', 'PCIe 3.0', 'SATA III'],
        ],
    ],
    'motherboard' => [
        'label'   => 'Mainboard',
        'cols'    => [
            ['title' => 'Socket',     'key' => 'socket',       'suffix' => ''],
            ['title' => 'Form factor','key' => 'form_factor',  'suffix' => ''],
            ['title' => 'RAM tối đa', 'key' => 'max_memory',   'suffix' => 'GB'],
            ['title' => 'Khe RAM',    'key' => 'memory_slots', 'suffix' => ' khe'],
            ['title' => 'DDR',        'key' => 'ddr_gen',      'suffix' => ''],
        ],
        'filters' => [
            'Socket'      => ['AM5', 'AM4', 'LGA1700', 'LGA1851'],
            'Form factor' => ['ATX', 'mATX', 'ITX'],
            'DDR'         => ['DDR5', 'DDR4'],
        ],
    ],
    'psu' => [
        'label'   => 'Nguồn',
        'cols'    => [
            ['title' => 'Công suất', 'key' => 'wattage',    'suffix' => 'W'],
            ['title' => 'Chuẩn',     'key' => 'type',       'suffix' => ''],
            ['title' => 'Hiệu suất', 'key' => 'efficiency', 'suffix' => ''],
            ['title' => 'Modular',   'key' => 'modular',    'suffix' => ''],
        ],
        'filters' => [
            'Công suất' => ['550W', '650W', '750W', '850W', '1000W+'],
            'Hiệu suất' => ['80+ Bronze', '80+ Gold', '80+ Platinum', '80+ Titanium'],
            'Modular'   => ['Full Modular', 'Semi Modular', 'Non Modular'],
        ],
    ],
    'cooler' => [
        'label'   => 'Tản nhiệt',
        'cols'    => [
            ['title' => 'Kích thước', 'key' => 'size',        'suffix' => 'mm'],
            ['title' => 'RPM',        'key' => 'rpm',         'suffix' => ' RPM'],
            ['title' => 'Tiếng ồn',   'key' => 'noise_level', 'suffix' => ' dB'],
            ['title' => 'Màu',        'key' => 'color',       'suffix' => ''],
        ],
        'filters' => [
            'Loại' => ['AIO 360mm', 'AIO 280mm', 'AIO 240mm', 'Air Cooler'],
        ],
    ],
    'case' => [
        'label'   => 'Case',
        'cols'    => [
            ['title' => 'Loại',        'key' => 'type',               'suffix' => ''],
            ['title' => 'Màu',         'key' => 'color',              'suffix' => ''],
            ['title' => 'Side panel',  'key' => 'side_panel',         'suffix' => ''],
            ['title' => 'Form factor', 'key' => 'form_factor_support','suffix' => ''],
            ['title' => 'Khoang 3.5"', 'key' => 'internal_35_bays',  'suffix' => ''],
        ],
        'filters' => [
            'Form factor' => ['Full Tower', 'Mid Tower', 'Mini ITX'],
            'Màu'         => ['Đen', 'Trắng', 'Bạc'],
        ],
    ],
];

$config  = $categoryConfig[$type] ?? ['label' => strtoupper($type), 'cols' => [], 'filters' => []];
$label   = $config['label'];
$cols    = $config['cols'];
$filters = $config['filters'];

$allCategories = [
    'cpu'         => 'CPU',
    'gpu'         => 'Card đồ họa',
    'ram'         => 'RAM',
    'storage'     => 'Ổ cứng',
    'motherboard' => 'Mainboard',
    'psu'         => 'Nguồn',
    'cooler'      => 'Tản nhiệt',
    'case'        => 'Case',
];
@endphp

@section('title', 'Chọn ' . $label)

@section('content')
<div class="max-w-7xl mx-auto px-8 py-10">

    {{-- Breadcrumb --}}
    <nav class="text-xs text-gray-400 mb-6 flex items-center gap-2">
        <a href="{{ route('home') }}" class="hover:text-black transition">Trang chủ</a>
        <span>/</span>
        <span class="text-black font-semibold">{{ $label }}</span>
    </nav>

    {{-- Tab chuyển category --}}
    <div class="flex flex-wrap gap-2 mb-8">
        @foreach($allCategories as $slug => $name)
        <a href="{{ route('components.index', $slug) }}"
           class="text-xs px-3 py-1.5 border transition
                  {{ $slug === $type
                     ? 'border-black bg-black text-white'
                     : 'border-gray-200 text-gray-600 hover:border-black hover:text-black' }}">
            {{ $name }}
        </a>
        @endforeach
    </div>

    <h1 class="text-3xl font-black uppercase mb-8">Chọn {{ $label }}</h1>

    <div class="flex gap-8">

        {{-- Sidebar --}}
        <aside class="w-56 shrink-0 text-sm">
            <div class="border border-gray-200 p-4 mb-3">
                <h3 class="font-bold uppercase text-xs tracking-wide mb-3">Giá</h3>
                <div class="space-y-2 text-gray-600">
                    @foreach(['Dưới 3 triệu', '3 - 5 triệu', '5 - 10 triệu', 'Trên 10 triệu'] as $range)
                    <label class="flex items-center gap-2 cursor-pointer hover:text-black">
                        <input type="checkbox" class="rounded border-gray-300"> {{ $range }}
                    </label>
                    @endforeach
                </div>
            </div>

            @foreach($filters as $filterName => $options)
            <div class="border border-gray-200 p-4 mb-3">
                <h3 class="font-bold uppercase text-xs tracking-wide mb-3">{{ $filterName }}</h3>
                <div class="space-y-2 text-gray-600">
                    @foreach($options as $opt)
                    <label class="flex items-center gap-2 cursor-pointer hover:text-black">
                        <input type="checkbox" class="rounded border-gray-300"> {{ $opt }}
                    </label>
                    @endforeach
                </div>
            </div>
            @endforeach
        </aside>

        {{-- Danh sách --}}
        <div class="flex-1">

            {{-- Thanh trên --}}
            <div class="flex items-center justify-between mb-4">
                <p class="text-sm text-gray-500">
                    Hiển thị <span class="font-semibold text-black">{{ $components->total() }}</span> kết quả
                </p>
                <div class="flex items-center gap-3">
                    <input type="text" placeholder="Tìm kiếm {{ $label }}..."
                           class="border border-gray-200 text-sm px-3 py-2 w-48 focus:outline-none focus:border-black">
                    <select class="border border-gray-200 text-sm px-3 py-2 focus:outline-none focus:border-black">
                        <option>Mặc định</option>
                        <option>Giá: Thấp → Cao</option>
                        <option>Giá: Cao → Thấp</option>
                        <option>Tên: A-Z</option>
                    </select>
                </div>
            </div>

            {{-- Bảng --}}
            <div class="border border-gray-200">

                {{-- Header --}}
                <div class="flex px-4 py-2 bg-gray-50 border-b border-gray-200 text-xs font-bold uppercase tracking-wide text-gray-500 gap-2">
                    <div class="w-10 shrink-0"></div>
                    <div class="flex-1">Tên</div>
                    @foreach($cols as $col)
                    <div class="w-24 shrink-0">{{ $col['title'] }}</div>
                    @endforeach
                    <div class="w-28 shrink-0 text-right">Giá</div>
                </div>

                {{-- Rows --}}
                @forelse($components as $item)
                @php
                    $spec = match($specRelation) {
                        'cpu'         => $item->cpu,
                        'gpu'         => $item->gpu,
                        'ram'         => $item->ram,
                        'storage'     => $item->storage,
                        'motherboard' => $item->motherboard,
                        'psu'         => $item->psu,
                        'cooler'      => $item->cooler,
                        'case_'       => $item->case_,
                        default       => null,
                    };
                    $price = $item->cheapestPrice?->price;
                @endphp
                <div class="flex px-4 py-3 border-b border-gray-100 hover:bg-gray-50 transition items-center text-sm group gap-2">

                    {{-- Icon --}}
                    @php
                    $icons = [
                        'cpu' => '🔲', 'gpu' => '🎮', 'ram' => '📏',
                        'storage' => '💾', 'motherboard' => '🟫',
                        'psu' => '⚡', 'cooler' => '❄️', 'case' => '🖥️',
                    ];
                    @endphp
                    <div class="w-10 h-10 shrink-0 bg-gray-100 rounded overflow-hidden">
                        <img src="{{ asset('images/components/' . $type . '/' . $item->id . '.jpg') }}"
                            onerror="this.style.display='none';this.parentElement.innerHTML=`{{ $icons[$type] ?? '📦' }}`"
                            class="w-full h-full object-contain">
                    </div>

                    {{-- Tên --}}
                    <div class="flex-1 min-w-0">
                        <a href="{{ route('components.show', [$type, $item->id]) }}"
                           class="font-semibold group-hover:underline line-clamp-2 leading-snug">
                            {{ $item->name }}
                        </a>
                    </div>

                    {{-- Spec columns --}}
                    @foreach($cols as $col)
                    <div class="w-24 shrink-0 text-gray-500 text-xs">
                        @if($col['key'] === 'module_count' && $spec)
                            {{ $spec->module_count }}x{{ $spec->module_size }}GB
                        @elseif($spec && isset($spec->{$col['key']}))
                            @if($col['key'] === 'modular')
                                {{ $spec->{$col['key']} ? 'Có' : 'Không' }}
                            @else
                                {{ $spec->{$col['key']} }}{{ $col['suffix'] }}
                            @endif
                        @else
                            —
                        @endif
                    </div>
                    @endforeach

                    {{-- Giá --}}
                    <div class="w-28 shrink-0 text-right">
                        @if($price)
                        <p class="font-black text-sm">{{ number_format($price, 0, ',', '.') }} ₫</p>
                        @else
                        <p class="text-xs text-gray-400">Liên hệ</p>
                        @endif
                        <button class="mt-1 text-xs border border-black px-2 py-1 hover:bg-black hover:text-white transition">
                            + Thêm
                        </button>
                    </div>

                </div>
                @empty
                <div class="px-4 py-12 text-center text-gray-400">
                    <p class="text-lg mb-1">Không tìm thấy {{ $label }} nào</p>
                    <p class="text-sm">Thử thay đổi bộ lọc hoặc từ khóa tìm kiếm</p>
                </div>
                @endforelse

            </div>

            {{-- Pagination --}}
            <div class="mt-8">
                {{ $components->links() }}
            </div>

        </div>
    </div>
</div>
@endsection