@extends('layouts.app')

@section('content')
<div class="bg-[#0f172a] min-h-screen py-10">
    <div class="max-w-3xl mx-auto px-4">
        <div class="bg-[#1e293b] rounded-2xl border border-gray-700 p-8 shadow-2xl">
            <h2 class="text-2xl font-bold text-white mb-6 flex items-center gap-2">
                <span class="text-purple-500 text-3xl">#</span> Đăng bài thảo luận mới
            </h2>

            <form action="{{ route('forum.store') }}" method="POST">
                @csrf {{-- Bắt buộc phải có để bảo mật trong Laravel --}}

                <div class="mb-6">
                    <label class="block text-gray-400 text-sm font-bold mb-2 uppercase tracking-wide">Tiêu đề bài viết</label>
                    <input type="text" name="title" value="{{ old('title') }}"
                        class="w-full bg-[#0f172a] border border-gray-600 rounded-lg py-3 px-4 text-white focus:outline-none focus:border-purple-500 transition"
                        placeholder="Ví dụ: Tư vấn build cấu hình 20 triệu chơi game AAA">
                    @error('title') <p class="text-red-500 text-xs mt-1">{{ $message }}</p> @enderror
                </div>

                <div class="mb-6">
                    <label class="block text-gray-400 text-sm font-bold mb-2 uppercase tracking-wide">Nội dung chi tiết</label>
                    <textarea name="content" rows="10"
                        class="w-full bg-[#0f172a] border border-gray-600 rounded-lg py-3 px-4 text-white focus:outline-none focus:border-purple-500 transition"
                        placeholder="Hãy mô tả chi tiết vấn đề của bạn...">{{ old('content') }}</textarea>
                    @error('content') <p class="text-red-500 text-xs mt-1">{{ $message }} @enderror
                </div>

                <div class="flex items-center justify-end gap-4">
                    <a href="{{ route('forum.index') }}" class="text-gray-400 hover:text-white transition">Hủy bỏ</a>
                    <button type="submit" 
                        class="bg-purple-600 hover:bg-purple-700 text-white font-bold py-3 px-8 rounded-lg shadow-lg shadow-purple-500/30 transition-all transform hover:-translate-y-1">
                        Đăng bài ngay
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>
@endsection