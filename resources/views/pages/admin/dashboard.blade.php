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
            @if(auth()->user()->avatar)
                <img src="{{ asset('storage/' . auth()->user()->avatar) }}" alt="Avatar" class="w-9 h-9 rounded-full object-cover ring-1 ring-slate-200">
            @else
                <div class="w-9 h-9 rounded-full bg-slate-200 flex items-center justify-center text-xs font-bold text-slate-700 ring-1 ring-slate-200">
                    {{ strtoupper(substr(auth()->user()->name, 0, 1)) }}
                </div>
            @endif
        </div>
    </div>

    <div class="max-w-7xl mx-auto px-8 py-8">

        {{-- Stats --}}
        <div class="grid grid-cols-2 md:grid-cols-3 gap-4 mb-8">

            <div class="card p-5 hover:shadow-sm transition">
                <p class="text-xs text-slate-500 uppercase">Tổng linh kiện</p>
                <h2 class="text-3xl font-black mt-2">{{ $stats['total_components'] ?? 0 }}</h2>
            </div>

            <div class="card p-5 hover:shadow-sm transition">
                <p class="text-xs text-slate-500 uppercase">Người dùng</p>
                <h2 class="text-3xl font-black mt-2">{{ $stats['total_users'] ?? 0 }}</h2>
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
                       class="flex-1 bg-white border border-slate-200 px-4 py-2 text-sm text-slate-900 focus:outline-none focus:border-slate-400 rounded-2xl">

                <select id="admin-category-filter"
                        class="bg-white border border-slate-200 px-3 py-2 text-sm text-slate-900 focus:outline-none focus:border-slate-400 rounded-2xl">
                    <option value="">Tất cả</option>
                    @foreach($stats['categories'] ?? [] as $cat)
                        <option value="{{ $cat['name'] }}" @if($selectedCategory === $cat['name']) selected @endif>
                            {{ $cat['name'] }}
                        </option>
                    @endforeach
                </select>
            </div>

            {{-- Table Container (loaded via AJAX) --}}
            <div id="components-table-container">
                @include('pages.admin.components-table')
            </div>

        </div>

    </div>
</div>

<script>
    const searchInput = document.getElementById('admin-component-search');
    const categoryFilter = document.getElementById('admin-category-filter');
    const tableContainer = document.getElementById('components-table-container');
    const tableRoute = '{{ route("admin.components.table") }}';

    function buildTableUrl(params) {
        const url = new URL(tableRoute, window.location.origin);
        params.forEach((value, key) => {
            if (value) {
                url.searchParams.set(key, value);
            }
        });

        return url;
    }

    // Load table via AJAX
    async function loadTable(url) {
        try {
            const response = await fetch(url, {
                headers: {
                    'X-Requested-With': 'XMLHttpRequest'
                }
            });
            const html = await response.text();
            tableContainer.innerHTML = html;
            // Reattach event listeners for new pagination links
            attachPaginationListeners();
        } catch (error) {
            console.error('Error loading table:', error);
        }
    }

    // Attach listeners to pagination links
    function attachPaginationListeners() {
        document.querySelectorAll('#components-table-container nav a').forEach(link => {
            link.addEventListener('click', function(e) {
                e.preventDefault();
                const url = new URL(this.href);
                const category = categoryFilter.value;
                if (category) {
                    url.searchParams.set('category', category);
                } else {
                    url.searchParams.delete('category');
                }

                const dashboardUrl = new URL(window.location);
                dashboardUrl.search = url.search;
                history.pushState(null, '', dashboardUrl.toString());

                const tableUrl = buildTableUrl(url.searchParams);
                loadTable(tableUrl.pathname + tableUrl.search);
            });
        });
    }

    // Client-side search
    searchInput?.addEventListener('input', function() {
        const q = this.value.toLowerCase();
        document.querySelectorAll('#admin-components-table tr[data-name]').forEach(row => {
            const nameMatch = row.dataset.name.includes(q);
            row.style.display = nameMatch ? '' : 'none';
        });
    });

    // Server-side category filter
    categoryFilter?.addEventListener('change', function() {
        const params = new URLSearchParams();
        if (this.value) {
            params.set('category', this.value);
        }

        const dashboardUrl = new URL(window.location);
        dashboardUrl.search = params.toString();
        history.pushState(null, '', dashboardUrl.toString());

        const tableUrl = buildTableUrl(params);
        loadTable(tableUrl.pathname + tableUrl.search);
    });

    // Attach initial pagination listeners
    attachPaginationListeners();
</script>
@endsection
