@extends('layouts.app')

@section('title', 'Trang chủ')

@section('content')

{{-- Hero Section --}}
<section class="max-w-7xl mx-auto px-8 py-8">
    <div class="grid grid-cols-3 gap-8 items-center">
        
        {{-- Cột 1: Heading + CTA --}}
        <div>
            <h1 class="text-5xl font-black leading-tight uppercase">
                Pick Parts. Build Your PC. Compare and Share.
            </h1>
            <p class="text-gray-500 mt-4 text-sm">
                Chúng tôi cung cấp hướng dẫn về lựa chọn linh kiện, giá cả và khả năng tương thích cho những người tự lắp ráp máy tính.
            </p>
            <div class="flex gap-3 mt-8">
                <a href="{{ route('builder.recommend') }}" 
                   class="bg-black text-white px-6 py-3 text-sm font-semibold hover:bg-gray-800 transition">
                    Gợi ý cấu hình
                </a>
                <a href="{{ route('builder.manual') }}" 
                   class="border border-black px-6 py-3 text-sm font-semibold hover:bg-black hover:text-white transition">
                    Tự build cấu hình
                </a>
            </div>
        </div>

        {{-- Cột 2: Ảnh PC ở giữa --}}
        <div class="flex justify-center">
            <img src="{{ asset('images/illustration/hero_pc_image.jpg') }}" 
                alt="PC" 
                class="w-128 h-128 object-contain">
        </div>

        {{-- Cột 3: Mô tả bên phải --}}
        <div class="space-y-6">
            <div>
                <h3 class="font-bold text-lg">Gợi ý cấu hình</h3>
                <p class="text-gray-500 text-sm mt-1">
                    Bạn đang tự lắp ráp PC và cần ý tưởng để bắt đầu? Hãy tham khảo các hướng dẫn lắp ráp của chúng tôi, bao gồm các hệ thống phù hợp với nhiều mục đích sử dụng và ngân sách khác nhau.
                </p>
            </div>
            <div>
                <h3 class="font-bold text-lg">Tự xây dựng</h3>
                <p class="text-gray-500 text-sm mt-1">
                    Tự tay chọn từng linh kiện theo sở thích của bạn.
                </p>
            </div>
        </div>

    </div>
</section>

<section class="max-w-7xl mx-auto px-8 py-8">
    <h2 class="text-3xl font-black uppercase mb-8">Linh kiện</h2>

    <div class="grid grid-cols-2 md:grid-cols-4 gap-4">
        @foreach([
            ['CPU', 'cpu', 'cpu.jpg'],
            ['Card đồ họa', 'gpu', 'gpu.jpg'],
            ['Mainboard', 'motherboard', 'mainboard.jpg'],
            ['RAM', 'ram', 'ram.jpg'],
            ['Ổ cứng', 'storage', 'storage.jpg'],
            ['Nguồn', 'psu', 'power_supply.jpg'],
            ['Tản nhiệt', 'cooler', 'cpu_cooler.jpg'],
            ['Vỏ case', 'case', 'case.jpg'],
        ] as [$label, $type, $img])

        <a href="{{ route('components.index', $type) }}"
           class="group border border-gray-200 p-6 flex flex-col items-center gap-3 transition duration-300 relative overflow-hidden">

            <div class="absolute inset-0 bg-black opacity-0 group-hover:opacity-90 transition duration-300"></div>

            <div class="relative z-10 flex flex-col items-center gap-3">
                <img src="{{ asset('images/illustration/' . $img) }}"
                     class="w-48 h-48 object-contain transition duration-300 group-hover:scale-110">

                <span class="text-sm font-semibold transition duration-300 group-hover:text-white">
                    {{ $label }}
                </span>
            </div>

        </a>

        @endforeach
    </div>
</section>


{{-- Section: FAQ --}}
<section id="faq-section" class="max-w-7xl mx-auto px-8 py-8 border-t border-gray-200">
    <div class="text-center mb-10">
        <h2 class="text-3xl font-black uppercase">Câu hỏi thường gặp</h2>
        <p class="text-gray-500 text-sm mt-2">Tổng hợp các câu hỏi phổ biến nhất.</p>
    </div>
    <div class="max-w-3xl mx-auto divide-y divide-gray-200" x-data="{ open: null }">
        @foreach([
            ['Tôi có thể tự chọn linh kiện theo ý muốn không?', 'Có! Bạn có thể vào mục "Tự xây dựng" để tự tay chọn từng linh kiện. Hệ thống sẽ kiểm tra tương thích tự động.'],
            ['Hệ thống gợi ý cấu hình hoạt động như thế nào?', 'Bạn nhập nhu cầu sử dụng và ngân sách, hệ thống sẽ dùng thuật toán để gợi ý cấu hình phù hợp nhất.'],
            ['Tôi cần những linh kiện gì để lắp một bộ PC?', 'Một bộ PC cơ bản cần: CPU, Mainboard, RAM, Ổ cứng, Card đồ họa, Nguồn và Vỏ case.'],
            ['Làm sao biết linh kiện có tương thích với nhau không?', 'Hệ thống sẽ tự động kiểm tra và cảnh báo nếu có linh kiện không tương thích khi bạn đang build.'],
            ['Tôi có thể chia sẻ cấu hình PC của mình không?', 'Có! Sau khi hoàn thành build, bạn có thể đăng lên diễn đàn để chia sẻ và nhận góp ý từ cộng đồng.'],
        ] as $i => [$question, $answer])
        <div x-data="{ open: false }" class="py-4">
            <button @click="open = !open" class="w-full flex items-center justify-between text-left text-sm font-semibold hover:text-gray-600">
                <span>{{ $question }}</span>
                <span x-text="open ? '−' : '+'" class="text-lg font-light ml-4"></span>
            </button>
            <div x-show="open" x-transition class="mt-3 text-sm text-gray-500">
                {{ $answer }}
            </div>
        </div>
        @endforeach
    </div>
</section>

{{-- Section: Diễn đàn --}}
<section class="max-w-7xl mx-auto px-8 py-8 border-t border-gray-200">
    <div class="flex items-center justify-between mb-6">
        <h2 class="text-3xl font-black uppercase">Diễn đàn</h2>
        <a href="{{ route('forum.index') }}" class="text-sm underline hover:no-underline">Xem thêm</a>
    </div>

    <div class="divide-y divide-gray-200 border border-gray-200">
        @forelse($posts as $post)
        <div class="flex items-center gap-4 px-4 py-4 hover:bg-gray-50 transition group">
            
            <div class="w-9 h-9 rounded-full bg-gray-200 flex items-center justify-center text-xs font-bold text-gray-600 shrink-0">
                {{ strtoupper(substr($post->user_name, 0, 1)) }}
            </div>

            <div class="flex-1 min-w-0">
                <a href="{{ route('forum.show', $post->id) }}" 
                   class="font-semibold text-sm group-hover:underline line-clamp-1">
                    {{ $post->title }}
                </a>
                <p class="text-xs text-gray-400 mt-0.5">{{ $post->user_name }}</p>
            </div>

            <div class="hidden md:flex items-center gap-6 text-xs text-gray-400 shrink-0">
                <div class="text-center">
                    <p class="font-semibold text-gray-700">{{ $post->replies ?? 0 }}</p>
                    <p>Trả lời</p>
                </div>
                <div class="text-center">
                    <p class="font-semibold text-gray-700">{{ $post->views ?? 0 }}</p>
                    <p>Lượt xem</p>
                </div>
                <div class="text-right min-w-[80px]">
                    <p class="text-gray-500">
                        {{ \Carbon\Carbon::parse($post->created_at)->diffForHumans() }}
                    </p>
                </div>
            </div>

        </div>
        @empty
        <div class="text-center py-6 text-gray-500 text-sm">
            Chưa có bài viết nào
        </div>
        @endforelse
    </div>
</section>

{{-- Section: Cần hỗ trợ --}}
<section class="max-w-7xl mx-auto px-8 py-8 border-t border-gray-200">
    <div class="grid grid-cols-1 md:grid-cols-2 gap-12">
        <div>
            <h2 class="text-3xl font-black uppercase">Cần hỗ trợ?</h2>
            <p class="text-gray-500 text-sm mt-4">
                Nếu cần trợ giúp, hãy xem qua phần FAQ của chúng tôi — nơi tổng hợp các câu hỏi thường gặp nhất.
            </p>
            <p class="text-gray-500 text-sm mt-3">
                Không tìm thấy câu trả lời? Liên hệ trực tiếp qua email hoặc điện thoại bên dưới.
            </p>
        </div>
        <div class="space-y-3 text-sm text-gray-600">
            <p>✉ support@pcbuilder.vn</p>
            <p>☎ 0123-456-789</p>
            <p>📍 Hà Nội, Việt Nam</p>
        </div>
    </div>
</section>

@endsection