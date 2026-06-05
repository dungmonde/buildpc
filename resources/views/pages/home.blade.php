@extends('layouts.app')

@section('title', 'Trang chủ')

@section('content')

<div class="selection:bg-indigo-100 selection:text-indigo-900">

    {{-- Hero Section (3 cột) --}}
    <section class="max-w-7xl mx-auto px-6 py-16 sm:py-24 lg:py-32">
        <div class="grid grid-cols-1 gap-12 lg:grid-cols-[1.1fr_1fr_0.9fr] items-center">
            <div class="p-10 bg-white">
                <div class="space-y-8 lg:space-y-10">
                    <div>
                        <h1 class="text-4xl sm:text-5xl lg:text-6xl font-extrabold tracking-tight text-slate-900">
                            Pick Parts. Build Your PC.<br class="block"> Compare and Share.
                        </h1>
                        <p class="mt-6 max-w-xl text-lg text-slate-600">
                            Chúng tôi cung cấp hướng dẫn về lựa chọn linh kiện, giá cả và khả năng tương thích cho những người tự lắp ráp máy tính.
                        </p>
                    </div>

                    <div class="flex flex-col sm:flex-row sm:items-center sm:gap-4 gap-3">
                        <a href="{{ route('builder.recommend') }}"
                           class="inline-flex items-center justify-center rounded-full bg-slate-900 px-8 py-3.5 text-sm font-semibold text-white shadow-sm hover:bg-slate-700 focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-slate-900 transition-all">
                            Gợi ý
                        </a>
                        <a href="{{ route('builder.manual') }}"
                           class="inline-flex items-center justify-center rounded-full bg-white px-8 py-3.5 text-sm font-semibold text-slate-900 shadow-sm ring-1 ring-inset ring-slate-300 hover:bg-slate-50 transition-all">
                            Xây dựng
                        </a>
                    </div>
                </div>
            </div>

            <div class="flex justify-center">
                <img src="{{ asset('images/illustration/hero_pc_image.jpg') }}" alt="PC"
                     class="w-full max-w-xl rounded-[2rem] object-contain" />
            </div>

            <div class="card p-10">
                <h2 class="text-3xl font-bold tracking-tight text-slate-900">
                    Hướng dẫn build PC
                </h2>
                <p class="mt-6 text-base leading-8 text-slate-600">
                    Bạn đang muốn tự build một bộ PC và cần ý tưởng để bắt đầu? Hãy tham khảo các hướng dẫn build của chúng tôi, được thiết kế cho nhiều mục đích sử dụng khác nhau và phù hợp với nhiều mức ngân sách.
                </p>
            </div>
        </div>
    </section>

    {{-- Components Section (Dạng thẻ Grid bo góc) --}}
    <section class="max-w-7xl mx-auto px-6 py-16">
        <div class="flex items-center justify-between mb-8">
            <h2 class="text-3xl font-bold tracking-tight text-slate-900">Linh kiện</h2>
        </div>
        <div class="grid grid-cols-2 md:grid-cols-4 gap-6">
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
               class="group relative flex flex-col items-center justify-center p-8 rounded-3xl bg-white shadow-sm ring-1 ring-slate-200 transition-all hover:shadow-md hover:ring-slate-300">
                <img src="{{ asset('images/illustration/' . $img) }}"
                     class="w-32 h-32 object-contain transition-transform duration-300 group-hover:scale-105">
                <span class="mt-4 text-sm font-semibold text-slate-900">
                    {{ $label }}
                </span>
            </a>
            @endforeach
        </div>
    </section>

    {{-- FAQ Section (Accordion hiện đại) --}}
    <section id="faq-section" class="max-w-3xl mx-auto px-6 py-16">
        <div class="text-center mb-12">
            <h2 class="text-3xl font-bold tracking-tight text-slate-900">Câu hỏi thường gặp</h2>
            <p class="text-slate-500 mt-2">Tổng hợp các câu hỏi phổ biến nhất.</p>
        </div>
        <div class="space-y-4">
            @foreach([
                ['Tôi có thể tự chọn linh kiện theo ý muốn không?', 'Có! Bạn có thể vào mục "Tự xây dựng" để tự tay chọn từng linh kiện. Hệ thống sẽ kiểm tra tương thích tự động.'],
                ['Hệ thống gợi ý cấu hình hoạt động như thế nào?', 'Bạn nhập nhu cầu sử dụng và ngân sách, hệ thống sẽ dùng thuật toán để gợi ý cấu hình phù hợp nhất.'],
                ['Tôi cần những linh kiện gì để lắp một bộ PC?', 'Một bộ PC cơ bản cần: CPU, Mainboard, RAM, Ổ cứng, Card đồ họa, Nguồn và Vỏ case.'],
                ['Làm sao biết linh kiện có tương thích với nhau không?', 'Hệ thống sẽ tự động kiểm tra và cảnh báo nếu có linh kiện không tương thích khi bạn đang build.'],
                ['Tôi có thể chia sẻ cấu hình PC của mình không?', 'Có! Sau khi hoàn thành build, bạn có thể đăng lên diễn đàn để chia sẻ và nhận góp ý từ cộng đồng.'],
            ] as $i => [$question, $answer])
            <div x-data="{ open: false }" class="rounded-2xl bg-white ring-1 ring-slate-200 overflow-hidden transition-all hover:ring-slate-300">
                <button @click="open = !open" class="w-full flex items-center justify-between px-6 py-4 text-left text-sm font-semibold text-slate-900 focus:outline-none">
                    <span>{{ $question }}</span>
                    <span x-show="!open" class="text-slate-400">
                        <svg class="h-5 w-5" viewBox="0 0 20 20" fill="currentColor"><path d="M10.75 4.75a.75.75 0 00-1.5 0v4.5h-4.5a.75.75 0 000 1.5h4.5v4.5a.75.75 0 001.5 0v-4.5h4.5a.75.75 0 000-1.5h-4.5v-4.5z" /></svg>
                    </span>
                    <span x-show="open" class="text-slate-400" x-cloak>
                        <svg class="h-5 w-5" viewBox="0 0 20 20" fill="currentColor"><path fill-rule="evenodd" d="M4 10a.75.75 0 01.75-.75h10.5a.75.75 0 010 1.5H4.75A.75.75 0 014 10z" clip-rule="evenodd" /></svg>
                    </span>
                </button>
                <div x-show="open" x-transition class="px-6 pb-4 text-sm text-slate-600">
                    {{ $answer }}
                </div>
            </div>
            @endforeach
        </div>
    </section>

    {{-- Forum Section (Danh sách bóng bẩy, chia vạch) --}}
    <section class="max-w-7xl mx-auto px-6 py-16">
        <div class="flex items-center justify-between mb-8">
            <h2 class="text-3xl font-bold tracking-tight text-slate-900">Diễn đàn</h2>
            <a href="{{ route('forum.index') }}" class="text-sm font-semibold text-indigo-600 hover:text-indigo-500">Xem tất cả <span aria-hidden="true">&rarr;</span></a>
        </div>

        <div class="rounded-3xl bg-white ring-1 ring-slate-200 overflow-hidden shadow-sm">
            <ul role="list" class="divide-y divide-slate-200">
                @forelse($posts as $post)
                <li class="relative flex justify-between gap-x-6 px-6 py-5 hover:bg-slate-50 transition-colors">
                    <div class="flex min-w-0 gap-x-4 items-center">
                                <div class="flex-none">
                            @include('components.user-avatar', ['user' => $post->user, 'size' => 10, 'class' => 'ring-1 ring-inset ring-slate-300'])
                        </div>
                        <div class="min-w-0 flex-auto">
                            <p class="text-sm font-semibold leading-6 text-slate-900">
                                <a href="{{ route('forum.show', $post->id) }}">
                                    <span class="absolute inset-x-0 -top-px bottom-0"></span>
                                    {{ $post->title }}
                                </a>
                            </p>
                            <p class="mt-1 flex text-xs leading-5 text-slate-500">
                                Đăng bởi {{ $post->user?->name ?? 'Người dùng' }}
                            </p>
                        </div>
                    </div>
                    <div class="hidden sm:flex shrink-0 items-center gap-x-6">
                        <div class="text-right">
                            <p class="text-sm leading-6 text-slate-900 font-medium">{{ $post->replies ?? 0 }} <span class="font-normal text-slate-500">Trả lời</span></p>
                        </div>
                        <div class="text-right">
                            <p class="text-sm leading-6 text-slate-900 font-medium">{{ $post->views ?? 0 }} <span class="font-normal text-slate-500">Lượt xem</span></p>
                        </div>
                        <div class="text-right min-w-[90px]">
                            <p class="text-xs leading-5 text-slate-500">
                                {{ \Carbon\Carbon::parse($post->created_at)->diffForHumans() }}
                            </p>
                        </div>
                    </div>
                </li>
                @empty
                <li class="px-6 py-12 text-center">
                    <h3 class="text-sm font-semibold text-slate-900">Chưa có bài viết nào</h3>
                    <p class="mt-1 text-sm text-slate-500">Hãy là người đầu tiên tạo thảo luận trên diễn đàn.</p>
                </li>
                @endforelse
            </ul>
        </div>
    </section>

    {{-- Support Section (Footer Block tối màu sang trọng) --}}
    <section class="max-w-7xl mx-auto px-6 py-16 mb-8">
        <div class="rounded-3xl bg-slate-900 px-6 py-12 sm:p-16">
            <div class="grid grid-cols-1 md:grid-cols-2 gap-12 items-center">
                <div>
                    <h2 class="text-3xl font-bold tracking-tight text-white">Cần hỗ trợ?</h2>
                    <p class="mt-4 text-lg text-slate-300">
                        Nếu cần trợ giúp, hãy xem qua phần FAQ của chúng tôi — nơi tổng hợp các câu hỏi thường gặp nhất. Không tìm thấy câu trả lời? Đừng ngần ngại liên hệ trực tiếp.
                    </p>
                </div>
                <div class="flex flex-col gap-4 text-slate-300 text-sm font-medium md:pl-12 md:border-l md:border-slate-700">
                    <div class="flex items-center gap-3">
                        <svg class="w-5 h-5 text-slate-400" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor"><path stroke-linecap="round" stroke-linejoin="round" d="M21.75 6.75v10.5a2.25 2.25 0 01-2.25 2.25h-15a2.25 2.25 0 01-2.25-2.25V6.75m19.5 0A2.25 2.25 0 0019.5 4.5h-15a2.25 2.25 0 00-2.25 2.25m19.5 0v.243a2.25 2.25 0 01-1.07 1.916l-7.5 4.615a2.25 2.25 0 01-2.36 0L3.32 8.91a2.25 2.25 0 01-1.07-1.916V6.75" /></svg>
                        support@pcbuilder.vn
                    </div>
                    <div class="flex items-center gap-3">
                        <svg class="w-5 h-5 text-slate-400" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor"><path stroke-linecap="round" stroke-linejoin="round" d="M2.25 6.75c0 8.284 6.716 15 15 15h2.25a2.25 2.25 0 002.25-2.25v-1.372c0-.516-.351-.966-.852-1.091l-4.423-1.106c-.44-.11-.902.055-1.173.417l-.97 1.293c-2.89-1.46-5.366-3.936-6.82-6.82l1.293-.97c.363-.271.527-.734.417-1.173L6.963 3.102a1.125 1.125 0 00-1.091-.852H4.5A2.25 2.25 0 002.25 4.5v2.25z" /></svg>
                        0123-456-789
                    </div>
                    <div class="flex items-center gap-3">
                        <svg class="w-5 h-5 text-slate-400" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor"><path stroke-linecap="round" stroke-linejoin="round" d="M15 10.5a3 3 0 11-6 0 3 3 0 016 0z" /><path stroke-linecap="round" stroke-linejoin="round" d="M19.5 10.5c0 7.142-7.5 11.25-7.5 11.25S4.5 17.642 4.5 10.5a7.5 7.5 0 1115 0z" /></svg>
                        Hà Nội, Việt Nam
                    </div>
                </div>
            </div>
        </div>
    </section>

</main>

@endsection