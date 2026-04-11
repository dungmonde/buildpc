{{-- resources/views/pages/admin/components/create.blade.php --}}
@extends('layouts.app')

@section('content')
<div class="min-h-screen bg-gray-950 text-white px-8 py-10">
    <div class="max-w-2xl mx-auto">

        {{-- Header --}}
        <div class="mb-8">
            <a href="{{ route('dashboard') }}" class="text-sm text-gray-400 hover:text-white transition-colors mb-3 inline-flex items-center gap-1">
                ← Quay lại dashboard
            </a>
            <h1 class="text-2xl font-bold text-white">Thêm linh kiện mới</h1>
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

        <form action="{{ route('admin.components.store') }}" method="POST" class="bg-gray-900 border border-gray-800 rounded-2xl p-6 space-y-5">
            @csrf

            <div>
                <label class="block text-xs font-semibold tracking-wider text-gray-400 uppercase mb-2">Tên linh kiện *</label>
                <input type="text" name="name" value="{{ old('name') }}"
                    class="w-full bg-gray-800 border border-gray-700 rounded-lg px-4 py-2.5 text-white placeholder-gray-500 focus:outline-none focus:border-blue-500 text-sm"
                    placeholder="VD: Intel Core i5-14600K" required>
            </div>

            <div class="grid grid-cols-2 gap-4">
                <div>
                    <label class="block text-xs font-semibold tracking-wider text-gray-400 uppercase mb-2">Danh mục *</label>
                    <select name="category" required
                        class="w-full bg-gray-800 border border-gray-700 rounded-lg px-4 py-2.5 text-white focus:outline-none focus:border-blue-500 text-sm">
                        <option value="">-- Chọn danh mục --</option>
                        @foreach($categories as $cat)
                            <option value="{{ $cat }}" {{ old('category') === $cat ? 'selected' : '' }}>{{ $cat }}</option>
                        @endforeach
                    </select>
                </div>
                <div>
                    <label class="block text-xs font-semibold tracking-wider text-gray-400 uppercase mb-2">Thương hiệu</label>
                    <input type="text" name="brand" value="{{ old('brand') }}"
                        class="w-full bg-gray-800 border border-gray-700 rounded-lg px-4 py-2.5 text-white placeholder-gray-500 focus:outline-none focus:border-blue-500 text-sm"
                        placeholder="VD: Intel, AMD, ASUS...">
                </div>
            </div>

            <div>
                <label class="block text-xs font-semibold tracking-wider text-gray-400 uppercase mb-2">Giá (VNĐ) *</label>
                <input type="number" name="price" value="{{ old('price') }}" min="0" step="1000"
                    class="w-full bg-gray-800 border border-gray-700 rounded-lg px-4 py-2.5 text-white placeholder-gray-500 focus:outline-none focus:border-blue-500 text-sm"
                    placeholder="VD: 5990000" required>
            </div>

            <div>
                <label class="block text-xs font-semibold tracking-wider text-gray-400 uppercase mb-2">Thông số kỹ thuật</label>
                <textarea name="specs" rows="4"
                    class="w-full bg-gray-800 border border-gray-700 rounded-lg px-4 py-2.5 text-white placeholder-gray-500 focus:outline-none focus:border-blue-500 text-sm resize-none"
                    placeholder="Nhập thông số kỹ thuật...">{{ old('specs') }}</textarea>
            </div>

            <div class="flex gap-3 pt-2">
                <button type="submit"
                    class="flex-1 bg-blue-600 hover:bg-blue-500 text-white font-semibold py-2.5 rounded-xl transition-colors text-sm">
                    ＋ Thêm linh kiện
                </button>
                <a href="{{ route('dashboard') }}"
                    class="px-6 bg-gray-800 hover:bg-gray-700 text-gray-300 font-semibold py-2.5 rounded-xl transition-colors text-sm text-center">
                    Huỷ
                </a>
            </div>
        </form>
    </div>
</div>
@endsection