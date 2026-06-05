@extends('layouts.app')

@section('title', 'Dashboard')

@section('content')
<div class="min-h-screen bg-slate-50 text-slate-900">

    {{-- Header (no border) --}}
    <div class="flex items-center justify-between py-8 px-8 bg-white">
        <div>
            <p class="text-xs font-semibold tracking-widest text-gray-500 uppercase mb-1">Trang cá nhân</p>
            <h1 class="text-2xl font-black">Xin chào, {{ auth()->user()->name }}</h1>
        </div>
        <div class="flex items-center gap-3">
            <div class="text-right">
                <p class="text-sm font-semibold">{{ auth()->user()->email }}</p>
                <p class="text-xs text-gray-400">Thành viên</p>
            </div>
            @if(auth()->user()->avatar)
                <img src="{{ asset('storage/' . auth()->user()->avatar) }}" alt="Avatar" class="w-9 h-9 rounded-full object-cover ring-1 ring-slate-200">
            @else
                <div class="w-9 h-9 rounded-full bg-slate-200 flex items-center justify-center text-xs font-bold text-slate-700 ring-1 ring-slate-200">
                    {{ strtoupper(substr(auth()->user()->name, 0, 1)) }}
                </div>
            @endif
        </div>
    </div>

    <div class="px-8 py-8 max-w-5xl mx-auto">

        {{-- Stats --}}
        <div class="grid grid-cols-1 sm:grid-cols-2 gap-4 mb-8">

            <div class="card p-6 hover:shadow-sm transition">
                <p class="text-xs text-slate-500 uppercase mb-2">Ngày tham gia</p>
                <p class="text-lg font-bold">{{ auth()->user()->created_at->format('d/m/Y') }}</p>
                <p class="text-xs text-slate-500 mt-1">{{ auth()->user()->created_at->diffForHumans() }}</p>
            </div>

            <div class="card p-6 hover:shadow-sm transition">
                <p class="text-xs text-slate-500 uppercase mb-2">Bài viết</p>
                <p class="text-3xl font-black">{{ $userStats['total_posts'] ?? 0 }}</p>
                <p class="text-xs text-slate-500 mt-1">bài đăng trên diễn đàn</p>
            </div>

        </div>

        {{-- Quick Actions --}}
        <div class="card p-6 mb-6">
            <h2 class="text-sm font-semibold tracking-wider text-slate-500 uppercase mb-4">Truy cập nhanh</h2>

            <div class="grid grid-cols-2 sm:grid-cols-3 gap-3">

                     <a href="{{ route('builder.manual') }}"
                         class="flex items-center gap-3 border border-slate-200 bg-white p-4 hover:bg-slate-50 transition rounded-2xl">
                    <span class="text-xl"></span>
                    <div>
                        <p class="text-sm font-semibold">Build PC</p>
                        <p class="text-xs text-slate-500">Tạo cấu hình mới</p>
                    </div>
                </a>

                {{-- FIX LỖI Ở ĐÂY --}}
                     <a href="{{ route('components.index', 'cpu') }}"
                         class="flex items-center gap-3 border border-slate-200 bg-white p-4 hover:bg-slate-50 transition rounded-2xl">
                    <span class="text-xl"></span>
                    <div>
                        <p class="text-sm font-semibold">Linh kiện</p>
                        <p class="text-xs text-slate-500">Xem tất cả linh kiện</p>
                    </div>
                </a>

                     <a href="{{ route('forum.index') }}"
                         class="flex items-center gap-3 border border-slate-200 bg-white p-4 hover:bg-slate-50 transition rounded-2xl">
                    <span class="text-xl"></span>
                    <div>
                        <p class="text-sm font-semibold">Diễn đàn</p>
                        <p class="text-xs text-slate-500">Thảo luận cộng đồng</p>
                    </div>
                </a>

            </div>
        </div>

        {{-- Builds gần đây --}}
        <div class="card p-6 mb-6">
            <h2 class="text-sm font-semibold tracking-wider text-slate-500 uppercase mb-4">Cấu hình gần đây</h2>

            @forelse($recentBuilds ?? [] as $build)
                <div class="flex items-center justify-between py-3 border-b border-slate-200 last:border-0">
                    <div>
                        <p class="text-sm font-semibold">{{ $build->name ?? 'Cấu hình #' . $build->id }}</p>
                        <p class="text-xs text-slate-500">
                            {{ \Carbon\Carbon::parse($build->created_at)->format('d/m/Y') }}
                        </p>
                    </div>
                </div>
            @empty
                <div class="text-center py-8">
                    <p class="text-gray-500 text-sm mb-3">Bạn chưa có cấu hình nào</p>
                    <a href="{{ route('builder.manual') }}"
                       class="btn btn-primary px-4 py-2">
                        Tạo cấu hình đầu tiên
                    </a>
                </div>
            @endforelse
        </div>

        {{-- Bài viết gần đây --}}
        <div class="card p-6">
            <div class="flex items-center justify-between mb-4">
                <h2 class="text-sm font-semibold tracking-wider text-slate-500 uppercase">Bài viết của bạn</h2>
                <a href="{{ route('forum.index') }}" class="text-xs text-slate-500 hover:text-slate-900 transition">
                    Xem tất cả →
                </a>

            @forelse($recentPosts ?? [] as $post)
                <div class="flex items-center justify-between py-3 border-b border-slate-200 last:border-0">
                    <div class="flex-1 pr-4">
                        <p class="text-sm font-semibold truncate">{{ $post->title }}</p>
                        <p class="text-xs text-slate-500">
                            {{ \Carbon\Carbon::parse($post->created_at)->format('d/m/Y') }}
                        </p>
                    </div>

                    <a href="{{ route('forum.show', $post->id) }}"
                       class="btn border border-gray-600 px-3 py-1 text-xs">
                        Xem
                    </a>
                </div>
            @empty
                <div class="text-center py-8">
                    <p class="text-gray-500 text-sm mb-3">Bạn chưa có bài viết nào</p>
                    <a href="{{ route('forum.create') }}"
                       class="btn btn-primary px-4 py-2">
                        Viết bài đầu tiên
                    </a>
                </div>
            @endforelse
        </div>

    </div>
</div>
@endsection