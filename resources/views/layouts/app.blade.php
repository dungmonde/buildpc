<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>@yield('title', 'PC Builder')</title>
    @vite(['resources/css/app.css', 'resources/js/app.js'])
</head>
<body class="bg-gray-950 text-white">

    {{-- Navbar --}}
    <nav class="bg-gray-900 px-6 py-4">
        <a href="/" class="text-xl font-bold">PC Builder</a>
    </nav>

    {{-- Nội dung trang con nhét vào đây --}}
    <main class="container mx-auto px-4 py-8">
        @yield('content')
    </main>

    {{-- Footer --}}
    <footer class="bg-gray-900 text-center py-4 text-gray-400">
        © 2025 PC Builder
    </footer>

</body>
</html>