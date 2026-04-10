@foreach($categories as $key => $name)
<div class="bg-white border border-slate-200 rounded-2xl p-5 flex items-center justify-between mb-4 shadow-sm">
    <div class="flex items-center gap-6 flex-1">
        <div class="w-16 h-16 bg-slate-50 rounded-xl flex items-center justify-center border border-slate-100 font-bold text-slate-400 text-xs uppercase">
            {{ $key }}
        </div>
        
        <div>
            <h3 class="font-bold text-slate-800 text-lg">{{ $name }}</h3>
            {{-- Kiểm tra xem trong Session (biến $selected) đã có linh kiện này chưa --}}
            @if(isset($selected[$key]))
                <p class="text-purple-600 font-semibold">{{ $selected[$key]['name'] }}</p>
                <p class="text-slate-400 text-xs">{{ number_format($selected[$key]['price']) }}đ</p>
            @else
                <p class="text-slate-400 text-sm italic">Chưa chọn sản phẩm nào</p>
            @endif
        </div>
    </div>

    <div class="flex items-center gap-4">
        {{-- Nếu đã chọn thì hiện nút Xóa --}}
        @if(isset($selected[$key]))
            <a href="{{ route('build.remove', ['category' => $key]) }}" class="text-red-400 hover:text-red-600 p-2">
                <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16"></path></svg>
            </a>
        @endif
        
        {{-- Nút dẫn tới trang chọn linh kiện --}}
        <a href="{{ route('build.select', ['category' => $key]) }}" 
           class="bg-purple-600 hover:bg-purple-700 text-white px-6 py-2.5 rounded-xl font-bold transition-all text-sm uppercase">
            {{ isset($selected[$key]) ? 'Thay đổi' : 'Chọn linh kiện' }}
        </a>
    </div>
</div>
@endforeach

{{-- Hiển thị tổng tiền từ Controller truyền qua --}}
<div class="bg-slate-900 text-white p-6 rounded-3xl flex justify-between items-center mt-10">
    <div>
        <p class="text-slate-400 text-xs font-bold uppercase tracking-widest">Tổng chi phí</p>
        <h2 class="text-3xl font-black text-purple-400">{{ number_format($totalPrice) }}đ</h2>
    </div>
    <a href="{{ route('build.reset') }}" class="text-slate-400 hover:text-white text-sm">Xóa hết làm lại</a>
</div>