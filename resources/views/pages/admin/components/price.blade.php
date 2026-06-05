{{-- resources/views/pages/admin/components/price.blade.php --}}
@extends('layouts.app')

@section('content')
<div class="min-h-screen bg-slate-50 text-slate-900 px-8 py-10">
    <div class="max-w-lg mx-auto">

        <div class="mb-8">
            <a href="{{ route('dashboard') }}" class="text-sm text-slate-500 hover:text-slate-900 transition-colors mb-3 inline-flex items-center gap-1">
                ← Quay lại dashboard
            </a>
            <h1 class="text-2xl font-bold text-slate-900">Cập nhật giá</h1>
            <p class="text-slate-500 text-sm mt-1">{{ $component->name }}</p>
        </div>

        @if($errors->any())
            <div class="bg-red-900/30 border border-red-500/40 rounded-xl p-4 mb-6">
                <ul class="text-sm text-red-400 space-y-1">
                    @foreach($errors->all() as $error)
                        <li>• {{ $error }}</li>
                    @endforeach
                </ul>
            </div>
        @endif

        <div class="card p-6">

            {{-- Giá hiện tại --}}
            <div class="bg-slate-100 rounded-xl p-4 mb-6 text-center">
                <p class="text-xs text-slate-500 uppercase tracking-wider font-semibold mb-1">Giá hiện tại</p>
                <p class="text-3xl font-bold text-slate-900">{{ number_format($component->base_price ?? 0, 0, ',', '.') }}<span class="text-lg text-slate-500">₫</span></p>
            </div>

            <form action="{{ route('admin.components.update-price', $component->id) }}" method="POST" class="space-y-5">
                @csrf
                @method('PUT')

                <div>
                    <label class="block text-xs font-semibold tracking-wider text-gray-400 uppercase mb-2">Giá mới (VNĐ) *</label>
                    <input type="number" name="price" min="0" step="1000" autofocus
                        value="{{ old('price', $component->base_price ?? 0) }}"
                        class="w-full bg-white border border-slate-200 rounded-lg px-4 py-3 text-slate-900 text-lg font-semibold placeholder-slate-400 focus:outline-none focus:border-slate-400"
                        placeholder="Nhập giá mới..." required>
                    <p class="text-xs text-gray-500 mt-1.5">Nhập số nguyên, đơn vị VNĐ. VD: 5990000</p>
                </div>

                <div class="flex gap-3">
                    <button type="submit"
                        class="flex-1 bg-green-600 hover:bg-green-500 text-white font-semibold py-2.5 rounded-xl transition-colors text-sm">
                        ✓ Lưu giá mới
                    </button>
                    <a href="{{ route('dashboard') }}"
                        class="px-6 border border-slate-300 hover:bg-slate-100 text-slate-700 font-semibold py-2.5 rounded-xl transition-colors text-sm text-center">
                        Huỷ
                    </a>
                </div>
            </form>
        </div>
    </div>
</div>
@endsection
