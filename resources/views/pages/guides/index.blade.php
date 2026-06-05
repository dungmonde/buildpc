@extends('layouts.app')

@section('title', 'Hướng dẫn cấu hình')

@section('content')

{{-- Header (no border) --}}
<div class="text-center py-8 px-6 max-w-7xl mx-auto mb-10 bg-white">
    <h1 class="text-2xl font-bold text-slate-900">Hướng dẫn cấu hình</h1>
</div>

<div class="max-w-7xl mx-auto px-8 py-10">

    {{-- Nhóm 1: Gaming + Streaming --}}
    <h2 class="font-bold text-sm mb-4">Gaming / Streaming</h2>
    <div class="grid grid-cols-2 md:grid-cols-4 gap-4 mb-12">
        @foreach([
            [
                'title' => 'Cấu hình AMD Gaming Phổ thông',
                'cpu' => 'AMD Ryzen 5 7600X',
                'gpu' => 'GeForce RTX 5060 Ti',
                'case_img' => 'case-1.jpg',
                'cpu_img' => '9600x.jpg',
                'gpu_img' => '5060ti.jpg',
            ],
            [
                'title' => 'Cấu hình Intel Gaming Phổ thông',
                'cpu' => 'Intel Core i5-14600K',
                'gpu' => 'GeForce RTX 5060 Ti',
                'case' => 'Montech XR ATX Mid Tower',
                'price' => '26.800.000 ₫',
                'comments' => 23,
                'case_img' => 'case-1.jpg',
                'cpu_img' => '14600k.jpg',
                'gpu_img' => '5060ti.jpg',
            ],
            [
                'title' => 'Cấu hình AMD Gaming Tầm trung',
                'cpu' => 'AMD Ryzen 5 9600X',
                'gpu' => 'GeForce RTX 5070',
                'case' => 'Lian Li LANCOOL 205M',
                'price' => '26.500.000 ₫',
                'comments' => 73,
                'case_img' => 'case-2.jpg',
                'cpu_img' => '9600x.jpg',
                'gpu_img' => '5070.jpg',
            ],
            [
                'title' => 'Cấu hình Intel Gaming Tầm trung',
                'cpu' => 'Intel Core i5-14600K',
                'gpu' => 'GeForce RTX 5070',
                'case' => 'Lian Li LANCOOL 205M',
                'price' => '27.600.000 ₫',
                'comments' => 19,
                'case_img' => 'case-2.jpg',
                'cpu_img' => '14600k.jpg',
                'gpu_img' => '5070.jpg',
            ],
            [
                'title' => 'Cấu hình AMD Gaming Cận cao cấp',
                'cpu' => 'AMD Ryzen 5 9600X',
                'gpu' => 'GeForce RTX 5070 Ti',
                'case' => 'Phanteks XT PRO ULTRA ATX',
                'price' => '31.500.000 ₫',
                'comments' => 40,
                'case_img' => 'case-3.jpg',
                'cpu_img' => '9600x.jpg',
                'gpu_img' => '5070ti.jpg',
            ],
            [
                'title' => 'Cấu hình Intel Gaming Cận cao cấp',
                'cpu' => 'Intel Core i5-14600K',
                'gpu' => 'GeForce RTX 5070 Ti',
                'case' => 'Phanteks XT PRO ULTRA ATX',
                'price' => '33.000.000 ₫',
                'comments' => 4,
                'case_img' => 'case-3.jpg',
                'cpu_img' => '14600k.jpg',
                'gpu_img' => '5070ti.jpg',
            ],
            [
                'title' => 'Cấu hình AMD Gaming Cao cấp',
                'cpu' => 'AMD Ryzen 7 9800X3D',
                'gpu' => 'GeForce RTX 5080',
                'case' => 'Corsair 3500X ARGB ATX',
                'price' => '46.800.000 ₫',
                'comments' => 42,
                'case_img' => 'case-4.jpg',
                'cpu_img' => '9800x3d.jpg',
                'gpu_img' => '5080.jpg',
            ],
            [
                'title' => 'Cấu hình Intel Gaming Cao cấp',
                'cpu' => 'Intel Core i7-14700K',
                'gpu' => 'GeForce RTX 5080',
                'case' => 'Corsair 3500X ARGB ATX',
                'price' => '48.500.000 ₫',
                'comments' => 15,
                'case_img' => 'case-4.jpg',
                'cpu_img' => '14700k.jpg',
                'gpu_img' => '5080.jpg',
            ],
            [
                'title' => 'Cấu hình AMD Gaming Vô Đối',
                'cpu' => 'AMD Ryzen 9 9950X3D',
                'gpu' => 'GeForce RTX 5090',
                'case' => 'Fractal Design Meshify 3 XL',
                'price' => '95.000.000 ₫',
                'comments' => 68,
                'case_img' => 'case-5.jpg',
                'cpu_img' => '9950x3d.jpg',
                'gpu_img' => '5090.jpg',
            ],
        ] as $build)
        <a href="{{ route('build.apply-guide', ['cpu' => $build['cpu'], 'gpu' => $build['gpu']]) }}" class="group relative flex flex-col items-center justify-center p-6 rounded-3xl bg-white shadow-sm ring-1 ring-slate-200 transition-all hover:shadow-md hover:ring-slate-300">
            {{-- 3 Ảnh xếp như PCPartPicker --}}
            <div class="bg-white h-44 relative overflow-hidden w-full">
                @if($build['case_img'] || $build['cpu_img'] || $build['gpu_img'])
                    <img src="{{ asset('images/guides/' . $build['case_img']) }}"
                         class="absolute bottom-0 left-2 h-36 object-contain" alt="Case">
                    <img src="{{ asset('images/guides/' . $build['cpu_img']) }}"
                         class="absolute top-2 right-2 h-20 object-contain" alt="CPU">
                    <img src="{{ asset('images/guides/' . $build['gpu_img']) }}"
                         class="absolute bottom-2 right-2 h-16 object-contain" alt="GPU">
                @else
                    <div class="absolute inset-0 flex flex-col items-center justify-center text-gray-300 text-xs">
                        <div class="text-4xl mb-2">🖥️</div>
                        Chưa có ảnh
                    </div>
                @endif
            </div>

            {{-- Nội dung --}}
            <div class="p-4">
                <h3 class="font-bold text-sm group-hover:underline leading-tight mb-2">
                    {{ $build['title'] }}
                </h3>
                <p class="text-xs text-gray-500">{{ $build['cpu'] }}</p>
                <p class="text-xs text-gray-500 mt-0.5">{{ $build['gpu'] }}</p>
            </div>
        </a>
        @endforeach
    </div>

    {{-- Nhóm 2: Gaming --}}
    <h2 class="font-bold text-sm mb-4">Gaming</h2>
    <div class="grid grid-cols-2 md:grid-cols-4 gap-4 mb-12">
        @foreach([
            [
                'title' => 'Cấu hình AMD Gaming Phổ Thông',
                'cpu' => 'AMD Ryzen 5 5600',
                'gpu' => 'Arc B580',
                'case' => 'Cooler Master Q300L V2',
                'price' => '16.800.000 ₫',
                'comments' => 40,
                'case_img' => 'case-6.jpg',
                'cpu_img' => '5600.jpg',
                'gpu_img' => 'b580.jpg',
            ],
            [
                'title' => 'Cấu hình Intel Gaming Phổ Thông',
                'cpu' => 'Intel Core i3-14100F',
                'gpu' => 'Arc B580',
                'case' => 'Cooler Master Q300L V2',
                'price' => '18.300.000 ₫',
                'comments' => 93,
                'case_img' => 'case-6.jpg',
                'cpu_img' => '14100f.jpg',
                'gpu_img' => 'b580.jpg',
            ],
            [
                'title' => 'Cấu hình AMD Gaming Tầm Trung',
                'cpu' => 'AMD Ryzen 5 5600X',
                'gpu' => 'Radeon RX 9060 XT',
                'case' => 'NZXT H3 Flow MicroATX',
                'price' => '17.900.000 ₫',
                'comments' => 7,
                'case_img' => 'case-7.jpg',
                'cpu_img' => '5600.jpg',
                'gpu_img' => '9060xt.jpg',
            ],
            [
                'title' => 'Cấu hình Intel Gaming Tầm Trung',
                'cpu' => 'Intel Core i5-12600KF',
                'gpu' => 'Radeon RX 9060 XT',
                'case' => 'NZXT H3 Flow MicroATX',
                'price' => '19.200.000 ₫',
                'comments' => 12,
                'case_img' => 'case-7.jpg',
                'cpu_img' => '12600kf.jpg',
                'gpu_img' => '9060xt.jpg',
            ],
            [
                'title' => 'Cấu hình PC Học tập / Văn phòng',
                'cpu' => 'AMD Ryzen 5 5500GT',
                'gpu' => 'Tích hợp',
                'case' => 'Fractal Design Core 1000',
                'price' => '10.200.000 ₫',
                'comments' => 34,
                'case_img' => 'case-8.jpg',
                'cpu_img' => '5600.jpg',
                'gpu_img' => 'ram.jpg',
            ],
        ] as $build)
        <a href="{{ route('build.apply-guide', ['cpu' => $build['cpu'], 'gpu' => $build['gpu']]) }}" class="group relative flex flex-col items-center justify-center p-6 rounded-3xl bg-white shadow-sm ring-1 ring-slate-200 transition-all hover:shadow-md hover:ring-slate-300">
            <div class="bg-white h-44 relative overflow-hidden w-full">
                @if($build['case_img'] || $build['cpu_img'] || $build['gpu_img'])
                    <img src="{{ asset('images/guides/' . $build['case_img']) }}"
                         class="absolute bottom-0 left-2 h-36 object-contain" alt="Case">
                    <img src="{{ asset('images/guides/' . $build['cpu_img']) }}"
                         class="absolute top-2 right-2 h-20 object-contain" alt="CPU">
                    <img src="{{ asset('images/guides/' . $build['gpu_img']) }}"
                         class="absolute bottom-2 right-2 h-16 object-contain" alt="GPU">
                @else
                    <div class="absolute inset-0 flex flex-col items-center justify-center text-gray-300 text-xs">
                        <div class="text-4xl mb-2">🖥️</div>
                        Chưa có ảnh
                    </div>
                @endif
            </div>
            <div class="p-4">
                <h3 class="font-bold text-sm group-hover:underline leading-tight mb-2">
                    {{ $build['title'] }}
                </h3>
                <p class="text-xs text-gray-500">{{ $build['cpu'] }}</p>
                <p class="text-xs text-gray-500 mt-0.5">{{ $build['gpu'] }}</p>
            </div>
        </a>
        @endforeach
    </div>

</div>
@endsection