@extends('layouts.app')

@section('title', 'AI Tư vấn Cấu hình PC')

@section('content')
<div class="max-w-2xl mx-auto py-12">
    <div class="text-center mb-10">
        <h1 class="text-3xl font-bold text-slate-900 mb-4">Gợi ý cấu hình</h1>
        <p class="text-slate-600">Lựa chọn dành cho những ai "gà mờ" về máy tính</p>
    </div>

    @if(session('error'))
        <div class="bg-red-50 text-red-600 p-4 rounded-xl mb-6 border border-red-200">
            {{ session('error') }}
        </div>
    @endif

    <div class="bg-white p-8 rounded-2xl shadow-xl border border-slate-100">
        <form action="{{ route('ai.suggest.post') }}" method="POST" id="ai-form">
            @csrf
            
            <div class="mb-6">
                <label for="budget" class="block text-sm font-semibold text-slate-700 mb-2">Ngân sách tối đa (VNĐ)</label>
                <div class="relative">
                    <span class="absolute left-4 top-1/2 -translate-y-1/2 text-slate-400 font-medium">₫</span>
                    <input type="number" name="budget" id="budget" required min="3000000" step="500000" placeholder="" class="w-full pl-10 pr-4 py-3 rounded-xl border border-slate-200 focus:border-indigo-500 focus:ring focus:ring-indigo-200 transition">
                </div>
                <p class="text-xs text-slate-500 mt-2">Ngân sách tối thiểu: 5.000.000đ</p>
            </div>

            <div class="mb-8">
                <label for="needs" class="block text-sm font-semibold text-slate-700 mb-2">Nhu cầu sử dụng chi tiết</label>
                <textarea name="needs" id="needs" rows="4" required placeholder="" class="w-full px-4 py-3 rounded-xl border border-slate-200 focus:border-indigo-500 focus:ring focus:ring-indigo-200 transition"></textarea>
            </div>

            <button type="submit" id="submit-btn" class="w-full bg-slate-900 text-white font-bold py-4 rounded-xl hover:bg-indigo-600 transition flex items-center justify-center gap-2">
                <span>Bắt đầu tư vấn</span>
            </button>

            <div id="loading" class="hidden mt-6 text-center">
                <div class="inline-block animate-spin rounded-full h-8 w-8 border-4 border-slate-200 border-t-indigo-600 mb-2"></div>
                <p class="text-slate-600 font-medium animate-pulse">Working</p>
            </div>
        </form>
    </div>
</div>

<script>
    document.getElementById('ai-form').addEventListener('submit', function() {
        document.getElementById('submit-btn').classList.add('hidden');
        document.getElementById('loading').classList.remove('hidden');
    });
</script>
@endsection
