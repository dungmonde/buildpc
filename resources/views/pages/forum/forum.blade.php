@extends('layouts.app')

@section('content')
<div class="max-w-6xl mx-auto">
        <div class="flex justify-between items-center mb-10">
            <h1 class="text-3xl font-bold text-slate-900">
                DIỄN ĐÀN <span class="text-primary-600">THẢO LUẬN</span>
            </h1>
            <a href="{{ route('forum.create') }}" 
               class="btn btn-primary px-8 py-3">
                + Viết bài mới
            </a>
        </div>

        <div class="space-y-6">
            @foreach($posts as $post)
            <div class="card p-7 hover:shadow-md transition group">
                <div class="flex items-center gap-5">
                    <div class="flex-none">
                        @include('components.user-avatar', ['user' => $post->user, 'size' => 12, 'class' => 'rounded-2xl bg-primary-100 text-primary-700'])
                    </div>

                    <div class="flex-1">
                        <div class="flex items-center gap-3 mb-2">
                            <span class="text-xs font-bold px-3 py-1 bg-primary-50 text-primary-700 rounded-xl">Thảo luận</span>
                            <span class="text-slate-500 text-sm">{{ $post->created_at->diffForHumans() }}</span>
                        </div>
                        <h2 class="text-xl font-semibold group-hover:text-primary-600 transition">
                            <a href="{{ route('forum.show', $post->id) }}">{{ $post->title }}</a>
                        </h2>
                        <p class="text-sm text-slate-500 mt-2">
                            Đăng bởi <span class="font-medium">{{ $post->user?->name ?? 'Người dùng' }}</span>
                        </p>
                    </div>
                </div>
            </div>
            @endforeach
        </div>
    </div>
</div>
@endsection