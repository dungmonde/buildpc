@extends('layouts.app')
@section('title', 'Gợi ý cấu hình')
@section('content')
<div class="max-w-6xl mx-auto px-4 py-10">
    <h1 class="text-3xl font-black uppercase mb-2 text-center">Gợi ý cấu hình</h1>
    <p class="text-gray-500 text-sm mb-10 text-center">Nhập nhu cầu và ngân sách, hệ thống sẽ gợi ý cấu hình phù hợp nhất.</p>

    <form action="{{ route('builder.recommend.result') }}" method="POST" class="card p-8 mb-10 max-w-4xl mx-auto">
        @csrf
        <div class="grid grid-cols-1 md:grid-cols-2 gap-10">

            <div>
                <label class="block text-sm font-bold uppercase tracking-wide mb-3">Nhu cầu sử dụng</label>
                <select name="usage" class="w-full rounded-lg p-3 ring-1 ring-slate-200 outline-none focus:ring-2 focus:ring-indigo-500 transition text-sm">
                    <option value="gaming"    {{ (old('usage', $usage ?? '') === 'gaming')    ? 'selected' : '' }}>Gaming (Chơi game, FPS cao)</option>
                    <option value="office"    {{ (old('usage', $usage ?? '') === 'office')    ? 'selected' : '' }}>Văn phòng (Word, Excel, Lướt web)</option>
                    <option value="render"    {{ (old('usage', $usage ?? '') === 'render')    ? 'selected' : '' }}>Đồ họa / Render (3D, Video Editing)</option>
                    <option value="streaming" {{ (old('usage', $usage ?? '') === 'streaming') ? 'selected' : '' }}>Streaming (Stream game, OBS)</option>
                </select>
            </div>

            <div>
                <label class="block text-sm font-bold uppercase tracking-wide mb-3">Ngân sách dự kiến (VNĐ)</label>
                  <input type="number" id="budgetInput" name="budget"
                       value="{{ old('budget', $budget ?? '') }}"
                       placeholder="Nhập số tiền..."
                      class="w-full rounded-lg p-3 ring-1 ring-slate-200 outline-none focus:ring-2 focus:ring-indigo-500 transition text-sm mb-3">
                <div class="flex flex-wrap gap-2">
                    @foreach([5, 10, 15, 20, 30, 40, 50] as $mil)
                    <button type="button"
                            data-budget="{{ $mil * 1000000 }}"
                            class="text-xs rounded-full bg-white ring-1 ring-slate-200 text-slate-700 px-3 py-1.5 hover:shadow-sm hover:text-indigo-600 transition">
                        {{ $mil }} Triệu
                    </button>
                    @endforeach
                </div>
            </div>

        </div>

        <div class="mt-8 flex justify-center">
            <button type="submit"
                    class="bg-indigo-600 text-white px-12 py-3 rounded-xl font-bold uppercase tracking-wide hover:bg-indigo-700 transition">
                Gợi ý cấu hình
            </button>
        </div>
    </form>

    {{-- KẾT QUẢ --}}
    @isset($result)
        @if(count($result) > 0)
        <div class="max-w-4xl mx-auto">

            <div class="flex items-center justify-between mb-6">
                <h2 class="text-xl font-black uppercase">Cấu hình gợi ý</h2>
                <div class="flex gap-2 text-xs">
                    <span class="bg-indigo-50 text-indigo-600 border border-indigo-100 px-3 py-1 rounded-full font-semibold">
                        {{ ['gaming'=>'Gaming','office'=>'Văn phòng','render'=>'Đồ họa','streaming'=>'Streaming'][$usage ?? 'gaming'] }}
                    </span>
                    <span class="bg-gray-100 text-gray-600 px-3 py-1 rounded-full font-semibold">
                        Ngân sách: {{ number_format($budget, 0, ',', '.') }}₫
                    </span>
                </div>
            </div>

            <div class="card overflow-hidden">

                {{-- Header --}}
                <div class="flex justify-between items-center px-6 py-4 bg-gray-50">
                    <h3 class="font-black uppercase text-indigo-600">Kết quả từ dữ liệu thực tế</h3>
                    <span class="text-xl font-black">{{ number_format($totalPrice, 0, ',', '.') }} ₫</span>
                </div>

                {{-- Danh sách --}}
                @php
                    $typeLabels = [
                        'CPU'         => ['icon' => '', 'label' => 'CPU'],
                        'GPU'         => ['icon' => '', 'label' => 'Card đồ họa'],
                        'MOTHERBOARD' => ['icon' => '', 'label' => 'Mainboard'],
                        'RAM'         => ['icon' => '', 'label' => 'RAM'],
                        'STORAGE'     => ['icon' => '', 'label' => 'Ổ cứng'],
                        'PSU'         => ['icon' => '', 'label' => 'Nguồn'],
                        'COOLER'      => ['icon' => '', 'label' => 'Tản nhiệt'],
                        'CASE'        => ['icon' => '', 'label' => 'Vỏ case'],
                    ];
                @endphp

                <div class="divide-y divide-gray-100">
                    @foreach($result as $typeName => $component)
                    @php $meta = $typeLabels[$typeName] ?? ['icon' => '', 'label' => $typeName]; @endphp
                    <div class="flex justify-between items-center px-6 py-4 hover:bg-gray-50 transition text-sm">
                        <div class="flex items-center gap-4">
                            <span class="text-lg w-6 text-center">{{ $meta['icon'] }}</span>
                            <span class="font-bold text-gray-400 w-24 inline-block uppercase text-xs">{{ $meta['label'] }}</span>
                            <span class="font-semibold text-gray-800">{{ $component->name }}</span>
                        </div>
                        <span class="font-black text-indigo-700 shrink-0 ml-4">
                            {{ number_format($component->price, 0, ',', '.') }} ₫
                        </span>
                    </div>
                    @endforeach
                </div>

                {{-- Footer --}}
                <div class="flex items-center justify-between px-6 py-5 bg-gray-50">
                    <div>
                        <p class="text-xs text-gray-400">Ngân sách còn dư</p>
                        <p class="font-bold text-green-600">
                            {{ number_format(max(0, $budget - $totalPrice), 0, ',', '.') }} ₫
                        </p>
                    </div>
                    <div class="flex gap-3">
                        @auth
                        <form action="{{ route('build.apply-recommend') }}" method="POST" class="inline">
                            @csrf
                            @foreach($result as $typeName => $component)
                                <input type="hidden" name="components[{{ $typeName }}]" value="{{ $component->id }}">
                            @endforeach
                            <button type="submit"
                                    class="bg-indigo-600 text-white px-6 py-2 rounded-lg text-sm font-semibold hover:bg-indigo-700 transition">
                                 Dùng để build
                            </button>
                        </form>
                        @else
                        <a href="{{ route('login') }}"
                           class="bg-indigo-600 text-white px-6 py-2 rounded-lg text-sm font-semibold hover:bg-indigo-700 transition">
                            Đăng nhập để build
                        </a>
                        @endauth
                    </div>
                </div>

            </div>

            {{-- Slot không tìm được --}}
            @php
                $allTypes = ['CPU','GPU','MOTHERBOARD','RAM','STORAGE','PSU','COOLER','CASE'];
                $missing  = array_diff($allTypes, array_keys($result));
            @endphp
            @if(count($missing) > 0)
            <div class="mt-4 bg-orange-50 border border-orange-200 rounded-xl px-5 py-3 text-sm text-orange-600">
                ⚠ Không tìm được: {{ implode(', ', $missing) }} — ngân sách phân bổ cho các linh kiện này quá thấp. Thử tăng ngân sách.
            </div>
            @endif

        </div>

        @else
            <div class="max-w-4xl mx-auto bg-orange-50 ring-1 ring-orange-200 rounded-xl p-8 text-center">
            <p class="text-2xl mb-2"></p>
            <p class="font-semibold text-orange-700">Không tìm được cấu hình phù hợp</p>
            <p class="text-sm text-orange-500 mt-1">Ngân sách quá thấp hoặc không đủ linh kiện trong hệ thống. Thử tăng ngân sách nhé!</p>
        </div>
        @endif
    @endisset

</div>
<script>
    document.querySelectorAll('[data-budget]').forEach((button) => {
        button.addEventListener('click', () => {
            document.getElementById('budgetInput').value = button.dataset.budget;
        });
    });
</script>
@endsection
