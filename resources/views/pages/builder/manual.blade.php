@extends('layouts.app')

@section('content')
<div class="max-w-5xl mx-auto">
        {{-- Messages --}}
        @if ($errors->any())
            <div class="mb-6 p-4 bg-red-50 border border-red-200 text-red-700 rounded-2xl">
                @foreach ($errors->all() as $error)
                    <p>{{ $error }}</p>
                @endforeach
            </div>
        @endif

        @if (session('success'))
            <div class="mb-6 p-4 bg-green-50 border border-green-200 text-green-700 rounded-2xl">
                {{ session('success') }}
            </div>
        @endif

        @if (session('error'))
            <div class="mb-6 p-4 bg-red-50 border border-red-200 text-red-700 rounded-2xl">
                {{ session('error') }}
            </div>
        @endif

        <div class="mb-6 flex flex-col md:flex-row md:items-center justify-between gap-4">
            <div>
                <h1 class="text-4xl font-bold text-slate-900">Xây dựng cấu hình PC</h1>
                <p class="text-slate-500 mt-2">Chọn từng linh kiện để hoàn thiện bộ máy của bạn.</p>
            </div>
            <div class="flex items-center gap-3">
                {{-- Build slots tabs (1..10) --}}
                @php $active = $currentSlot ?? session('build_slot', 1); @endphp
                <div class="flex items-center gap-1 bg-white border border-slate-200 rounded-full p-1 shadow-sm">
                    @for($i = 1; $i <= 10; $i++)
                        <a href="{{ route('build.slot', $i) }}" 
                           class="w-8 h-8 flex items-center justify-center rounded-full text-sm font-medium {{ $active == $i ? 'bg-slate-900 text-white shadow-sm' : 'text-slate-700 hover:bg-slate-50' }}">
                            {{ $i }}
                        </a>
                    @endfor
                </div>
            </div>
        </div>

        <div class="space-y-4">
            @foreach($categories as $key => $name)
            <div class="card p-7 flex items-center justify-between group hover:shadow-md transition">
                <div class="flex items-center gap-8">
                    @php
                        $hasImage = false;
                        $imageUrl = '';
                        if(isset($selected[$key])) {
                            $imageFolder = match($key) {
                                'vga' => 'gpu',
                                'mainboard' => 'motherboard',
                                default => $key,
                            };
                            $imagePath = public_path('images/components/' . $imageFolder . '/' . $selected[$key]['id'] . '.jpg');
                            if (file_exists($imagePath)) {
                                $hasImage = true;
                                $imageUrl = asset('images/components/' . $imageFolder . '/' . $selected[$key]['id'] . '.jpg');
                            }
                        }
                    @endphp

                    @if(isset($selected[$key]) && $hasImage)
                        <div class="w-16 h-16 shrink-0 bg-white border border-slate-200 rounded-2xl flex items-center justify-center p-2 shadow-sm">
                            <img src="{{ $imageUrl }}" alt="{{ $selected[$key]['name'] }}" class="max-w-full max-h-full object-contain rounded-lg">
                        </div>
                    @else
                        <span class="text-5xl font-black text-slate-200 group-hover:text-slate-300 transition w-16 text-center">
                            0{{ $loop->iteration }}
                        </span>
                    @endif
                    
                    <div>
                        <h3 class="text-xs font-bold text-slate-500 uppercase tracking-widest">{{ $name }}</h3>
                        @if(isset($selected[$key]))
                            <p class="text-lg font-bold text-slate-900">{{ $selected[$key]['name'] }}</p>
                            <p class="text-primary-600 font-semibold">{{ number_format($selected[$key]['price']) }} ₫</p>
                        @else
                            <p class="text-slate-400">Chưa chọn</p>
                        @endif
                    </div>
                </div>

                <div class="flex items-center gap-4">
                    @if(isset($selected[$key]))
                        <a href="{{ route('build.remove', ['category' => $key]) }}" 
                           class="text-red-400 hover:text-red-500 p-2">
                            <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24" stroke-width="2">
                                <path stroke-linecap="round" stroke-linejoin="round" d="M6 18L18 6M6 6l12 12" />
                            </svg>
                        </a>
                    @endif
                    
                    <a href="{{ route('build.select', ['category' => $key]) }}" 
                       onclick="openComponentModal(event, '{{ $key }}', '{{ $name }}')"
                       class="btn {{ isset($selected[$key]) ? 'btn-primary' : 'bg-slate-100 hover:bg-slate-200 text-slate-700' }} px-8 py-3">
                        {{ isset($selected[$key]) ? 'Thay đổi' : '+ Chọn' }}
                    </a>
                </div>
            </div>
            @endforeach
        </div>

        <div class="sticky bottom-8 mt-12 bg-white border border-slate-200 p-6 rounded-2xl flex justify-between items-center shadow-lg">
            <div>
                <p class="text-slate-500 text-xs uppercase tracking-widest">Tổng chi phí</p>
                <h2 class="text-3xl font-bold text-slate-900">{{ number_format($totalPrice) }} ₫</h2>
            </div>

            <div class="flex items-center gap-4">
                <a href="{{ route('build.reset') }}" class="btn border border-slate-200 text-slate-700 px-4 py-2 hover:bg-slate-100 transition">
                    Làm mới
                </a>

                <form method="POST" action="{{ route('build.save') }}" class="flex items-center gap-3">
                    @csrf

                    @php
                        $activeSlot = $currentSlot ?? session('build_slot', 1);
                        $slotIds = session('build_slot_ids', []);
                        $existingName = isset($slotIds[$activeSlot]) 
                            ? \App\Models\PcBuild::where('id', $slotIds[$activeSlot])->value('build_name') 
                            : 'Cấu hình #' . $activeSlot;
                    @endphp
                    <input type="text" name="build_name" value="{{ $existingName }}" class="bg-slate-50 border border-slate-200 px-4 py-3 rounded-xl text-sm font-medium text-slate-700 outline-none focus:bg-white focus:border-slate-400 transition w-48 md:w-64" placeholder="Tên cấu hình..." required>

                    <button type="submit" class="btn btn-primary px-8 py-3">
                        Lưu cấu hình
                    </button>
                </form>
            </div>
        </div>
    </div>
</div>

{{-- Component Selector Modal --}}
<div id="component-modal" class="fixed inset-0 bg-slate-900/50 backdrop-blur-sm z-50 hidden flex items-center justify-center p-4">
    <div class="bg-white rounded-3xl w-full max-w-4xl max-h-[85vh] flex flex-col shadow-2xl overflow-hidden transform scale-95 opacity-0 transition-all duration-300" id="component-modal-content">
        {{-- Modal Header --}}
        <div class="px-6 py-4 border-b border-slate-100 flex justify-between items-center bg-slate-50 shrink-0">
            <h3 class="text-xl font-bold text-slate-900" id="modal-title">Chọn linh kiện</h3>
            <button onclick="closeComponentModal()" class="text-slate-400 hover:text-slate-600 transition p-1 rounded-lg hover:bg-slate-100">
                <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12"></path>
                </svg>
            </button>
        </div>
        {{-- Modal Body --}}
        <div class="p-6 overflow-y-auto flex-1 bg-slate-50" id="modal-body">
            <div class="flex justify-center py-12">
                <div class="animate-spin rounded-full h-8 w-8 border-b-2 border-slate-900"></div>
            </div>
        </div>
    </div>
</div>

<script>
function openComponentModal(event, category, categoryName) {
    event.preventDefault();
    
    const modal = document.getElementById('component-modal');
    const content = document.getElementById('component-modal-content');
    const title = document.getElementById('modal-title');
    const body = document.getElementById('modal-body');
    
    title.textContent = 'Chọn ' + categoryName;
    
    modal.classList.remove('hidden');
    setTimeout(() => {
        content.classList.remove('scale-95', 'opacity-0');
        content.classList.add('scale-100', 'opacity-100');
    }, 10);
    
    body.innerHTML = `
        <div class="flex justify-center py-12">
            <div class="animate-spin rounded-full h-8 w-8 border-b-2 border-slate-900"></div>
        </div>
    `;
    
    fetch(`/build-pc/select/${category}?ajax=1`)
        .then(res => res.text())
        .then(html => {
            body.innerHTML = html;
        })
        .catch(err => {
            body.innerHTML = `<p class="text-red-500 text-center py-8">Không thể tải danh sách linh kiện. Vui lòng thử lại.</p>`;
        });
}

function closeComponentModal() {
    const modal = document.getElementById('component-modal');
    const content = document.getElementById('component-modal-content');
    
    content.classList.remove('scale-100', 'opacity-100');
    content.classList.add('scale-95', 'opacity-0');
    
    setTimeout(() => {
        modal.classList.add('hidden');
    }, 300);
}

document.getElementById('component-modal').addEventListener('click', function(e) {
    if (e.target === this) {
        closeComponentModal();
    }
});
</script>
@endsection
