{{-- resources/views/pages/admin/components/edit.blade.php --}}
@extends('layouts.app')

@section('content')
<div class="min-h-screen bg-slate-50 text-slate-900 px-8 py-10">
    <div class="max-w-2xl mx-auto">

        <div class="mb-8">
            <a href="{{ $returnUrl ?? route('dashboard') }}" class="text-sm text-slate-500 hover:text-slate-900 transition-colors mb-3 inline-flex items-center gap-1">
                ← Quay lại dashboard
            </a>
            <h1 class="text-2xl font-bold text-slate-900">Sửa linh kiện</h1>
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

        <form action="{{ route('admin.components.update', $component->id) }}" method="POST" enctype="multipart/form-data" class="card p-6 space-y-5">
            @csrf
            @method('PUT')
            <input type="hidden" name="return_url" value="{{ $returnUrl ?? route('dashboard') }}">

            <div>
                <label class="block text-xs font-semibold tracking-wider text-gray-400 uppercase mb-2">Tên linh kiện *</label>
                <input type="text" name="name" value="{{ old('name', $component->name) }}"
                    class="w-full bg-white border border-slate-200 rounded-lg px-4 py-2.5 text-slate-900 placeholder-slate-400 focus:outline-none focus:border-slate-400 text-sm" required>
            </div>

            <div class="grid grid-cols-2 gap-4">
                <div>
                    <label class="block text-xs font-semibold tracking-wider text-gray-400 uppercase mb-2">Danh mục *</label>
                    <select name="type_id" required
                        class="w-full bg-white border border-slate-200 rounded-2xl px-4 py-2.5 text-slate-900 focus:outline-none focus:border-slate-400 text-sm">
                        @foreach($categories as $id => $cat)
                            <option value="{{ $id }}" {{ old('type_id', $component->type_id) == $id ? 'selected' : '' }}>{{ $cat }}</option>
                        @endforeach
                    </select>
                </div>
                <div>
                    <label class="block text-xs font-semibold tracking-wider text-gray-400 uppercase mb-2">Thương hiệu</label>
                    <input type="text" name="brand" value="{{ old('brand', $component->brand ?? '') }}"
                        class="w-full bg-white border border-slate-200 rounded-lg px-4 py-2.5 text-slate-900 placeholder-slate-400 focus:outline-none focus:border-slate-400 text-sm">
                </div>
            </div>

            <div>
                <label class="block text-xs font-semibold tracking-wider text-gray-400 uppercase mb-2">Giá niêm yết (VNĐ)</label>
                <input type="number" name="base_price" value="{{ old('base_price', $component->base_price ?? 0) }}" min="0" step="1000"
                    class="w-full bg-white border border-slate-200 rounded-lg px-4 py-2.5 text-slate-900 placeholder-slate-400 focus:outline-none focus:border-slate-400 text-sm"
                    placeholder="Có thể bỏ trống">
            </div>

            <div>
                <label class="block text-xs font-semibold tracking-wider text-gray-400 uppercase mb-2">Thông số kỹ thuật</label>
                <textarea name="specs" rows="4"
                    class="w-full bg-white border border-slate-200 rounded-lg px-4 py-2.5 text-slate-900 placeholder-slate-400 focus:outline-none focus:border-slate-400 text-sm resize-none">{{ old('specs', $component->specs ?? '') }}</textarea>
            </div>

            <div>
                <label class="block text-xs font-semibold tracking-wider text-gray-400 uppercase mb-2">Ảnh linh kiện</label>
                <input type="file" name="image"
                    class="w-full bg-white border border-slate-200 rounded-lg px-4 py-2.5 text-slate-900 focus:outline-none focus:border-slate-400 text-sm"
                    accept="image/jpeg,image/jpg,image/png,image/webp">
                <p class="text-xs text-slate-500 mt-2">Hỗ trợ JPG, PNG, WebP. Nếu thay đổi danh mục, ảnh sẽ được chuyển sang thư mục tương ứng.</p>
            </div>

            <div class="flex gap-3 pt-2">
                <button type="submit"
                    class="flex-1 bg-blue-600 hover:bg-blue-500 text-white font-semibold py-2.5 rounded-xl transition-colors text-sm">
                    Lưu thay đổi
                </button>
                <a href="{{ $returnUrl ?? route('dashboard') }}"
                    class="px-6 border border-slate-200 hover:bg-slate-100 text-slate-700 font-semibold py-2.5 rounded-xl transition-colors text-sm text-center">
                    Huỷ
                </a>
            </div>
        </form>
    </div>
</div>
@endsection
