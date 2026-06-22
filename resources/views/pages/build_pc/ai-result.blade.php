@extends('layouts.app')

@section('title', 'Kết quả Tư vấn AI')

@section('content')
<div class="max-w-7xl mx-auto py-12">
    <div class="text-center mb-12">
        <h1 class="text-3xl font-bold text-slate-900 mb-4">Cấu hình đề xuất</h1>
        <p class="text-slate-600">Dựa trên ngân sách <strong class="text-slate-900">{{ number_format($budget) }}đ</strong> và nhu cầu của bạn.</p>
    </div>

    @if(isset($isOverkill) && $isOverkill)
        <div class="max-w-3xl mx-auto mb-10 bg-amber-50 border border-amber-200 rounded-2xl p-6 shadow-lg shadow-amber-50/20">
            <div class="flex items-start gap-4">
                <div class="text-amber-500 text-3xl"></div>
                <div class="flex-1">
                    <p class="text-amber-800 text-sm leading-relaxed">
                        Thực tế, chỉ khoảng 15 triệu đã có thể đáp ứng được nhu cầu của bạn rất tốt, nên nếu bạn chỉ cần một chiếc máy giúp bạn làm tác vụ văn phòng cơ bản, thỉnh thoảng giải trí nhẹ nhàng thì cấu hình bên dưới sẽ tối ưu về giá hơn. Tuy nhiên, nếu bạn vẫn muốn tối ưu hết ngân sách của mình, hãy nhấn nút bên dưới để sử dụng hết ngân sách của bạn. 
                        <form action="{{ route('ai.suggest.post') }}" method="POST" class="inline">
                            @csrf
                            <input type="hidden" name="budget" value="{{ $originalBudget }}">
                            <input type="hidden" name="needs" value="{{ $needs }}">
                            <input type="hidden" name="confirm_overkill" value="1">
                            <button type="submit" class="font-bold text-amber-700 hover:text-amber-900 underline cursor-pointer bg-transparent border-0 p-0 inline-block align-baseline focus:outline-none">
                                Xác nhận
                            </button>
                        </form>.
                    </p>
                </div>
            </div>
        </div>
    @endif

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
                    @php
                        $imgMap = [
                            'mainboard' => 'motherboard',
                            'vga' => 'gpu',
                        ];
                    @endphp
                    <ul class="space-y-4">
                        @foreach($build['components'] as $cat => $comp)
                            <li class="flex items-center gap-4">
                                <div class="w-12 h-12 bg-white rounded-lg border border-slate-200 p-1 flex items-center justify-center shrink-0">
                                    @if($comp['image'])
                                        <img src="{{ asset('images/components/' . ($imgMap[$cat] ?? $cat) . '/' . $comp['id'] . '.jpg') }}" onerror="this.src='https://via.placeholder.com/50'" class="max-w-full max-h-full object-contain">
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
