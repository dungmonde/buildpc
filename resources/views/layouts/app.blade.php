<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>@yield('title', 'PC Builder')</title>
    @vite(['resources/css/app.css', 'resources/js/app.js'])
    <style>
        /* Bật tính năng cuộn mượt cho toàn bộ trang web */
        html {
            scroll-behavior: smooth;
        }
    </style>
</head>

<body class="bg-white text-slate-900 font-sans antialiased">

    {{-- Navbar --}}
    <nav class="border-b border-gray-200">
        <div class="max-w-7xl mx-auto px-6 py-4 flex flex-wrap items-center justify-between gap-4">
        {{-- Logo --}}
        <a href="/" class="inline-flex items-center">
            <img src="{{ asset('images/logo.jpg') }}" alt="PC Builder" class="h-10 w-auto object-contain">
        </a>

        {{-- Menu --}}
        <div class="hidden md:flex items-center gap-8 text-sm font-medium">
            <a href="{{ route('home') }}" class="hover:underline">Trang chủ</a>
            <a href="{{ route('builder.manual') }}" class="hover:underline">Xây dựng</a>
            <a href="{{ route('builder.recommend') }}" class="hover:underline">Gợi ý cấu hình</a>
            <a href="{{ route('forum.index') }}" class="hover:underline">Diễn đàn</a>
            <a href="{{ route('guides.index') }}" class="hover:underline">Hướng dẫn</a>
            @auth
                @if(auth()->user()->role === 'admin')
                    <a href="{{ route('dashboard') }}" class="text-sm font-semibold text-red-400 hover:underline">
                        Admin
                    </a>
                @else
                    <a href="{{ route('dashboard') }}" class="text-sm font-semibold hover:underline">
                        Dashboard
                    </a>
                @endif
            @endauth
        </div>

        {{-- Auth --}}
        <div class="flex items-center gap-3">
            @auth
                @php
                    $avatarUrl = null;
                    foreach (['jpg','jpeg','png','webp'] as $ext) {
                        $path = public_path("images/user/" . auth()->id() . ".{$ext}");
                        if (file_exists($path)) {
                            $avatarUrl = asset("images/user/" . auth()->id() . ".{$ext}");
                            break;
                        }
                    }
                @endphp
                <a href="{{ route('profile.edit') }}" class="inline-flex items-center gap-2 rounded-full border border-slate-200 px-3 py-1.5 hover:bg-slate-100 transition text-sm text-slate-700">
                    @if($avatarUrl)
                        <img src="{{ $avatarUrl }}" alt="Avatar" class="h-8 w-8 rounded-full object-cover">
                    @else
                        <span class="inline-flex h-8 w-8 items-center justify-center rounded-full bg-slate-100 text-slate-700 font-semibold">{{ strtoupper(substr(auth()->user()->name, 0, 1)) }}</span>
                    @endif
                    <span>{{ auth()->user()->name }}</span>
                </a>
                <form method="POST" action="{{ route('logout') }}" class="inline">
                    @csrf
                    <button type="submit" class="text-sm border border-black px-4 py-1.5 rounded-full hover:bg-black hover:text-white transition">
                        Đăng xuất
                    </button>
                </form>
            @else
                <a href="{{ route('login') }}" class="text-sm border border-black px-4 py-1.5 rounded-full hover:bg-black hover:text-white transition">
                    Đăng nhập
                </a>
                <a href="{{ route('register') }}" class="text-sm bg-black text-white px-4 py-1.5 rounded-full hover:bg-gray-800 transition">
                    Đăng ký
                </a>
            @endauth
        </div>
    </nav>

    {{-- Nội dung trang --}}
    <main class="min-h-screen">
        <div class="max-w-7xl mx-auto px-6 py-10">
            @yield('content')
        </div>
    </main>

    @if(session('success'))
        <div id="flash-message" class="fixed bottom-6 right-6 z-50 max-w-xs rounded-2xl border border-slate-200 bg-white px-5 py-4 shadow-2xl shadow-slate-900/5 text-sm text-slate-900 ring-1 ring-slate-200 transition duration-300">
            <div class="flex items-start gap-3">
                <span class="mt-0.5 inline-flex h-8 w-8 items-center justify-center rounded-full bg-emerald-100 text-emerald-700">✓</span>
                <div class="flex-1">
                    <p class="font-semibold">Thành công</p>
                    <p class="text-slate-600">{{ session('success') }}</p>
                </div>
                <button type="button" onclick="document.getElementById('flash-message').remove()" class="text-slate-400 hover:text-slate-600 transition">✕</button>
            </div>
        </div>
        <script>
            setTimeout(function () {
                var msg = document.getElementById('flash-message');
                if (msg) msg.remove();
            }, 3500);
        </script>
    @endif

    {{-- Footer --}}
    <footer class="border-t border-gray-200 mt-20">
        <div class="max-w-7xl mx-auto px-6 py-12 grid grid-cols-1 md:grid-cols-5 gap-8">
            {{-- Logo + contact --}}
            <div>
                <a href="/" class="inline-flex items-center mb-4">
                    <img src="{{ asset('images/logo.jpg') }}" alt="PC Builder" class="h-10 w-auto object-contain">
                </a>
                <p class="text-sm text-gray-500 mt-2">✉ support@pcbuilder.vn</p>
                <p class="text-sm text-gray-500 mt-1">☎ 0123-456-789</p>
            </div>

            {{-- Thông tin --}}
            <div>
                <h4 class="font-bold mb-3 text-sm uppercase tracking-wide">Thông tin</h4>
                <ul class="space-y-2 text-sm text-gray-600">
                    <li><a href="#" class="hover:text-black">Giới thiệu</a></li>
                    <li><a href="http://127.0.0.1:8000/huong-dan" class="hover:text-black">Hướng dẫn</a></li>
                    <li><a href="#faq-section" class="hover:text-black">FAQ</a></li>
                </ul>
            </div>

            {{-- Dịch vụ --}}
            <div>
                <h4 class="font-bold mb-3 text-sm uppercase tracking-wide">Dịch vụ</h4>
                <ul class="space-y-2 text-sm text-gray-600">
                    <li><a href="{{ route('builder.recommend') }}" class="hover:text-black">Gợi ý cấu hình</a></li>
                    <li><a href="{{ route('builder.manual') }}" class="hover:text-black">Tự xây dựng PC</a></li>
                    <li><a href="{{ route('forum.index') }}" class="hover:text-black">Diễn đàn</a></li>
                </ul>
            </div>

            {{-- Linh kiện --}}
            <div>
                <h4 class="font-bold mb-3 text-sm uppercase tracking-wide">Linh kiện</h4>
                <ul class="space-y-2 text-sm text-gray-600">
                    <li><a href="http://127.0.0.1:8000/linh-kien/cpu" class="hover:text-black">CPU</a></li>
                    <li><a href="http://127.0.0.1:8000/linh-kien/gpu" class="hover:text-black">Card đồ họa</a></li>
                    <li><a href="http://127.0.0.1:8000/linh-kien/motherboard" class="hover:text-black">Mainboard</a></li>
                    <li><a href="http://127.0.0.1:8000/linh-kien/ram" class="hover:text-black">RAM</a></li>
                    <li><a href="http://127.0.0.1:8000/linh-kien/storage" class="hover:text-black">Ổ cứng</a></li>
                </ul>
            </div>

            {{-- Trụ sở chính --}}
            <div class="md:col-span-1">
                <h4 class="font-bold mb-3 text-sm uppercase tracking-wide">Trụ sở chính</h4>
                <p class="text-sm text-gray-600 mb-3 leading-relaxed">120 P. Yên Lãng, Đống Đa, Hà Nội</p>
                <div class="w-full h-32 overflow-hidden rounded-lg border border-gray-200">
                    <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d2289.0491584221722!2d105.81226417245436!3d21.010485380634233!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3135ac9d65911ef1%3A0x6a4df45cca423e18!2zMTIwIFAuWcOqbiBMw6NuZywgxJDhu5FuZyDEkGEsIEjDoCBO4buZaSAxMDAwMDAsIFZp4buHdCBOYW0!5e1!3m2!1svi!2s!4v1781520481616!5m2!1svi!2s" width="100%" height="100%" style="border:0;" allowfullscreen="" loading="lazy" referrerpolicy="no-referrer-when-downgrade"></iframe>
                </div>
            </div>
        </div>

        <div class="border-t border-gray-200 px-8 py-4 flex items-center justify-between text-xs text-gray-400">
            <span>© 2025 PC Builder. All rights reserved.</span>
        </div>
    </footer>

</body>
</html>