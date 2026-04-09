@extends('layouts.app')

@section('title', 'Gợi ý cấu hình')

@section('content')
<div class="max-w-5xl mx-auto px-8 py-10">

    <h1 class="text-3xl font-black uppercase mb-2">Gợi ý cấu hình</h1>
    <p class="text-gray-500 text-sm mb-10">Nhập nhu cầu và ngân sách, hệ thống sẽ gợi ý cấu hình phù hợp nhất.</p>

    {{-- Form nhập --}}
    <div class="border border-gray-200 p-8 mb-10">
        <div class="grid grid-cols-1 md:grid-cols-3 gap-6">
            
            {{-- Nhu cầu --}}
            <div>
                <label class="block text-xs font-bold uppercase tracking-wide mb-2">Nhu cầu sử dụng</label>
                <div class="space-y-2">
                    @foreach([
                        ['gaming', 'Gaming', 'Chơi game, fps cao'],
                        ['office', 'Văn phòng', 'Word, Excel, lướt web'],
                        ['render', 'Đồ họa / Render', '3D, video editing'],
                        ['streaming', 'Streaming', 'Stream game, OBS'],
                    ] as [$value, $label, $desc])
                    <label class="flex items-start gap-3 border border-gray-200 p-3 cursor-pointer hover:border-black transition group has-[:checked]:border-black has-[:checked]:bg-gray-50">
                        <input type="radio" name="usage" value="{{ $value }}" class="mt-0.5 accent-black">
                        <div>
                            <p class="text-sm font-semibold">{{ $label }}</p>
                            <p class="text-xs text-gray-400">{{ $desc }}</p>
                        </div>
                    </label>
                    @endforeach
                </div>
            </div>

            {{-- Ngân sách --}}
            <div>
                <label class="block text-xs font-bold uppercase tracking-wide mb-2">Ngân sách</label>
                <div class="space-y-2">
                    @foreach([
                        ['5000000', 'Dưới 5 triệu', 'PC văn phòng cơ bản'],
                        ['10000000', '5 - 10 triệu', 'Gaming tầm trung'],
                        ['20000000', '10 - 20 triệu', 'Gaming hiệu năng cao'],
                        ['999999999', 'Trên 20 triệu', 'High-end, không giới hạn'],
                    ] as [$value, $label, $desc])
                    <label class="flex items-start gap-3 border border-gray-200 p-3 cursor-pointer hover:border-black transition group has-[:checked]:border-black has-[:checked]:bg-gray-50">
                        <input type="radio" name="budget" value="{{ $value }}" class="mt-0.5 accent-black">
                        <div>
                            <p class="text-sm font-semibold">{{ $label }}</p>
                            <p class="text-xs text-gray-400">{{ $desc }}</p>
                        </div>
                    </label>
                    @endforeach
                </div>
            </div>

            {{-- Ưu tiên --}}
            <div>
                <label class="block text-xs font-bold uppercase tracking-wide mb-2">Ưu tiên</label>
                <div class="space-y-2">
                    @foreach([
                        ['balanced', 'Cân bằng', 'Hiệu năng tổng thể tốt'],
                        ['performance', 'Hiệu năng tối đa', 'Mạnh nhất trong tầm giá'],
                        ['quiet', 'Yên tĩnh', 'Ít ồn, tản nhiệt tốt'],
                        ['compact', 'Nhỏ gọn', 'Mini ITX, tiết kiệm không gian'],
                    ] as [$value, $label, $desc])
                    <label class="flex items-start gap-3 border border-gray-200 p-3 cursor-pointer hover:border-black transition group has-[:checked]:border-black has-[:checked]:bg-gray-50">
                        <input type="radio" name="priority" value="{{ $value }}" class="mt-0.5 accent-black">
                        <div>
                            <p class="text-sm font-semibold">{{ $label }}</p>
                            <p class="text-xs text-gray-400">{{ $desc }}</p>
                        </div>
                    </label>
                    @endforeach
                </div>
            </div>

        </div>

        {{-- Nút gợi ý --}}
        <div class="mt-8 flex justify-center">
            <button onclick="showResult()" 
                    class="bg-black text-white px-12 py-3 font-bold uppercase tracking-wide hover:bg-gray-800 transition">
                Gợi ý cấu hình cho tôi
            </button>
        </div>
    </div>

    {{-- Kết quả --}}
    <div id="result" class="hidden">
        <div class="flex items-center justify-between mb-6">
            <h2 class="text-2xl font-black uppercase">Cấu hình được gợi ý</h2>
            <span class="text-sm text-gray-500">Gaming · 10 - 20 triệu · Cân bằng</span>
        </div>

        {{-- Bảng cấu hình --}}
        <div class="border border-gray-200 mb-6">
            @foreach([
                ['CPU', 'cpu', 'AMD Ryzen 5 7600X', '6 nhân · AM5 · 5.3GHz boost', '5.800.000 ₫', 92],
                ['Card đồ họa', 'gpu', 'NVIDIA RTX 4060 Ti', '8GB GDDR6 · 2535MHz boost', '8.500.000 ₫', 95],
                ['Mainboard', 'motherboard', 'MSI PRO B650-P WIFI', 'AM5 · ATX · DDR5', '3.200.000 ₫', 88],
                ['RAM', 'memory', 'G.Skill Ripjaws S5 32GB', 'DDR5 · 6000MHz · 2×16GB', '2.100.000 ₫', 90],
                ['Ổ cứng', 'storage', 'Samsung 980 Pro 1TB', 'NVMe M.2 · 7000MB/s', '1.800.000 ₫', 94],
                ['Nguồn', 'psu', 'Corsair RM750e', '750W · 80+ Gold · Modular', '1.900.000 ₫', 91],
                ['Vỏ case', 'case', 'Lian Li Lancool 216', 'ATX · Kính cường lực', '1.700.000 ₫', 87],
            ] as [$type, $img, $name, $specs, $price, $score])
            <div class="grid grid-cols-12 gap-4 px-6 py-4 border-b border-gray-100 hover:bg-gray-50 transition items-center">
                {{-- Loại --}}
                <div class="col-span-2 text-xs font-bold uppercase text-gray-400">{{ $type }}</div>
                {{-- Ảnh + Tên --}}
                <div class="col-span-1">
                    <img src="{{ asset('images/components/' . $img . '.png') }}" class="w-10 h-10 object-contain">
                </div>
                <div class="col-span-4">
                    <p class="font-semibold text-sm">{{ $name }}</p>
                    <p class="text-xs text-gray-400 mt-0.5">{{ $specs }}</p>
                </div>
                {{-- Score --}}
                <div class="col-span-2">
                    <div class="flex items-center gap-2">
                        <div class="flex-1 bg-gray-100 h-1.5 rounded-full">
                            <div class="bg-black h-1.5 rounded-full" style="width: {{ $score }}%"></div>
                        </div>
                        <span class="text-xs text-gray-400">{{ $score }}</span>
                    </div>
                </div>
                {{-- Giá --}}
                <div class="col-span-2 text-right">
                    <p class="font-black text-sm">{{ $price }}</p>
                </div>
                {{-- Đổi --}}
                <div class="col-span-1 text-right">
                    <button class="text-xs border border-gray-300 px-2 py-1 hover:border-black transition">
                        Đổi
                    </button>
                </div>
            </div>
            @endforeach

            {{-- Tổng --}}
            <div class="px-6 py-4 bg-gray-50 flex items-center justify-between">
                <p class="font-bold uppercase text-sm">Tổng chi phí</p>
                <p class="text-2xl font-black">25.000.000 ₫</p>
            </div>
        </div>

        {{-- Actions --}}
        <div class="flex gap-3 justify-end">
            <button class="border border-black px-6 py-2 text-sm font-semibold hover:bg-gray-50 transition">
                Lưu cấu hình
            </button>
            <button class="bg-black text-white px-6 py-2 text-sm font-semibold hover:bg-gray-800 transition">
                Đăng lên diễn đàn
            </button>
        </div>
    </div>

</div>

<script>
function showResult() {
    document.getElementById('result').classList.remove('hidden');
    document.getElementById('result').scrollIntoView({ behavior: 'smooth' });
}
</script>

@endsection