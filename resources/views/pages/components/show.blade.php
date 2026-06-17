@extends('layouts.app')

@section('title', $component->name)

@section('content')
<div class="max-w-7xl mx-auto px-8 py-10">

    <div class="text-sm text-gray-500 mb-6 flex items-center gap-2">
        <a href="{{ route('home') }}" class="hover:text-black transition">Trang chủ</a>
        <span>/</span>
        <a href="{{ route('components.index', $type) }}" class="hover:text-black transition uppercase">
            {{ $type }}
        </a>
        <span>/</span>
        <span class="text-black font-medium truncate">{{ $component->name }}</span>
    </div>

    <div class="overflow-hidden bg-white">

        <div class="px-6 py-4 bg-gray-50 rounded-t-lg">
            <h1 class="text-3xl font-black uppercase tracking-wide">
                {{ $component->name }}
            </h1>
        </div>

        <div class="grid grid-cols-12 gap-8 p-6">

                <div class="col-span-12 lg:col-span-3">
                <div class="bg-gray-50 p-6 flex items-center justify-center min-h-[260px]">
                    <img
                        src="{{ asset('images/components/' . $type . '/' . $component->id . '.jpg') }}"
                        class="max-h-[220px] w-auto object-contain"
                    >
                </div>

                @if($price)
                    <div class="mt-4 p-4 text-center bg-white">
                        <p class="text-xs uppercase tracking-wide text-gray-500 mb-2">
                            Giá hiện tại
                        </p>
                        <p class="text-3xl font-black">
                            {{ number_format($price, 0, ',', '.') }} ₫
                        </p>
                    </div>
                @endif
            </div>

            <div class="col-span-12 lg:col-span-9">
                <div>

                    <div class="px-5 py-4 bg-gray-50">
                        <h2 class="text-lg font-bold uppercase tracking-wide">
                            Thông số kỹ thuật
                        </h2>
                    </div>

                    <div class="divide-y divide-gray-200 text-sm">

                        @if($type === 'cpu' && $spec)

                            <div class="grid grid-cols-2">
                                <div class="px-5 py-4 bg-gray-50 font-medium text-gray-600">Số nhân</div>
                                <div class="px-5 py-4 font-semibold">{{ $spec->core_count }}</div>
                            </div>

                            <div class="grid grid-cols-2">
                                <div class="px-5 py-4 bg-gray-50 font-medium text-gray-600">Xung cơ bản</div>
                                <div class="px-5 py-4 font-semibold">{{ $spec->core_clock }} GHz</div>
                            </div>

                            <div class="grid grid-cols-2">
                                <div class="px-5 py-4 bg-gray-50 font-medium text-gray-600">Xung boost</div>
                                <div class="px-5 py-4 font-semibold">{{ $spec->boost_clock }} GHz</div>
                            </div>

                            <div class="grid grid-cols-2">
                                <div class="px-5 py-4 bg-gray-50 font-medium text-gray-600">TDP</div>
                                <div class="px-5 py-4 font-semibold">{{ $spec->tdp }} W</div>
                            </div>

                            <div class="grid grid-cols-2">
                                <div class="px-5 py-4 bg-gray-50 font-medium text-gray-600">Socket</div>
                                <div class="px-5 py-4 font-semibold">{{ $spec->socket }}</div>
                            </div>

                        @elseif($type === 'gpu' && $spec)

                            <div class="grid grid-cols-2">
                                <div class="px-5 py-4 bg-gray-50 font-medium text-gray-600">Chipset</div>
                                <div class="px-5 py-4 font-semibold">{{ $spec->chipset }}</div>
                            </div>

                            <div class="grid grid-cols-2">
                                <div class="px-5 py-4 bg-gray-50 font-medium text-gray-600">VRAM</div>
                                <div class="px-5 py-4 font-semibold">{{ $spec->memory }} GB</div>
                            </div>

                            <div class="grid grid-cols-2">
                                <div class="px-5 py-4 bg-gray-50 font-medium text-gray-600">Core Clock</div>
                                <div class="px-5 py-4 font-semibold">{{ $spec->core_clock }} MHz</div>
                            </div>

                            <div class="grid grid-cols-2">
                                <div class="px-5 py-4 bg-gray-50 font-medium text-gray-600">TDP</div>
                                <div class="px-5 py-4 font-semibold">{{ $spec->tdp }} W</div>
                            </div>

                            <div class="grid grid-cols-2">
                                <div class="px-5 py-4 bg-gray-50 font-medium text-gray-600">Chiều dài</div>
                                <div class="px-5 py-4 font-semibold">{{ $spec->length }} mm</div>
                            </div>

                        @elseif($type === 'ram' && $spec)

                            <div class="grid grid-cols-2">
                                <div class="px-5 py-4 bg-gray-50 font-medium text-gray-600">Dung lượng</div>
                                <div class="px-5 py-4 font-semibold">{{ $spec->capacity }} GB</div>
                            </div>

                            <div class="grid grid-cols-2">
                                <div class="px-5 py-4 bg-gray-50 font-medium text-gray-600">Bus</div>
                                <div class="px-5 py-4 font-semibold">{{ $spec->speed }} MHz</div>
                            </div>

                            <div class="grid grid-cols-2">
                                <div class="px-5 py-4 bg-gray-50 font-medium text-gray-600">Modules</div>
                                <div class="px-5 py-4 font-semibold">{{ $spec->modules }}</div>
                            </div>

                            <div class="grid grid-cols-2">
                                <div class="px-5 py-4 bg-gray-50 font-medium text-gray-600">CAS Latency</div>
                                <div class="px-5 py-4 font-semibold">{{ $spec->cas_latency }}</div>
                            </div>

                            <div class="grid grid-cols-2">
                                <div class="px-5 py-4 bg-gray-50 font-medium text-gray-600">DDR</div>
                                <div class="px-5 py-4 font-semibold">{{ $spec->ddr_gen }}</div>
                            </div>

                        @elseif($type === 'storage' && $spec)

                            <div class="grid grid-cols-2">
                                <div class="px-5 py-4 bg-gray-50 font-medium text-gray-600">Dung lượng</div>
                                <div class="px-5 py-4 font-semibold">{{ $spec->capacity }} GB</div>
                            </div>

                            <div class="grid grid-cols-2">
                                <div class="px-5 py-4 bg-gray-50 font-medium text-gray-600">Loại</div>
                                <div class="px-5 py-4 font-semibold">{{ $spec->type }}</div>
                            </div>

                            <div class="grid grid-cols-2">
                                <div class="px-5 py-4 bg-gray-50 font-medium text-gray-600">Form Factor</div>
                                <div class="px-5 py-4 font-semibold">{{ $spec->form_factor }}</div>
                            </div>

                            <div class="grid grid-cols-2">
                                <div class="px-5 py-4 bg-gray-50 font-medium text-gray-600">Interface</div>
                                <div class="px-5 py-4 font-semibold">{{ $spec->interface }}</div>
                            </div>

                        @elseif($type === 'motherboard' && $spec)

                            <div class="grid grid-cols-2">
                                <div class="px-5 py-4 bg-gray-50 font-medium text-gray-600">Socket</div>
                                <div class="px-5 py-4 font-semibold">{{ $spec->socket }}</div>
                            </div>

                            <div class="grid grid-cols-2">
                                <div class="px-5 py-4 bg-gray-50 font-medium text-gray-600">Form Factor</div>
                                <div class="px-5 py-4 font-semibold">{{ $spec->form_factor }}</div>
                            </div>

                            <div class="grid grid-cols-2">
                                <div class="px-5 py-4 bg-gray-50 font-medium text-gray-600">RAM tối đa</div>
                                <div class="px-5 py-4 font-semibold">{{ $spec->max_memory }} GB</div>
                            </div>

                            <div class="grid grid-cols-2">
                                <div class="px-5 py-4 bg-gray-50 font-medium text-gray-600">Số khe RAM</div>
                                <div class="px-5 py-4 font-semibold">{{ $spec->memory_slots }}</div>
                            </div>

                        @elseif($type === 'psu' && $spec)

                            <div class="grid grid-cols-2">
                                <div class="px-5 py-4 bg-gray-50 font-medium text-gray-600">Chuẩn</div>
                                <div class="px-5 py-4 font-semibold">{{ $spec->type }}</div>
                            </div>

                            <div class="grid grid-cols-2">
                                <div class="px-5 py-4 bg-gray-50 font-medium text-gray-600">Công suất</div>
                                <div class="px-5 py-4 font-semibold">{{ $spec->wattage }} W</div>
                            </div>

                            <div class="grid grid-cols-2">
                                <div class="px-5 py-4 bg-gray-50 font-medium text-gray-600">Efficiency</div>
                                <div class="px-5 py-4 font-semibold">{{ $spec->efficiency }}</div>
                            </div>

                            <div class="grid grid-cols-2">
                                <div class="px-5 py-4 bg-gray-50 font-medium text-gray-600">Modular</div>
                                <div class="px-5 py-4 font-semibold">{{ $spec->modular ? 'Có' : 'Không' }}</div>
                            </div>

                        @elseif($type === 'cooler' && $spec)

                            <div class="grid grid-cols-2">
                                <div class="px-5 py-4 bg-gray-50 font-medium text-gray-600">RPM</div>
                                <div class="px-5 py-4 font-semibold">{{ $spec->rpm }}</div>
                            </div>

                            <div class="grid grid-cols-2">
                                <div class="px-5 py-4 bg-gray-50 font-medium text-gray-600">Độ ồn</div>
                                <div class="px-5 py-4 font-semibold">{{ $spec->noise_level }} dB</div>
                            </div>

                            <div class="grid grid-cols-2">
                                <div class="px-5 py-4 bg-gray-50 font-medium text-gray-600">Màu sắc</div>
                                <div class="px-5 py-4 font-semibold">{{ $spec->color }}</div>
                            </div>

                        @elseif($type === 'case' && $spec)

                            <div class="grid grid-cols-2">
                                <div class="px-5 py-4 bg-gray-50 font-medium text-gray-600">Loại case</div>
                                <div class="px-5 py-4 font-semibold">{{ $spec->type }}</div>
                            </div>

                            <div class="grid grid-cols-2">
                                <div class="px-5 py-4 bg-gray-50 font-medium text-gray-600">Màu sắc</div>
                                <div class="px-5 py-4 font-semibold">{{ $spec->color }}</div>
                            </div>

                            <div class="grid grid-cols-2">
                                <div class="px-5 py-4 bg-gray-50 font-medium text-gray-600">Side Panel</div>
                                <div class="px-5 py-4 font-semibold">{{ $spec->side_panel }}</div>
                            </div>

                            <div class="grid grid-cols-2">
                                <div class="px-5 py-4 bg-gray-50 font-medium text-gray-600">Thể tích</div>
                                <div class="px-5 py-4 font-semibold">{{ $spec->external_volume }} L</div>
                            </div>

                        @endif

                    </div>
                </div>
            </div>

        </div>
    </div>

    <div class="mt-12">
        <div class="mb-6">
            <h2 class="text-2xl font-bold uppercase tracking-wide">
                Sản phẩm liên quan
            </h2>
        </div>

        @if(isset($relatedComponents) && $relatedComponents->isNotEmpty())
            <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-6">
                @foreach($relatedComponents as $related)
                    @php
                        $relatedPrice = $related->base_price ?? $related->cheapestPrice?->price;
                    @endphp
                    <div class="bg-white border border-slate-200 rounded-xl overflow-hidden group transition hover:shadow-lg hover:-translate-y-1">
                        <a href="{{ route('components.show', [$type, $related->id]) }}" class="block">
                            <div class="bg-slate-50 h-48 flex items-center justify-center p-4">
                                <img src="{{ asset('images/components/' . $type . '/' . $related->id . '.jpg') }}"
                                     onerror="this.parentElement.innerHTML = '<span class=\'text-2xl\'>📦</span>'"
                                     class="max-h-full max-w-full object-contain transition-transform group-hover:scale-105">
                            </div>
                            <div class="p-4">
                                <p class="text-sm font-semibold text-slate-800 group-hover:text-blue-600 line-clamp-2 h-10">{{ $related->name }}</p>
                                @if($relatedPrice)
                                    <p class="text-base font-bold text-slate-900 mt-2">{{ number_format($relatedPrice, 0, ',', '.') }} ₫</p>
                                @else
                                    <p class="text-sm text-slate-500 mt-2">Liên hệ</p>
                                @endif
                            </div>
                        </a>
                    </div>
                @endforeach
            </div>
        @else
            <div class="bg-white border border-slate-200 rounded-xl p-12 text-center text-slate-500">
                <p>Không tìm thấy sản phẩm liên quan.</p>
                <p class="text-xs mt-1">Có thể do chưa có đủ dữ liệu trong cùng danh mục.</p>
            </div>
        @endif
    </div>

</div>
@endsection