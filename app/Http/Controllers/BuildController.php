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

        $selected = session()->get('build_pc', []);

        $totalPrice = 0;
        foreach ($selected as $item) {
            $totalPrice += $item['price'] ?? 0;
        }

        return view('pages.builder.manual', compact('categories', 'selected', 'totalPrice'));
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

    public function removeComponent($category)
    {
        $build = session()->get('build_pc', []);

        if (isset($build[$category])) {
            unset($build[$category]);
            session()->put('build_pc', $build);
        }

        return redirect()->route('build.index');
    }

    public function reset()
    {
        session()->forget('build_pc');
        return redirect()->route('build.index');
    }
}