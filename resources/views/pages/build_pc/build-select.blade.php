@extends('layouts.app')

@section('content')
@php
$imgMap = [
    'cpu' => 'cpu', 'vga' => 'gpu', 'mainboard' => 'motherboard',
    'ram' => 'ram', 'storage' => 'storage', 'psu' => 'psu', 'case' => 'case'
];
@endphp

<div class="max-w-6xl mx-auto px-6 py-12">
        <div class="mb-10 flex items-center justify-between">
            <h2 class="text-3xl font-bold text-slate-900">Chọn {{ $category_name }}</h2>
            <a href="{{ route('build.index') }}" class="text-slate-500 hover:text-primary-600 font-medium">← Quay lại</a>
        </div>

        <div class="grid grid-cols-1 md:grid-cols-2 gap-8">
            @foreach($items as $item)
            <div class="card p-8 group hover:shadow-2xl transition-all">
                <div class="flex gap-6">
                    <div class="w-28 h-28 bg-slate-100 rounded-2xl flex items-center justify-center overflow-hidden border border-slate-200 group-hover:scale-105 transition">
                        <img src="{{ asset('images/components/' . ($imgMap[$category] ?? $category) . '/' . $item->id . '.jpg') }}"
                             onerror="this.src='https://via.placeholder.com/150?text=No+Image'"
                             class="w-full h-full object-contain">
                    </div>

                    <div class="flex-1">
                        <h3 class="text-xl font-bold text-slate-900 group-hover:text-primary-600 transition">
                            {{ $item->name }}
                        </h3>
                        <p class="text-3xl font-bold text-primary-600 mt-4">
                            {{ number_format($item->cheapestPrice?->price ?? 0) }} ₫
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