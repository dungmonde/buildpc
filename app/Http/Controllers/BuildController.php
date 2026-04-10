<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Component;

class BuildController extends Controller
{
    public function index() {
    // 1. Định nghĩa danh sách các mục cần chọn
    $categories = [
        'cpu'         => 'Bộ vi xử lý (CPU)',
        'mainboard'   => 'Bo mạch chủ (Mainboard)',
        'ram'         => 'Bộ nhớ RAM',
        'vga'         => 'Card đồ họa (GPU)',
        'storage'     => 'Ổ cứng (SSD/HDD)',
        'psu'         => 'Nguồn máy tính (PSU)',
        'case'        => 'Vỏ máy tính (Case)',
    ];

    // 2. Lấy linh kiện đã chọn từ Session
    $selected = session()->get('build_pc', []);

    // 3. Tính tổng tiền
    $totalPrice = 0;
    foreach ($selected as $item) {
        $totalPrice += $item['price'] ?? 0;
    }

    // 4. Trả về view manual
    return view('pages.builder.manual', compact('categories', 'selected', 'totalPrice'));
    }

    // 2. Trang hiển thị danh sách sản phẩm cụ thể của một loại (Ví dụ: Danh sách các CPU)
    public function select($category)
    {
    // Map từ tên category sang type_id giống trong web.php của bạn
    $typeMap = [
        'cpu'         => 1,
        'vga'         => 2, // GPU
        'ram'         => 3,
        'storage'     => 4,
        'mainboard'   => 5, // Motherboard
        'psu'         => 6,
        'cooler'      => 7,
        'case'        => 8,
    ];

    $typeId = $typeMap[$category] ?? abort(404);

    // Lấy linh kiện và kèm theo giá thấp nhất (giống logic bạn dùng ở web.php)
    $items = \App\Models\Component::where('type_id', $typeId)
                ->with(['cheapestPrice'])
                ->get();

    $categoryNames = [
        'cpu' => 'Vi xử lý', 'mainboard' => 'Bo mạch chủ', 'ram' => 'RAM',
        'vga' => 'Card đồ họa', 'psu' => 'Nguồn', 'storage' => 'Ổ cứng', 'case' => 'Vỏ máy'
    ];
    $category_name = $categoryNames[$category] ?? 'Linh kiện';

    return view('pages.build_pc.build-select', compact('items', 'category', 'category_name'));
    }

    // 3. Xử lý khi người dùng nhấn nút "CHỌN" một sản phẩm
    public function addComponent($category, $id)
    {
        $component = Component::findOrFail($id);

        $build = session()->get('build_pc', []);

        // Lưu vào Session theo key của category (để khi chọn CPU mới nó sẽ ghi đè CPU cũ)
        $build[$category] = [
            'id'    => $component->id,
            'name'  => $component->name,
            'price' => $component->price,
            'image' => $component->image_url, // Đảm bảo trong DB bạn có cột này
        ];

        session()->put('build_pc', $build);

        return redirect()->route('build.index')->with('success', 'Đã thêm ' . $component->name);
    }

    // 4. Xóa một linh kiện khỏi danh sách đang chọn
    public function removeComponent($category)
    {
        $build = session()->get('build_pc', []);

        if (isset($build[$category])) {
            unset($build[$category]);
            session()->put('build_pc', $build);
        }

        return redirect()->route('build.index');
    }

    // 5. Làm mới toàn bộ (Reset)
    public function reset()
    {
        session()->forget('build_pc');
        return redirect()->route('build.index');
    }
}