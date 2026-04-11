<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class AdminComponentController extends Controller
{
    // Lấy danh sách type từ DB
    private function getCategories(): array
    {
        return DB::table('component_types')->pluck('type_name', 'id')->toArray();
        // trả về [id => type_name]
    }

    // Form thêm linh kiện
    public function create()
    {
        $categories = $this->getCategories(); // [id => type_name]
        return view('pages.admin.components.create', compact('categories'));
    }

    // Lưu linh kiện mới
    public function store(Request $request)
    {
        $validated = $request->validate([
            'name'       => 'required|string|max:255',
            'type_id'    => 'required|integer|exists:component_types,id',
            'base_price' => 'required|numeric|min:0',
        ]);

        DB::table('components')->insert([
            'name'       => $validated['name'],
            'type_id'    => $validated['type_id'],
            'base_price' => $validated['base_price'],
        ]);

        return redirect()->route('dashboard')
            ->with('success', 'Thêm linh kiện thành công!');
    }

    // Form sửa linh kiện
    public function edit($id)
    {
        $component = DB::table('components')
            ->join('component_types', 'components.type_id', '=', 'component_types.id')
            ->select('components.*', 'component_types.type_name')
            ->where('components.id', $id)
            ->first();

        if (!$component) abort(404);

        $categories = $this->getCategories();
        return view('pages.admin.components.edit', compact('component', 'categories'));
    }

    // Cập nhật thông tin linh kiện
    public function update(Request $request, $id)
    {
        $validated = $request->validate([
            'name'    => 'required|string|max:255',
            'type_id' => 'required|integer|exists:component_types,id',
        ]);

        DB::table('components')->where('id', $id)->update([
            'name'    => $validated['name'],
            'type_id' => $validated['type_id'],
        ]);

        return redirect()->route('dashboard')
            ->with('success', 'Cập nhật linh kiện thành công!');
    }

    // Xoá linh kiện
    public function destroy($id)
    {
        DB::table('components')->where('id', $id)->delete();

        return redirect()->route('dashboard')
            ->with('success', 'Đã xoá linh kiện!');
    }

    // Form cập nhật giá (base_price)
    public function editPrice($id)
    {
        $component = DB::table('components')->where('id', $id)->first();
        if (!$component) abort(404);

        return view('pages.admin.components.price', compact('component'));
    }

    // Lưu giá mới vào base_price
    public function updatePrice(Request $request, $id)
    {
        $validated = $request->validate([
            'price' => 'required|numeric|min:0',
        ]);

        DB::table('components')->where('id', $id)->update([
            'base_price' => $validated['price'],
        ]);

        return redirect()->route('dashboard')
            ->with('success', 'Cập nhật giá thành công!');
    }
}