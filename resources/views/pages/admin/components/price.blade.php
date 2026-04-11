{{-- resources/views/pages/admin/components/price.blade.php --}}
@extends('layouts.app')

@section('content')
<div class="min-h-screen bg-gray-950 text-white px-8 py-10">
    <div class="max-w-lg mx-auto">

        <div class="mb-8">
            <a href="{{ route('dashboard') }}" class="text-sm text-gray-400 hover:text-white transition-colors mb-3 inline-flex items-center gap-1">
                ← Quay lại dashboard
            </a>
            <h1 class="text-2xl font-bold text-white">Cập nhật giá</h1>
            <p class="text-gray-400 text-sm mt-1">{{ $component->name }}</p>
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

        <div class="bg-gray-900 border border-gray-800 rounded-2xl p-6">

            {{-- Giá hiện tại --}}
            <div class="bg-gray-800/50 rounded-xl p-4 mb-6 text-center">
                <p class="text-xs text-gray-400 uppercase tracking-wider font-semibold mb-1">Giá hiện tại</p>
                <p class="text-3xl font-bold text-white">{{ number_format($component->price, 0, ',', '.') }}<span class="text-lg text-gray-400">₫</span></p>
            </div>

            <form action="{{ route('admin.components.update-price', $component->id) }}" method="POST" class="space-y-5">
                @csrf
                @method('PUT')

                <div>
                    <label class="block text-xs font-semibold tracking-wider text-gray-400 uppercase mb-2">Giá mới (VNĐ) *</label>
                    <input type="number" name="price" min="0" step="1000" autofocus
                        class="w-full bg-gray-800 border border-gray-700 rounded-lg px-4 py-3 text-white text-lg font-semibold placeholder-gray-500 focus:outline-none focus:border-green-500"
                        placeholder="Nhập giá mới..." required>
                    <p class="text-xs text-gray-500 mt-1.5">Nhập số nguyên, đơn vị VNĐ. VD: 5990000</p>
                </div>

                <div class="flex gap-3">
                    <button type="submit"
                        class="flex-1 bg-green-600 hover:bg-green-500 text-white font-semibold py-2.5 rounded-xl transition-colors text-sm">
                        ✓ Lưu giá mới
                    </button>
                    <a href="{{ route('dashboard') }}"
                        class="px-6 bg-gray-800 hover:bg-gray-700 text-gray-300 font-semibold py-2.5 rounded-xl transition-colors text-sm text-center">
                        Huỷ
                    </a>
                </div>
            </form>
        </div>
    </div>
</div>
@endsection