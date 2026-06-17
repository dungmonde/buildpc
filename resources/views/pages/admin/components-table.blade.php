{{-- Table --}}
<div class="overflow-x-auto">
    <table class="w-full text-sm bg-white rounded-3xl overflow-hidden">
        <thead class="border-b border-slate-200 bg-slate-50">
            <tr>
                <th class="text-left py-3 px-3 text-xs text-slate-500 uppercase">Tên</th>
                <th class="text-left py-3 px-3 text-xs text-slate-500 uppercase">Danh mục</th>
                <th class="text-left py-3 px-3 text-xs text-slate-500 uppercase w-1/3">Thông số</th>
                <th class="text-right py-3 px-3 text-xs text-slate-500 uppercase">Giá</th>
                <th class="text-center py-3 px-3 text-xs text-slate-500 uppercase">Thao tác</th>
            </tr>
        </thead>

        <tbody id="admin-components-table">
            @forelse($components ?? [] as $c)
                <tr class="border-b border-slate-200 hover:bg-slate-50"
                    data-name="{{ strtolower($c->name) }}">

                    <td class="py-3 px-3 font-medium">
                        {{ $c->name }}
                        @if($c->componentType->type_name === 'GPU' && $c->gpu?->chipset)
                            <span class="text-indigo-600 font-normal">({{ $c->gpu->chipset }})</span>
                        @endif
                    </td>

                    <td class="py-3 px-3">
                        <span class="border border-slate-200 px-2 py-1 text-xs text-slate-700">
                            {{ $c->componentType->type_name }}
                        </span>
                    </td>

                    <td class="py-3 px-3 text-sm text-slate-600">
                        @if($c->componentType->type_name === 'CPU' && $c->cpu)
                            {{ $c->cpu->core_count }} Cores, {{ $c->cpu->core_clock }} GHz, {{ $c->cpu->socket }}
                        @elseif($c->componentType->type_name === 'GPU' && $c->gpu)
                            {{ $c->gpu->memory }}GB {{ $c->gpu->memory_type }}, {{ $c->gpu->core_clock }} MHz, {{ $c->gpu->length }}mm
                        @elseif($c->componentType->type_name === 'RAM' && $c->ram)
                            {{ $c->ram->capacity }}GB DDR{{ $c->ram->ddr_gen }}, {{ $c->ram->speed }} MHz
                        @elseif($c->componentType->type_name === 'MOTHERBOARD' && $c->motherboard)
                            {{ $c->motherboard->socket }}, {{ $c->motherboard->form_factor }}, DDR{{ $c->motherboard->ddr_gen }}
                        @elseif($c->componentType->type_name === 'STORAGE' && $c->storage)
                            {{ $c->storage->capacity }}GB {{ $c->storage->type }}, {{ $c->storage->form_factor }}
                        @elseif($c->componentType->type_name === 'PSU' && $c->psu)
                            {{ $c->psu->wattage }}W, {{ $c->psu->efficiency }}, {{ $c->psu->form_factor }}
                        @elseif($c->componentType->type_name === 'CASE' && $c->pcCase)
                            {{ $c->pcCase->type }}, {{ $c->pcCase->form_factor }}
                        @elseif($c->componentType->type_name === 'COOLER' && $c->cooler)
                            {{ $c->cooler->type === 'liquid' ? 'Tản nhiệt nước' : 'Tản nhiệt khí' }}
                            @if($c->cooler->radiator_size) - {{ $c->cooler->radiator_size }}mm @endif
                        @else
                            <span class="text-slate-400 italic">Không có thông số</span>
                        @endif
                    </td>

                    <td class="py-3 px-3 text-right font-semibold">
                        @php
                            $price = $c->base_price ?? $c->cheapestPrice->price ?? 0;
                        @endphp
                        {{ number_format($price, 0, ',', '.') }}₫
                    </td>

                    <td class="py-3 px-3">
                        <div class="flex justify-center gap-2">

                            <a href="{{ route('admin.components.edit', $c->id) }}"
                               data-edit-url="{{ route('admin.components.edit', $c->id) }}"
                               class="edit-btn btn border border-slate-200 px-3 py-1 text-xs text-slate-700 rounded-2xl hover:bg-slate-100 transition">
                                Sửa
                            </a>

                            <form method="POST"
                                  action="{{ route('admin.components.destroy', $c->id) }}"
                                  class="delete-form inline">
                                @csrf
                                @method('DELETE')
                                <input type="hidden" name="return_url" value="">
                                <input type="hidden" name="scroll_y" value="">
                                <button type="button"
                                        class="delete-btn btn border border-slate-200 px-3 py-1 text-xs text-red-600 rounded-2xl hover:bg-red-50 transition">
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
