@foreach($categories as $key => $name)
<div class="card p-6 flex items-center justify-between mb-6 hover:shadow-md transition">
    <div class="flex items-center gap-6 flex-1">
        <div class="w-16 h-16 bg-slate-100 rounded-2xl flex items-center justify-center border border-slate-200 font-bold text-slate-500 text-xs uppercase tracking-widest">
            {{ $key }}
        </div>
        
        <div>
            <h3 class="font-bold text-slate-800 text-lg">{{ $name }}</h3>
            @if(isset($selected[$key]))
                <p class="text-primary-600 font-semibold">{{ $selected[$key]['name'] }}</p>
                <p class="text-slate-500 text-sm">{{ number_format($selected[$key]['price']) }} ₫</p>
            @else
                <p class="text-slate-400 text-sm italic">Chưa chọn sản phẩm nào</p>
            @endif
        </div>
    </div>

    <div class="flex items-center gap-4">
        @if(isset($selected[$key]))
            <a href="{{ route('build.remove', ['category' => $key]) }}" 
               class="text-red-500 hover:text-red-600 p-2 transition">
                <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24" stroke-width="2">
                    <path stroke-linecap="round" stroke-linejoin="round" d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16" />
                </svg>
            </a>
        @endif
        
        <a href="{{ route('build.select', ['category' => $key]) }}" 
           class="btn btn-primary px-7 py-3">
            {{ isset($selected[$key]) ? 'Thay đổi' : 'Chọn linh kiện' }}
        </a>
    </div>
</div>
@endforeach

<div class="card p-8 flex justify-between items-center mt-10">
    <div>
        <p class="text-slate-500 text-xs font-semibold uppercase tracking-widest">TỔNG CHI PHÍ</p>
        <h2 class="text-4xl font-bold mt-2 text-slate-900">{{ number_format($totalPrice) }} ₫</h2>
    </div>
    <a href="{{ route('build.reset') }}" class="btn border border-slate-200 text-slate-700 px-4 py-2 hover:bg-slate-100 transition">Xóa hết & làm lại</a>
</div>