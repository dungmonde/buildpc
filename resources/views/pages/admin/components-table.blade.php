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
                    data-name="{{ strtolower($c->name) }}">

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
                               class="btn border border-slate-200 px-3 py-1 text-xs text-slate-700 rounded-2xl hover:bg-slate-100 transition">
                                Sửa
                            </a>

                            <form method="POST"
                                  action="{{ route('admin.components.destroy', $c->id) }}"
                                  onsubmit="return confirm('Xoá?')" class="inline">
                                @csrf
                                @method('DELETE')
                                <button class="btn border border-slate-200 px-3 py-1 text-xs text-slate-700 rounded-2xl hover:bg-slate-100 transition">
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

{{-- Pagination --}}
<div class="mt-4">
    {{ $components->links() }}
</div>
