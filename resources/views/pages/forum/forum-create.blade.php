@extends('layouts.app')

@section('content')
<div class="max-w-3xl mx-auto px-6 py-12">
        <div class="mb-8">
            <a href="{{ route('forum.index') }}" 
               class="text-slate-500 hover:text-slate-700 flex items-center gap-2 mb-3">
                ← Quay lại diễn đàn
            </a>
            <h1 class="text-3xl font-bold text-slate-900">Đăng bài thảo luận mới</h1>
        </div>

        <div class="card p-10">

            <form action="{{ route('forum.store') }}" method="POST">
                @csrf

                <div class="mb-8">
                    <label class="block text-xs font-semibold tracking-widest text-slate-500 mb-3">
                        TIÊU ĐỀ BÀI VIẾT
                    </label>
                    <input type="text" 
                           name="title" 
                           value="{{ old('title') }}"
                           class="w-full border border-slate-300 rounded-2xl px-6 py-4 focus:border-primary-500 focus:outline-none text-lg"
                           placeholder=""
                           required>
                    @error('title')
                        <p class="text-red-500 text-sm mt-2">{{ $message }}</p>
                    @enderror
                </div>

                <div class="mb-8">
                    <label class="block text-xs font-semibold tracking-widest text-slate-500 mb-3">
                        NỘI DUNG CHI TIẾT
                    </label>
                    <textarea name="content" 
                              rows="12"
                              class="w-full border border-slate-300 rounded-3xl px-6 py-5 focus:border-primary-500 focus:outline-none resize-none"
                              placeholder="">{{ old('content') }}</textarea>
                    @error('content')
                        <p class="text-red-500 text-sm mt-2">{{ $message }}</p>
                    @enderror
                </div>

                <div class="flex items-center justify-end gap-4">
                    <a href="{{ route('forum.index') }}" 
                       class="px-8 py-3 text-slate-600 hover:text-slate-800 font-medium transition">
                        Hủy bỏ
                    </a>
                    <button type="submit" 
                            class="btn btn-primary px-10 py-3.5">
                        Đăng bài ngay
                    </button>
                </div>
            </form>

        </div>
    </div>
@endsection