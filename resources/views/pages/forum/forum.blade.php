@extends('layouts.app')

@section('content')
<div class="bg-slate-50 min-h-screen text-slate-900 p-6">
    <div class="max-w-6xl mx-auto">
        <div class="flex justify-between items-center mb-8">
            <h1 class="text-3xl font-bold text-slate-800">
                DIỄN ĐÀN <span class="text-purple-600">THẢO LUẬN</span>
            </h1>
            <a href="{{ route('forum.create') }}" class="bg-purple-600 hover:bg-purple-700 text-white px-6 py-2.5 rounded-xl font-bold transition-all shadow-lg shadow-purple-200">
                + VIẾT BÀI MỚI
            </a>
        </div>

        <div class="grid gap-4">
            @foreach($posts as $post)
            <div class="bg-white border border-slate-200 rounded-2xl p-5 hover:border-purple-400 transition-all cursor-pointer group shadow-sm hover:shadow-md">
                <div class="flex items-center gap-4">
                    <div class="w-12 h-12 rounded-full bg-purple-100 flex items-center justify-center font-bold text-purple-600">
                        {{ substr($post->user->name, 0, 1) }}
                    </div>

                    <div class="flex-1">
                        <div class="flex items-center gap-3 mb-1">
                            <span class="text-[10px] font-bold px-2 py-0.5 rounded bg-purple-50 text-purple-600 border border-purple-100 uppercase">Thảo luận</span>
                            <span class="text-slate-400 text-xs">{{ $post->created_at->diffForHumans() }}</span>
                        </div>
                        <h2 class="text-xl font-bold text-slate-800 group-hover:text-purple-600 transition">
                            <a href="{{ route('forum.show', $post->id) }}">{{ $post->title }}</a>
                        </h2>
                        <div class="mt-2 flex items-center gap-4 text-sm text-slate-500">
                            <span>Đăng bởi <b class="text-slate-700">{{ $post->user->name }}</b></span>
                            <span>•</span>
                            <span class="flex items-center gap-1">
                                <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path d="M8 12h.01M12 12h.01M16 12h.01M21 12c0 4.418-4.03 8-9 8a9.863 9.863 0 01-4.255-.949L3 20l1.395-3.72C3.512 15.042 3 13.574 3 12c0-4.418 4.03-8 9-8s9 3.582 9 8z"></path></svg>
                                24 bình luận
                            </span>
                        </div>
                    </div>
                </div>
            </div>
            @endforeach
        </div>
    </div>
</div>
@endsection