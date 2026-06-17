@php
$categoryConfig = [
    'cpu' => [
        'relation' => 'cpu',
        'cols'    => [
            ['title' => 'Số nhân',    'key' => 'core_count',        'suffix' => ' nhân'],
            ['title' => 'Xung cơ bản','key' => 'core_clock',        'suffix' => ' GHz'],
            ['title' => 'TDP',        'key' => 'tdp',               'suffix' => 'W'],
            ['title' => 'Socket',     'key' => 'socket',            'suffix' => ''],
        ]
    ],
    'vga' => [
        'relation' => 'gpu',
        'cols'    => [
            ['title' => 'Chipset',    'key' => 'chipset',     'suffix' => ''],
            ['title' => 'VRAM',       'key' => 'memory',      'suffix' => 'GB'],
            ['title' => 'TDP',        'key' => 'tdp',         'suffix' => ' W'],
        ]
    ],
    'ram' => [
        'relation' => 'ram',
        'cols'    => [
            ['title' => 'Dung lượng', 'key' => 'capacity',     'suffix' => 'GB'],
            ['title' => 'Tốc độ',     'key' => 'speed',        'suffix' => ' MHz'],
            ['title' => 'DDR',        'key' => 'ddr_gen',      'suffix' => ''],
        ]
    ],
    'storage' => [
        'relation' => 'storage',
        'cols'    => [
            ['title' => 'Dung lượng', 'key' => 'capacity',    'suffix' => 'GB'],
            ['title' => 'Loại',       'key' => 'type',        'suffix' => ''],
            ['title' => 'Giao tiếp',  'key' => 'interface',   'suffix' => ''],
        ]
    ],
    'mainboard' => [
        'relation' => 'motherboard',
        'cols'    => [
            ['title' => 'Socket',     'key' => 'socket',       'suffix' => ''],
            ['title' => 'Form factor','key' => 'form_factor',  'suffix' => ''],
            ['title' => 'DDR',        'key' => 'ddr_gen',      'suffix' => ''],
        ]
    ],
    'psu' => [
        'relation' => 'psu',
        'cols'    => [
            ['title' => 'Công suất', 'key' => 'wattage',    'suffix' => 'W'],
            ['title' => 'Chuẩn',     'key' => 'type',       'suffix' => ''],
            ['title' => 'Hiệu suất', 'key' => 'efficiency', 'suffix' => ''],
        ]
    ],
    'cooler' => [
        'relation' => 'cooler',
        'cols'    => [
            ['title' => 'RPM',        'key' => 'rpm',         'suffix' => ' RPM'],
            ['title' => 'Tiếng ồn',   'key' => 'noise_level', 'suffix' => ' dB'],
        ]
    ],
    'case' => [
        'relation' => 'pcCase',
        'cols'    => [
            ['title' => 'Loại',        'key' => 'type',               'suffix' => ''],
            ['title' => 'Màu',         'key' => 'color',              'suffix' => ''],
        ]
    ],
];

$config  = $categoryConfig[$category] ?? ['relation' => null, 'cols' => []];
$relation = $config['relation'];
$cols    = $config['cols'];

$icons = [
    'cpu' => '🔲', 'vga' => '🎮', 'ram' => '📏',
    'storage' => '💾', 'mainboard' => '🟫',
    'psu' => '⚡', 'cooler' => '❄️', 'case' => '🖥️',
];

$imgMap = [
    'cpu' => 'cpu', 'vga' => 'gpu', 'mainboard' => 'motherboard',
    'ram' => 'ram', 'storage' => 'storage', 'psu' => 'psu', 'case' => 'case', 'cooler' => 'cooler'
];
@endphp

@if(isset($filterMessage) && $filterMessage)
    <div class="mb-4 text-xs text-emerald-700 bg-emerald-50 px-4 py-2 rounded-xl border border-emerald-200">✓ {{ $filterMessage }}</div>
@endif
@if(isset($recommendedWattage) && $recommendedWattage > 0)
    <div class="mb-4 text-xs text-slate-600 bg-slate-100 px-4 py-2 rounded-xl border border-slate-200">Mức nguồn an toàn đề xuất cho hệ thống của bạn là: <strong class="text-emerald-600">{{ $recommendedWattage }}W</strong></div>
@endif

<div class="rounded-2xl bg-white border border-slate-200 overflow-hidden shadow-sm">
    <div class="flex px-4 py-2 bg-slate-50 text-[10px] font-bold uppercase tracking-wide text-slate-500 gap-2 items-center">
        <div class="w-10 shrink-0"></div>
        <div class="flex-1">Tên</div>
        @foreach($cols as $col)
        <div class="w-20 shrink-0">{{ $col['title'] }}</div>
        @endforeach
        <div class="w-36 shrink-0 text-right">Giá</div>
    </div>

    @forelse($items as $item)
    @php
        $spec = $relation ? $item->{$relation} : null;
        $price = $item->base_price ?? $item->cheapestPrice?->price;
        $isRecommended = ($category === 'psu' && isset($recommendedWattage) && $recommendedWattage > 0 && isset($item->psu) && $item->psu->wattage >= $recommendedWattage && $item->psu->wattage <= $recommendedWattage + 250);
    @endphp
    <div class="flex px-4 py-3 border-b border-slate-100 hover:bg-slate-50 transition items-center text-xs group gap-2">
        <div class="w-10 h-10 shrink-0 bg-slate-100 rounded overflow-hidden flex items-center justify-center border border-slate-200">
            <img src="{{ asset('images/components/' . ($imgMap[$category] ?? $category) . '/' . $item->id . '.jpg') }}"
                 onerror="this.style.display='none';this.parentElement.innerHTML=`{{ $icons[$category] ?? '📦' }}`"
                 class="w-full h-full object-contain">
        </div>

        <div class="flex-1 min-w-0 flex items-center flex-wrap gap-y-1">
            <span class="font-semibold text-slate-800 line-clamp-2 leading-snug">
                @if($category === 'mainboard' && $item->motherboard?->chipset)
                    {{ $item->manufacturer }} {{ $item->motherboard->chipset }}
                @elseif($category === 'vga' && $item->gpu?->chipset)
                    {{ $item->manufacturer }} {{ $item->gpu->chipset }}
                @else
                    {{ $item->name }}
                @endif
            </span>
            @if($isRecommended)
                <span class="inline-flex items-center gap-0.5 px-1.5 py-0.5 rounded-full text-[9px] font-bold bg-emerald-100 text-emerald-800 ml-1.5 shrink-0">
                    Khuyến nghị
                </span>
            @endif
        </div>

        @foreach($cols as $col)
        <div class="w-20 shrink-0 text-slate-500 text-[10px]">
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

        <div class="w-36 shrink-0 flex items-center justify-end gap-3">
            <div class="text-right">
                @if($price)
                <p class="font-black text-xs text-slate-900">{{ number_format($price, 0, ',', '.') }} ₫</p>
                @else
                <p class="text-[10px] text-gray-400">Liên hệ</p>
                @endif
            </div>
            <a href="{{ route('build.add', ['category' => $category, 'component_id' => $item->id]) }}"
               class="w-7 h-7 rounded-full bg-slate-900 text-white hover:bg-slate-800 transition flex items-center justify-center font-bold text-sm shrink-0 shadow-sm"
               title="Chọn sản phẩm này">
                +
            </a>
        </div>
    </div>
    @empty
    <div class="px-4 py-8 text-center text-gray-400 text-xs">
        <p>Không tìm thấy sản phẩm nào</p>
    </div>
    @endforelse
</div>
