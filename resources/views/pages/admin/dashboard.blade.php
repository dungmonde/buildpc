@extends('layouts.app')

@section('title', 'Dashboard Admin')

@section('content')
<div class="min-h-screen bg-slate-50 text-slate-900">

    {{-- Header (no border) --}}
    <div class="flex items-center justify-between py-8 px-8 bg-white">
        <div>
            <p class="text-xs font-semibold tracking-widest text-gray-500 uppercase mb-1">Dashboard</p>
            <h1 class="text-2xl font-black uppercase">Quản trị</h1>
        </div>
        <div class="flex items-center gap-3">
            <div class="text-right">
                <p class="text-sm font-semibold">{{ auth()->user()->name }}</p>
                <p class="text-xs text-slate-500">{{ auth()->user()->email }}</p>
            </div>
            <div class="w-9 h-9 rounded-full bg-slate-200 flex items-center justify-center text-xs font-bold text-slate-700">
                {{ strtoupper(substr(auth()->user()->name, 0, 1)) }}
            </div>
        </div>
    </div>

    <div class="max-w-7xl mx-auto px-8 py-8">

        {{-- Stats --}}
        <div class="grid grid-cols-2 md:grid-cols-4 gap-4 mb-8">

            <div class="card p-5 hover:shadow-sm transition">
                <p class="text-xs text-slate-500 uppercase">Tổng linh kiện</p>
                <h2 class="text-3xl font-black mt-2">{{ $stats['total_components'] ?? 0 }}</h2>
            </div>

            <div class="card p-5 hover:shadow-sm transition">
                <p class="text-xs text-slate-500 uppercase">Người dùng</p>
                <h2 class="text-3xl font-black mt-2">{{ $stats['total_users'] ?? 0 }}</h2>
            </div>

            <div class="card p-5 hover:shadow-sm transition">
                <p class="text-xs text-slate-500 uppercase">Build</p>
                <h2 class="text-3xl font-black mt-2">{{ $stats['total_builds'] ?? 0 }}</h2>
            </div>

            <div class="card p-5 hover:shadow-sm transition">
                <p class="text-xs text-slate-500 uppercase">Bài viết</p>
                <h2 class="text-3xl font-black mt-2">{{ $stats['total_posts'] ?? 0 }}</h2>
            </div>

        </div>

        {{-- Categories --}}
        <div class="card p-6 mb-8">
            <h2 class="text-lg font-black uppercase mb-6">Phân loại linh kiện</h2>

            <div class="grid grid-cols-2 md:grid-cols-4 gap-4">
                @foreach($stats['categories'] ?? [] as $cat)
                    <div class="card p-4 text-center hover:shadow-sm transition">
                        <div class="text-xl mb-2">{{ $cat['icon'] }}</div>
                        <p class="text-sm font-semibold">{{ $cat['name'] }}</p>
                        <p class="text-xl font-bold mt-1">{{ $cat['count'] }}</p>
                    </div>
                @endforeach
            </div>
        </div>

        {{-- Component Management --}}
        <div class="card p-6">

            <div class="flex items-center justify-between mb-5">
                <h2 class="text-lg font-black uppercase">Quản lý linh kiện</h2>

                <a href="{{ route('admin.components.create') }}"
                   class="bg-slate-900 text-white px-4 py-2 text-sm font-semibold rounded-full hover:bg-slate-800 transition">
                    + Thêm linh kiện
                </a>
            </div>

            {{-- Search --}}
            <div class="flex gap-3 mb-4">
                <input type="text"
                       id="admin-component-search"
                       placeholder="Tìm kiếm..."
                       class="flex-1 bg-white border border-slate-200 px-4 py-2 text-sm text-slate-900 focus:outline-none focus:border-slate-400">

                <select id="admin-category-filter"
                        class="bg-white border border-slate-200 px-3 py-2 text-sm text-slate-900 focus:outline-none focus:border-slate-400">
                    <option value="">Tất cả</option>
                    @foreach($stats['categories'] ?? [] as $cat)
                        <option value="{{ strtolower($cat['name']) }}">{{ $cat['name'] }}</option>
                    @endforeach
                </select>
            </div>

            {{-- Table --}}
            <div class="overflow-x-auto">
                <table class="w-full text-sm bg-white rounded-3xl overflow-hidden">
                    <thead class="border-b border-slate-200 bg-slate-50">
                        <tr>
                            <th class="text-left py-3 px-3 text-xs text-slate-500 uppercase">Tên</th>
                            <th class="text-left py-3 px-3 text-xs text-slate-500 uppercase">Danh mục</th>
                            <th class="text-right py-3 px-3 text-xs text-slate-500 uppercase">Giá</th>
                            <th class="text-center py-3 px-3 text-xs text-slate-500 uppercase">Thao tác</th>
                        </tr>
                    </thead>

                    <tbody id="admin-components-table">
                        @forelse($components ?? [] as $c)
                            <tr class="border-b border-slate-200 hover:bg-slate-50"
                                data-name="{{ strtolower($c->name) }}"
                                data-category="{{ strtolower($c->category) }}">

                                <td class="py-3 px-3 font-medium">{{ $c->name }}</td>

                                <td class="py-3 px-3">
                                    <span class="border border-slate-200 px-2 py-1 text-xs text-slate-700">
                                        {{ $c->category }}
                                    </span>
                                </td>

                                <td class="py-3 px-3 text-right font-semibold">
                                    {{ number_format($c->price, 0, ',', '.') }}₫
                                </td>

                                <td class="py-3 px-3">
                                    <div class="flex justify-center gap-2">

                                        <a href="{{ route('admin.components.edit', $c->id) }}"
                                           class="border border-slate-200 px-3 py-1 text-xs text-slate-700 hover:bg-slate-100 transition">
                                            Sửa
                                        </a>

                                        <a href="{{ route('admin.components.price', $c->id) }}"
                                           class="border border-slate-200 px-3 py-1 text-xs text-slate-700 hover:bg-slate-100 transition">
                                            Giá
                                        </a>

                                        <form method="POST"
                                              action="{{ route('admin.components.destroy', $c->id) }}"
                                              onsubmit="return confirm('Xoá?')">
                                            @csrf
                                            @method('DELETE')
                                            <button class="border border-slate-200 px-3 py-1 text-xs text-slate-700 hover:bg-slate-100 transition">
                                                Xoá
                                            </button>
                                        </form>

                                    </div>
                                </td>

                            </tr>
                        @empty
                            <tr>
                                <td colspan="4" class="py-10 text-center text-slate-500">
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