@extends('layouts.app')

@section('content')
<div class="bg-slate-50 min-h-screen py-10 px-4">
    <div class="max-w-6xl mx-auto">
        <div class="mb-8 flex items-center justify-between">
            <h2 class="text-2xl font-bold text-slate-800 uppercase italic">Chọn {{ $category_name }}</h2>
            <a href="{{ route('build.index') }}" class="text-slate-500 hover:text-purple-600 font-bold underline">← Quay lại</a>
        </div>

        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-2 gap-8 mt-10">
            @foreach($items as $item)
            <div class="bg-white border border-gray-100 rounded-[2rem] p-8 flex flex-col justify-between hover:shadow-2xl hover:shadow-gray-100 transition-all group relative overflow-hidden">
                
                <div class="flex gap-6">
                    {{-- Ảnh linh kiện --}}
                    <div class="w-32 h-32 bg-gray-50 rounded-2xl flex items-center justify-center overflow-hidden border border-gray-50 group-hover:scale-105 transition-transform">
                        <img src="{{ $item->image_url ?? 'https://via.placeholder.com/150' }}" 
                            alt="{{ $item->name }}" 
                            class="object-contain w-full h-full p-2">
                    </div>

                    {{-- Thông tin tên và giá --}}
                    <div class="flex-1">
                        <h3 class="text-xl font-black text-black leading-tight uppercase italic tracking-tighter mb-2 group-hover:text-purple-600 transition-colors">
                            {{ $item->name }}
                        </h3>
                        <p class="text-2xl font-black text-purple-600 italic">
                            {{ number_format($item->price ?? 0) }} <span class="text-xs font-bold text-gray-400 uppercase tracking-widest">VNĐ</span>
                        </p>
                    </div>
                </div>

                {{-- Nút chọn nằm ở dưới --}}
                <div class="mt-8 flex justify-end">
                    <a href="{{ route('build.add', ['category' => $category, 'component_id' => $item->id]) }}" 
                    class="btn-pill bg-black text-white px-10 py-3 text-[11px] hover:bg-purple-600 shadow-xl shadow-gray-200 transform hover:-translate-y-1 active:scale-95 transition-all">
                        Chọn sản phẩm này
                    </a>
                </div>

                {{-- Hiệu ứng trang trí góc thẻ --}}
                <div class="absolute top-0 right-0 p-4 opacity-10 group-hover:opacity-100 transition-opacity">
                    <svg class="w-8 h-8 text-purple-600" fill="currentColor" viewBox="0 0 20 20"><path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd"></path></svg>
                </div>
            </div>
            @endforeach
        </div>
    </div>
</div>
@endsection