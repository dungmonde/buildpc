@extends('layouts.app')

@section('content')
@php
$imgMap = [
    'cpu' => 'cpu', 'vga' => 'gpu', 'mainboard' => 'motherboard',
    'ram' => 'ram', 'storage' => 'storage', 'psu' => 'psu', 'case' => 'case'
];
@endphp

<div class="max-w-6xl mx-auto px-6 py-12">
        <div class="mb-10 flex items-start justify-between">
            <div>
                <h2 class="text-3xl font-bold text-slate-900">Chọn {{ $category_name }}</h2>
                @if(isset($filterMessage) && $filterMessage)
                    <p class="mt-3 text-sm text-emerald-700 bg-emerald-50 inline-block px-3 py-1 rounded-full border border-emerald-200">✓ {{ $filterMessage }}</p>
                @endif
                @if(isset($recommendedWattage) && $recommendedWattage > 0)
                    <p class="mt-3 text-sm text-slate-600">Mức nguồn an toàn đề xuất cho hệ thống của bạn là: <strong class="text-emerald-600">{{ $recommendedWattage }}W</strong></p>
                @endif
            </div>
            <a href="{{ route('build.index') }}" class="text-slate-500 hover:text-primary-600 font-medium whitespace-nowrap">← Quay lại</a>
        </div>

        <div class="grid grid-cols-1 md:grid-cols-2 gap-8">
            @foreach($items as $item)
            <div class="card p-8 group hover:shadow-2xl transition-all">
                <div class="flex gap-6 relative">
                    @if($category === 'psu' && isset($recommendedWattage) && $recommendedWattage > 0 && isset($item->psu) && $item->psu->wattage >= $recommendedWattage && $item->psu->wattage <= $recommendedWattage + 250)
                        <div class="absolute -top-10 -right-4 bg-emerald-500 text-white text-xs font-bold px-3 py-1 rounded-full shadow-sm z-10 flex items-center gap-1">
                            <svg class="w-3 h-3" fill="none" stroke="currentColor" viewBox="0 0 24 24" stroke-width="2"><path stroke-linecap="round" stroke-linejoin="round" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z" /></svg>
                            Khuyến nghị
                        </div>
                    @endif
                    <div class="w-28 h-28 bg-slate-100 rounded-2xl flex items-center justify-center overflow-hidden border border-slate-200 group-hover:scale-105 transition shrink-0">
                        <img src="{{ asset('images/components/' . ($imgMap[$category] ?? $category) . '/' . $item->id . '.jpg') }}"
                             onerror="this.src='https://via.placeholder.com/150?text=No+Image'"
                             class="w-full h-full object-contain">
                    </div>

                    <div class="flex-1">
                        <h3 class="text-xl font-bold text-slate-900 group-hover:text-primary-600 transition">
                            @if($category === 'mainboard' && $item->motherboard?->chipset)
                                {{ $item->manufacturer }} {{ $item->motherboard->chipset }}
                            @elseif($category === 'vga' && $item->gpu?->chipset)
                                {{ $item->manufacturer }} {{ $item->gpu->chipset }}
                            @else
                                {{ $item->name }}
                            @endif
                        </h3>
                        <p class="text-3xl font-bold text-primary-600 mt-4">
                            {{ number_format($item->base_price ?? $item->cheapestPrice?->price ?? 0) }} ₫
                        </p>
                    </div>
                </div>

                <div class="mt-10 flex justify-end">
                    <a href="{{ route('build.add', ['category' => $category, 'component_id' => $item->id]) }}" 
                       class="btn btn-primary px-10 py-3.5">
                        Chọn sản phẩm này
                    </a>
                </div>
            </div>
            @endforeach
        </div>
    </div>
@endsection
