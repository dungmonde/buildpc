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
        ];

        $currentSlot = session()->get('build_slot', 1);
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
            'price' => $component->cheapestPrice?->price ?? 0,
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
                'price' => $component->cheapestPrice?->price ?? 0,
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
            return redirect()->route('build.index');
        }

        if (!auth()->check()) {
            return redirect()->route('login');
        }

        $user = auth()->user();

        // Determine if there's an existing build id for this slot in session
        $slotBuildIds = session()->get('build_slot_ids', []);
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
            ->with('success', 'Lưu thành công');
    }

    public function reset()
    {
        session()->forget('build_pc');
        return redirect()->route('build.index');
    }
}