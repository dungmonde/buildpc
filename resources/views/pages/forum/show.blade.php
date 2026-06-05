@extends('layouts.app')

@section('content')
<div class="max-w-4xl mx-auto px-6 py-12">

    <a href="{{ route('forum.index') }}" class="inline-flex items-center gap-2 text-primary-600 hover:underline mb-8">
        ← Quay lại diễn đàn
    </a>

    <div class="p-10 mb-10 bg-white">
        <div class="flex items-start justify-between gap-8 mb-6">
            <h1 class="text-3xl font-bold text-slate-900 flex-1">{{ $post->title }}</h1>
            {{-- Delete button for post owner --}}
            @if(auth()->check() && auth()->id() === $post->user_id)
            <form method="POST" action="{{ route('forum.destroy', $post->id) }}" 
                  onsubmit="return confirm('Bạn chắc chắn muốn xóa bài viết này?')" class="inline">
                @csrf
                @method('DELETE')
                <button type="submit" class="text-slate-400 hover:text-red-500 transition text-2xl font-bold flex-none" title="Xóa bài viết">
                    ✕
                </button>
            </form>
            @endif
        </div>

        <div class="flex items-center gap-4 mb-10">
            <div class="flex-none">
                @include('components.user-avatar', ['user' => $post->user, 'size' => 10, 'class' => 'rounded-2xl bg-primary-100 text-primary-700'])
            </div>
            <div>
                <p class="font-medium">{{ $post->user?->name ?? 'Người dùng' }}</p>
                <p class="text-sm text-slate-500">{{ $post->created_at->diffForHumans() }}</p>
            </div>
        </div>

        <div class="prose prose-slate max-w-none leading-relaxed border-b pb-10">
            {!! nl2br(e($post->content)) !!}
        </div>
    </div>

    {{-- Danh sách bình luận --}}
    <h3 class="text-xl font-semibold mb-6">Bình luận ({{ $post->comments->count() }})</h3>

    @foreach($post->comments as $comment)
    <div class="card p-6 mb-6">
        <div class="flex gap-4">
            <div class="flex-none">
                @include('components.user-avatar', ['user' => $comment->user, 'size' => 9, 'class' => 'rounded-2xl bg-slate-200 text-slate-600 shrink-0'])
            </div>
            <div class="flex-1">
                <div class="flex justify-between">
                    <p class="font-medium">{{ $comment->user?->name ?? 'Người dùng' }}</p>
                    <span class="text-xs text-slate-500">{{ $comment->created_at->diffForHumans() }}</span>
                </div>
                <p class="mt-2 text-slate-700">{{ $comment->content }}</p>
            </div>
        </div>
    </div>
    @endforeach

    {{-- Form đăng bình luận --}}
    @auth
    <div class="card p-8 mt-10">
        <h4 class="font-semibold mb-4">Viết bình luận</h4>
        <form action="{{ route('forum.comment.store', $post->id) }}" method="POST">
            @csrf
            <textarea name="content" rows="4" 
                      class="w-full border border-slate-300 rounded-2xl px-5 py-4 focus:border-primary-500"
                      placeholder="Viết bình luận của bạn..."></textarea>
            
            <button type="submit" 
                    class="mt-4 btn btn-primary px-8 py-3">
                Đăng bình luận
            </button>
        </form>
    </div>
    @else
    <p class="text-center text-slate-500 mt-10">
        <a href="{{ route('login') }}" class="text-primary-600 hover:underline">Đăng nhập</a> để bình luận
    </p>
    @endauth

</div>
@endsection