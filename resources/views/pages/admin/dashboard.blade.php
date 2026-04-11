@extends('layouts.app')

@section('title', 'Dashboard Admin')

@section('content')
<div class="min-h-screen bg-gray-950 text-white">

    {{-- Header --}}
    <div class="border-b border-gray-800 px-8 py-5 flex items-center justify-between">
        <div>
            <p class="text-xs font-semibold tracking-widest text-gray-500 uppercase mb-1">Dashboard</p>
            <h1 class="text-2xl font-black uppercase">Quản trị</h1>
        </div>
        <div class="flex items-center gap-3">
            <div class="text-right">
                <p class="text-sm font-semibold">{{ auth()->user()->name }}</p>
                <p class="text-xs text-gray-400">{{ auth()->user()->email }}</p>
            </div>
            <div class="w-9 h-9 rounded-full bg-gray-800 flex items-center justify-center text-xs font-bold">
                {{ strtoupper(substr(auth()->user()->name, 0, 1)) }}
            </div>
        </div>
    </div>

    <div class="max-w-7xl mx-auto px-8 py-8">

        {{-- Stats --}}
        <div class="grid grid-cols-2 md:grid-cols-4 gap-4 mb-8">

            <div class="border border-gray-800 p-5 hover:bg-gray-900 transition">
                <p class="text-xs text-gray-500 uppercase">Tổng linh kiện</p>
                <h2 class="text-3xl font-black mt-2">{{ $stats['total_components'] ?? 0 }}</h2>
            </div>

            <div class="border border-gray-800 p-5 hover:bg-gray-900 transition">
                <p class="text-xs text-gray-500 uppercase">Người dùng</p>
                <h2 class="text-3xl font-black mt-2">{{ $stats['total_users'] ?? 0 }}</h2>
            </div>

            <div class="border border-gray-800 p-5 hover:bg-gray-900 transition">
                <p class="text-xs text-gray-500 uppercase">Build</p>
                <h2 class="text-3xl font-black mt-2">{{ $stats['total_builds'] ?? 0 }}</h2>
            </div>

            <div class="border border-gray-800 p-5 hover:bg-gray-900 transition">
                <p class="text-xs text-gray-500 uppercase">Bài viết</p>
                <h2 class="text-3xl font-black mt-2">{{ $stats['total_posts'] ?? 0 }}</h2>
            </div>

        </div>

        {{-- Categories --}}
        <div class="border border-gray-800 p-6 mb-8">
            <h2 class="text-lg font-black uppercase mb-6">Phân loại linh kiện</h2>

            <div class="grid grid-cols-2 md:grid-cols-4 gap-4">
                @foreach($stats['categories'] ?? [] as $cat)
                    <div class="border border-gray-800 p-4 text-center hover:bg-gray-900 transition">
                        <div class="text-xl mb-2">{{ $cat['icon'] }}</div>
                        <p class="text-sm font-semibold">{{ $cat['name'] }}</p>
                        <p class="text-xl font-bold mt-1">{{ $cat['count'] }}</p>
                    </div>
                @endforeach
            </div>
        </div>

        {{-- Component Management --}}
        <div class="border border-gray-800 p-6">

            <div class="flex items-center justify-between mb-5">
                <h2 class="text-lg font-black uppercase">Quản lý linh kiện</h2>

                <a href="{{ route('admin.components.create') }}"
                   class="bg-white text-black px-4 py-2 text-sm font-semibold hover:bg-gray-200 transition">
                    + Thêm linh kiện
                </a>
            </div>

            {{-- Search --}}
            <div class="flex gap-3 mb-4">
                <input type="text"
                       id="admin-component-search"
                       placeholder="Tìm kiếm..."
                       class="flex-1 bg-transparent border border-gray-700 px-4 py-2 text-sm focus:outline-none focus:border-white">

                <select id="admin-category-filter"
                        class="bg-transparent border border-gray-700 px-3 py-2 text-sm focus:outline-none focus:border-white">
                    <option value="">Tất cả</option>
                    @foreach($stats['categories'] ?? [] as $cat)
                        <option value="{{ strtolower($cat['name']) }}">{{ $cat['name'] }}</option>
                    @endforeach
                </select>
            </div>

            {{-- Table --}}
            <div class="overflow-x-auto">
                <table class="w-full text-sm">
                    <thead class="border-b border-gray-800">
                        <tr>
                            <th class="text-left py-3 px-3 text-xs text-gray-500 uppercase">Tên</th>
                            <th class="text-left py-3 px-3 text-xs text-gray-500 uppercase">Danh mục</th>
                            <th class="text-right py-3 px-3 text-xs text-gray-500 uppercase">Giá</th>
                            <th class="text-center py-3 px-3 text-xs text-gray-500 uppercase">Thao tác</th>
                        </tr>
                    </thead>

                    <tbody id="admin-components-table">
                        @forelse($components ?? [] as $c)
                            <tr class="border-b border-gray-800 hover:bg-gray-900"
                                data-name="{{ strtolower($c->name) }}"
                                data-category="{{ strtolower($c->category) }}">

                                <td class="py-3 px-3 font-medium">{{ $c->name }}</td>

                                <td class="py-3 px-3">
                                    <span class="border border-gray-700 px-2 py-1 text-xs">
                                        {{ $c->category }}
                                    </span>
                                </td>

                                <td class="py-3 px-3 text-right font-semibold">
                                    {{ number_format($c->price, 0, ',', '.') }}₫
                                </td>

                                <td class="py-3 px-3">
                                    <div class="flex justify-center gap-2">

                                        <a href="{{ route('admin.components.edit', $c->id) }}"
                                           class="border border-gray-600 px-3 py-1 text-xs hover:bg-white hover:text-black transition">
                                            Sửa
                                        </a>

                                        <a href="{{ route('admin.components.price', $c->id) }}"
                                           class="border border-gray-600 px-3 py-1 text-xs hover:bg-white hover:text-black transition">
                                            Giá
                                        </a>

                                        <form method="POST"
                                              action="{{ route('admin.components.destroy', $c->id) }}"
                                              onsubmit="return confirm('Xoá?')">
                                            @csrf
                                            @method('DELETE')
                                            <button class="border border-gray-600 px-3 py-1 text-xs hover:bg-white hover:text-black transition">
                                                Xoá
                                            </button>
                                        </form>

                                    </div>
                                </td>

                            </tr>
                        @empty
                            <tr>
                                <td colspan="4" class="py-10 text-center text-gray-500">
                                    Chưa có dữ liệu
                                </td>
                            </tr>
                        @endforelse
                    </tbody>
                </table>
            </div>

            @if(isset($components) && $components->hasPages())
                <div class="mt-4">{{ $components->links() }}</div>
            @endif

        </div>

    </div>
</div>

<script>
    const searchInput = document.getElementById('admin-component-search');
    const categoryFilter = document.getElementById('admin-category-filter');
    const rows = document.querySelectorAll('#admin-components-table tr[data-name]');

    function filterTable() {
        const q = searchInput.value.toLowerCase();
        const cat = categoryFilter.value.toLowerCase();

        rows.forEach(row => {
            const nameMatch = row.dataset.name.includes(q);
            const catMatch = !cat || row.dataset.category.includes(cat);
            row.style.display = nameMatch && catMatch ? '' : 'none';
        });
    }

    searchInput?.addEventListener('input', filterTable);
    categoryFilter?.addEventListener('change', filterTable);
</script>
@endsection