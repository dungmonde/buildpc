@extends('layouts.app')

@section('title', 'Kết quả Tư vấn AI')

@section('content')
<div class="max-w-7xl mx-auto py-12">
    <div class="text-center mb-12">
        <h1 class="text-3xl font-bold text-slate-900 mb-4">Cấu hình đề xuất</h1>
        <p class="text-slate-600">Dựa trên ngân sách <strong class="text-slate-900">{{ number_format($budget) }}đ</strong> và nhu cầu của bạn.</p>
    </div>

    <div class="grid grid-cols-1 {{ count($suggestedBuilds) > 1 ? 'md:grid-cols-2' : 'max-w-3xl mx-auto' }} gap-8">
        @foreach($suggestedBuilds as $index => $build)
            <div class="bg-white rounded-2xl shadow-xl border border-slate-200 overflow-hidden flex flex-col">
                <div class="p-8 bg-slate-50 border-b border-slate-200">
                    <h2 class="text-2xl font-bold text-slate-900 mb-2">{{ $build['title'] }}</h2>
                    <p class="text-slate-600 italic mb-4">{{ $build['explanation'] }}</p>
                    <div class="text-3xl font-black text-emerald-600">{{ number_format($build['total_price']) }} ₫</div>
                </div>

                <div class="p-8 flex-1">
                    <h3 class="font-bold text-slate-900 mb-4 uppercase text-sm tracking-wide">Chi tiết linh kiện</h3>
                    <ul class="space-y-4">
                        @foreach($build['components'] as $cat => $comp)
                            <li class="flex items-center gap-4">
                                <div class="w-12 h-12 bg-white rounded-lg border border-slate-200 p-1 flex items-center justify-center shrink-0">
                                    @if($comp['image'])
                                        <img src="{{ asset('images/components/' . $cat . '/' . $comp['id'] . '.jpg') }}" onerror="this.src='https://via.placeholder.com/50'" class="max-w-full max-h-full object-contain">
                                    @else
                                        <span class="text-xs font-bold text-slate-400 uppercase">{{ substr($cat, 0, 3) }}</span>
                                    @endif
                                </div>
                                <div class="flex-1 min-w-0">
                                    <p class="text-xs font-bold text-slate-400 uppercase">{{ $cat }}</p>
                                    <p class="text-sm font-semibold text-slate-900 truncate">{{ $comp['name'] }}</p>
                                </div>
                                <div class="text-sm font-bold text-slate-700 whitespace-nowrap">
                                    {{ number_format($comp['price']) }}đ
                                </div>
                            </li>
                        @endforeach
                    </ul>
                </div>

                <div class="p-8 border-t border-slate-100 bg-slate-50">
                    <form action="{{ route('ai.apply') }}" method="POST">
                        @csrf
                        @foreach($build['components'] as $cat => $comp)
                            <input type="hidden" name="components[{{ $cat }}]" value="{{ $comp['id'] }}">
                        @endforeach
                        <button type="submit" class="w-full bg-slate-900 text-white font-bold py-4 rounded-xl hover:bg-emerald-600 transition shadow-lg shadow-slate-200">
                            Sử dụng cấu hình này
                        </button>
                    </form>
                </div>
            </div>
        @endforeach
    </div>
    
    <div class="text-center mt-12">
        <a href="{{ route('builder.recommend') }}" class="text-slate-500 hover:text-slate-900 font-medium">← Thử lại</a>
    </div>
</div>
@endsection
