<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Component;

class BuildController extends Controller
{
    public function index()
    {
        $categories = [
            'cpu'         => 'Bộ vi xử lý (CPU)',
            'mainboard'   => 'Bo mạch chủ (Mainboard)',
            'ram'         => 'Bộ nhớ RAM',
            'vga'         => 'Card đồ họa (GPU)',
            'storage'     => 'Ổ cứng (SSD/HDD)',
            'psu'         => 'Nguồn máy tính (PSU)',
            'case'        => 'Vỏ máy tính (Case)',
            'cooler'      => 'Tản nhiệt (Cooler)',
        ];

        $currentSlot = session()->get('build_slot', 1);
        
        // If this is a fresh session (no builds loaded yet), load from database
        if (auth()->check() && empty(session()->get('build_pc_slots'))) {
            $this->loadBuildsFromDatabase();
        }

        $slots = session()->get('build_pc_slots', []);

        // If the active slot has stored data, load it into the working session key
        if (isset($slots[$currentSlot]) && empty(session()->get('build_pc', []))) {
            session()->put('build_pc', $slots[$currentSlot]);
        }

        $selected = session()->get('build_pc', []);

        $totalPrice = 0;
        foreach ($selected as $item) {
            $totalPrice += $item['price'] ?? 0;
        }

        return view('pages.builder.manual', compact('categories', 'selected', 'totalPrice', 'currentSlot'));
    }

    private function loadBuildsFromDatabase()
    {
        if (!auth()->check()) {
            return;
        }

        $user = auth()->user();
        
        // Load user's builds from database, limit to 10
        $builds = \App\Models\PcBuild::where('user_id', $user->id)
            ->with('components')
            ->orderBy('id')
            ->limit(10)
            ->get();

        $slots = [];
        $slotBuildIds = [];

        foreach ($builds as $index => $build) {
            $slot = $index + 1; // Slots are 1-indexed

            // Convert database build to session format
            $buildData = [];
            
            // Get components from pivot table directly as fallback
            $componentIds = \Illuminate\Support\Facades\DB::table('build_components')
                ->where('build_id', $build->id)
                ->pluck('component_id')
                ->toArray();

            if (!empty($componentIds)) {
                $components = \App\Models\Component::whereIn('id', $componentIds)->get();
            } else {
                // Try eager-loaded relationship if pivot query returns nothing
                $components = $build->components;
            }
            
            foreach ($components as $component) {
                $category = $this->getComponentCategory($component->type_id);
                if ($category) {
                    $price = $component->base_price;
                    if ($price === null) {
                        $price = \Illuminate\Support\Facades\DB::table('component_prices')
                            ->where('component_id', $component->id)
                            ->orderBy('price')
                            ->value('price') ?? 0;
                    }

                    $buildData[$category] = [
                        'id'    => $component->id,
                        'name'  => $component->name,
                        'price' => $price,
                        'image' => null,
                    ];
                }
            }

            // Always add slot to session, preserving slot structure
            $slots[$slot] = $buildData;
            $slotBuildIds[$slot] = $build->id;
        }

        // Store in session
        if (!empty($slotBuildIds)) {
            session()->put('build_pc_slots', $slots);
            session()->put('build_slot_ids', $slotBuildIds);
        }
    }

    private function getComponentCategory($typeId): ?string
    {
        $typeMap = [
            1 => 'cpu',      // CPU
            2 => 'vga',      // Video Card
            3 => 'ram',      // Memory
            4 => 'storage',  // Internal Hard Drive
            5 => 'mainboard',// Motherboard
            6 => 'psu',      // Power Supply
            7 => 'cooler',   // CPU Cooler
            8 => 'case',     // Cases
        ];

        return $typeMap[$typeId] ?? null;
    }

    public function switchSlot($slot)
    {
        $slot = (int) $slot;
        if ($slot < 1 || $slot > 10) {
            abort(404);
        }

        $current = session()->get('build_slot', 1);

        // Save current working build into slots
        $slots = session()->get('build_pc_slots', []);
        $slots[$current] = session()->get('build_pc', []);
        session()->put('build_pc_slots', $slots);

        // Load requested slot into working build
        $new = $slots[$slot] ?? [];
        session()->put('build_pc', $new);

        // Set active slot
        session()->put('build_slot', $slot);

        return redirect()->route('build.index');
    }

    public function select($category)
    {
        $typeMap = [
            'cpu'         => 1,
            'vga'         => 2,
            'ram'         => 3,
            'storage'     => 4,
            'mainboard'   => 5,
            'psu'         => 6,
            'cooler'      => 7,
            'case'        => 8,
        ];

        $typeId = $typeMap[$category] ?? abort(404);

        $items = Component::where('type_id', $typeId)
            ->with('cheapestPrice')
            ->get();

        $categoryNames = [
            'cpu' => 'Vi xử lý',
            'mainboard' => 'Bo mạch chủ',
            'ram' => 'RAM',
            'vga' => 'Card đồ họa',
            'psu' => 'Nguồn',
            'storage' => 'Ổ cứng',
            'case' => 'Vỏ máy'
        ];

        $category_name = $categoryNames[$category] ?? 'Linh kiện';

        return view('pages.build_pc.build-select', compact('items', 'category', 'category_name'));
    }

    public function addComponent($category, $id)
    {
        $component = Component::with('cheapestPrice')->findOrFail($id);

        $build = session()->get('build_pc', []);

        $build[$category] = [
            'id'    => $component->id,
            'name'  => $component->name,
            'price' => $component->base_price ?? $component->cheapestPrice?->price ?? 0,
            'image' => $component->image_url ?? null,
        ];

        session()->put('build_pc', $build);

        return redirect()->route('build.index');
    }

    public function applyGuide(Request $request)
    {
        $cpuName = $request->query('cpu');
        $gpuName = $request->query('gpu');

        if (!$cpuName && !$gpuName) {
            return redirect()->route('build.index');
        }

        $build = session()->get('build_pc', []);

        if ($cpuName) {
            $build['cpu'] = $this->resolveGuideComponent($cpuName, 1);
        }

        if ($gpuName) {
            $build['vga'] = $this->resolveGuideComponent($gpuName, 2);
        }

        session()->put('build_pc', $build);

        return redirect()->route('build.index');
    }

    protected function resolveGuideComponent(string $name, int $typeId): array
    {
        $component = Component::where('type_id', $typeId)
            ->where('name', 'like', '%' . $name . '%')
            ->with('cheapestPrice')
            ->first();

        if (! $component) {
            $normalized = $this->normalizeGuideComponentName($name);

            if ($normalized) {
                $component = Component::where('type_id', $typeId)
                    ->where('name', 'like', '%' . $normalized . '%')
                    ->with('cheapestPrice')
                    ->first();
            }
        }

        if ($component) {
            return [
                'id'    => $component->id,
                'name'  => $component->name,
                'price' => $component->base_price ?? $component->cheapestPrice?->price ?? 0,
                'image' => $component->image_url ?? null,
            ];
        }

        return [
            'id'    => null,
            'name'  => $name,
            'price' => 0,
            'image' => null,
        ];
    }

    protected function normalizeGuideComponentName(string $name): ?string
    {
        $cleaned = preg_replace('/\b(F|KF|X|G|3D)\b/i', '', $name);
        $cleaned = trim(preg_replace('/\s+/', ' ', $cleaned));

        if ($cleaned === '') {
            return null;
        }

        return $cleaned;
    }

    public function removeComponent($category)
    {
        $build = session()->get('build_pc', []);

        if (isset($build[$category])) {
            unset($build[$category]);
            session()->put('build_pc', $build);
        }

        return redirect()->route('build.index');
    }

    public function save(Request $request)
    {
        $data = session('build_pc', []);
        $slot = session()->get('build_slot', 1);

        if (empty($data)) {
            return redirect()->route('build.index')
                ->with('error', 'Vui lòng chọn ít nhất một linh kiện.');
        }

        if (!auth()->check()) {
            return redirect()->route('login');
        }

        $user = auth()->user();

        // Check if user has reached the 10 build limit (only for new builds)
        $slotBuildIds = session()->get('build_slot_ids', []);
        $isNewBuild = !isset($slotBuildIds[$slot]);

        if ($isNewBuild) {
            $existingBuildCount = \App\Models\PcBuild::where('user_id', $user->id)->count();
            if ($existingBuildCount >= 10) {
                return redirect()->route('build.index')
                    ->with('error', 'Bạn đã đạt giới hạn 10 cấu hình. Vui lòng xóa một cấu hình cũ để tiếp tục.');
            }
        }

        // Determine if there's an existing build id for this slot in session
        $buildId = $slotBuildIds[$slot] ?? null;

        if ($buildId) {
            $pcBuild = \App\Models\PcBuild::find($buildId);
            if (! $pcBuild) {
                $buildId = null;
            }
        }

        if (empty($buildId)) {
            $pcBuild = new \App\Models\PcBuild();
            $pcBuild->user_id = $user->id;
        }

        $pcBuild->build_name = $request->input('build_name', "Cấu hình #{$slot}");
        $pcBuild->total_price = array_sum(array_map(fn($i) => $i['price'] ?? 0, $data));
        $pcBuild->save();

        // Sync components
        $componentIds = [];
        foreach ($data as $cat => $item) {
            if (!empty($item['id'])) {
                $componentIds[$item['id']] = ['quantity' => 1];
            }
        }

        $pcBuild->components()->sync($componentIds);

        // remember this build id for the slot in session
        $slotBuildIds[$slot] = $pcBuild->id;
        session()->put('build_slot_ids', $slotBuildIds);

        // also persist the slot's working data
        $slots = session()->get('build_pc_slots', []);
        $slots[$slot] = $data;
        session()->put('build_pc_slots', $slots);

        return redirect()->route('build.index')
            ->with('success', 'Lưu cấu hình thành công');
    }

    public function reset()
    {
        session()->forget('build_pc');
        return redirect()->route('build.index');
    }

    public function deleteBuild($slot)
    {
        $slot = (int) $slot;
        if ($slot < 1 || $slot > 10) {
            abort(404);
        }

        if (!auth()->check()) {
            return redirect()->route('login');
        }

        $slotBuildIds = session()->get('build_slot_ids', []);
        $buildId = $slotBuildIds[$slot] ?? null;

        if (!$buildId) {
            return redirect()->route('build.index')
                ->with('error', 'Không tìm thấy cấu hình này.');
        }

        $pcBuild = \App\Models\PcBuild::find($buildId);
        
        if (!$pcBuild || $pcBuild->user_id !== auth()->id()) {
            abort(403, 'Bạn không có quyền xóa cấu hình này.');
        }

        // Delete the build and its components
        $pcBuild->components()->detach();
        $pcBuild->delete();

        // Remove from session
        unset($slotBuildIds[$slot]);
        session()->put('build_slot_ids', $slotBuildIds);

        $slots = session()->get('build_pc_slots', []);
        unset($slots[$slot]);
        session()->put('build_pc_slots', $slots);

        // If we deleted the active slot, switch to slot 1
        if (session()->get('build_slot') == $slot) {
            session()->put('build_slot', 1);
            session()->forget('build_pc');
        }

        return redirect()->route('build.index')
            ->with('success', 'Xóa cấu hình thành công');
    }
}
