<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>@yield('title', 'PC Builder')</title>
    @vite(['resources/css/app.css', 'resources/js/app.js'])
</head>
<body class="bg-white text-black font-sans">

    {{-- Navbar --}}
    <nav class="border-b border-gray-200 px-8 py-4 flex items-center justify-between">
        {{-- Logo --}}
        <a href="/" class="font-black text-lg tracking-tight border-2 border-black px-2 py-1">
            PC BUILDER
        </a>

        {{-- Menu --}}
        <div class="hidden md:flex items-center gap-8 text-sm font-medium">
            <a href="{{ route('builder.manual') }}" class="hover:underline">Xây dựng</a>
            <a href="{{ route('builder.recommend') }}" class="hover:underline">Gợi ý cấu hình</a>
            <a href="{{ route('forum.index') }}" class="hover:underline">Diễn đàn</a>
            <a href="{{ route('guides.index') }}" class="hover:underline">Hướng dẫn</a>
        </div>

        {{-- Auth --}}
        <div class="flex items-center gap-3">
            @auth
                <span class="text-sm text-gray-600">{{ auth()->user()->name }}</span>
                <form method="POST" action="{{ route('logout') }}" class="inline">
                    @csrf
                    <button type="submit" class="text-sm border border-black px-4 py-1.5 hover:bg-black hover:text-white transition">
                        Đăng xuất
                    </button>
                </form>
            @else
                <a href="{{ route('login') }}" class="text-sm border border-black px-4 py-1.5 hover:bg-black hover:text-white transition">
                    Đăng nhập
                </a>
                <a href="{{ route('register') }}" class="text-sm bg-black text-white px-4 py-1.5 hover:bg-gray-800 transition">
                    Đăng ký
                </a>
            @endauth
        </div>
    </nav>

    {{-- Nội dung trang --}}
    @yield('content')

    {{-- Footer --}}
    <footer class="border-t border-gray-200 mt-20">
        <div class="max-w-7xl mx-auto px-8 py-12 grid grid-cols-1 md:grid-cols-4 gap-8">
            {{-- Logo + contact --}}
            <div>
                <div class="font-black text-lg tracking-tight border-2 border-black px-2 py-1 inline-block mb-4">
                    PC BUILDER
                </div>
                <p class="text-sm text-gray-500 mt-2">✉ support@pcbuilder.vn</p>
                <p class="text-sm text-gray-500 mt-1">☎ 0123-456-789</p>
            </div>

            {{-- Thông tin --}}
            <div>
                <h4 class="font-bold mb-3 text-sm uppercase tracking-wide">Thông tin</h4>
                <ul class="space-y-2 text-sm text-gray-600">
                    <li><a href="#" class="hover:text-black">Giới thiệu</a></li>
                    <li><a href="#" class="hover:text-black">Hướng dẫn</a></li>
                    <li><a href="#" class="hover:text-black">Bảng giá</a></li>
                    <li><a href="#" class="hover:text-black">FAQ</a></li>
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
                    <li><a href="#" class="hover:text-black">CPU</a></li>
                    <li><a href="#" class="hover:text-black">Card đồ họa</a></li>
                    <li><a href="#" class="hover:text-black">Mainboard</a></li>
                    <li><a href="#" class="hover:text-black">RAM</a></li>
                    <li><a href="#" class="hover:text-black">Ổ cứng</a></li>
                </ul>
            </div>
        </div>

        <div class="border-t border-gray-200 px-8 py-4 flex items-center justify-between text-xs text-gray-400">
            <span>© 2025 PC Builder. All rights reserved.</span>
        </div>
    </footer>

</body>
</html>