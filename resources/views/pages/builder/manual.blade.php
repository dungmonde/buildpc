@extends('layouts.app')

@section('content')
<div class="bg-slate-50 min-h-screen py-10 px-4">
    <div class="max-w-5xl mx-auto">
        
        <div class="mb-8 border-b border-slate-200 pb-6">
            <h1 class="text-3xl font-black text-slate-900 uppercase italic tracking-tighter">Xây dựng cấu hình PC</h1>
            <p class="text-slate-500 mt-1">Chọn từng linh kiện để hoàn thiện bộ máy của bạn.</p>
        </div>

        <div class="space-y-3">
            @foreach($categories as $key => $name)
            <div class="flex items-center justify-between py-6 border-b border-gray-100 group hover:bg-gray-50/50 transition-all px-4 -mx-4 rounded-2xl">
                {{-- Bên trái: Thông tin linh kiện --}}
                <div class="flex items-center gap-8">
                    <span class="text-4xl font-black text-gray-100 italic tracking-tighter group-hover:text-gray-200 transition-colors">
                        0{{ $loop->iteration }}
                    </span>
                    
                    <div>
                        <h3 class="text-[10px] font-black text-gray-400 uppercase tracking-[0.2em] mb-1">{{ $name }}</h3>
                        @if(isset($selected[$key]))
                            <p class="text-lg font-black text-black leading-tight uppercase italic">{{ $selected[$key]['name'] }}</p>
                            <p class="text-purple-600 font-bold text-sm mt-1">{{ number_format($selected[$key]['price']) }} VNĐ</p>
                        @else
                            <p class="text-lg font-bold text-gray-300 uppercase tracking-tighter italic">Chưa xác định</p>
                        @endif
                    </div>
                </div>

                {{-- Bên phải: Nút chọn --}}
                <div class="flex items-center gap-4">
                    @if(isset($selected[$key]))
                        {{-- Nút xóa nếu đã chọn --}}
                        <a href="{{ route('build.remove', ['category' => $key]) }}" class="text-gray-300 hover:text-red-500 transition-colors p-2">
                            <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12"></path></svg>
                        </a>
                        
                        {{-- Nút Thay đổi khi đã có linh kiện --}}
                        <a href="{{ route('build.select', ['category' => $key]) }}" 
                        class="btn-pill bg-black text-white px-8 py-2.5 text-[11px] hover:bg-gray-800 shadow-lg shadow-gray-200">
                            Thay đổi
                        </a>
                    @else
                        {{-- Nút Chọn mới --}}
                        <a href="{{ route('build.select', ['category' => $key]) }}" 
                        class="btn-pill border-2 border-gray-100 text-gray-400 px-8 py-2.5 text-[11px] hover:border-black hover:text-black transition-all">
                            + Chọn linh kiện
                        </a>
                    @endif
                </div>
            </div>
            @endforeach
        </div>

        <div class="sticky bottom-6 mt-10 bg-slate-900 text-white p-6 rounded-3xl flex justify-between items-center shadow-2xl border border-slate-800 animate-fade-in-up">
            <div>
                <p class="text-slate-400 text-[10px] font-bold uppercase tracking-widest mb-1">Tổng chi phí dự tính</p>
                <h2 class="text-3xl font-black text-purple-400">
                    {{ number_format($totalPrice) }} <span class="text-sm font-normal text-white">VNĐ</span>
                </h2>
            </div>
            <div class="flex gap-4">
                <a href="{{ route('build.reset') }}" class="flex items-center text-slate-400 hover:text-white text-xs font-bold uppercase transition">Làm mới</a>
                <button class="bg-purple-600 hover:bg-purple-700 text-white px-8 py-3 rounded-2xl font-bold shadow-lg shadow-purple-500/20 transition-all transform hover:scale-105 uppercase text-sm">
                    Thêm vào giỏ
                </button>
            </div>
        </div>

    </div>
</div>
@endsection