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
            'image'      => 'nullable|image|mimes:jpg,jpeg,png,webp|max:5120',
        ]);

        $componentId = DB::table('components')->insertGetId([
            'name'       => $validated['name'],
            'type_id'    => $validated['type_id'],
            'base_price' => $validated['base_price'],
        ]);

        $this->syncComponentPrice($componentId, $validated['base_price']);

        if ($request->hasFile('image')) {
            $typeName = DB::table('component_types')->where('id', $validated['type_id'])->value('type_name');
            $categorySlug = $this->mapTypeNameToSlug($typeName);
            $this->saveComponentImage($request->file('image'), $categorySlug, $componentId);
        }

        return redirect()->route('dashboard')
            ->with('success', 'Thêm linh kiện thành công!');
    }

    // Form sửa linh kiện
    public function edit(int $id)
    {
        $component = DB::table('components')
            ->join('component_types', 'components.type_id', '=', 'component_types.id')
            ->select('components.*', 'component_types.type_name')
            ->where('components.id', $id)
            ->first();

        if (!$component) abort(404);

        $categories = $this->getCategories();
        $returnUrl = request('return_url', route('dashboard'));
        return view('pages.admin.components.edit', compact('component', 'categories', 'returnUrl'));
    }

    // Cập nhật thông tin linh kiện
    public function update(Request $request, int $id)
    {
        $validated = $request->validate([
            'name'       => 'required|string|max:255',
            'type_id'    => 'required|integer|exists:component_types,id',
            'base_price' => 'nullable|numeric|min:0',
            'image'      => 'nullable|image|mimes:jpg,jpeg,png,webp|max:5120',
        ]);

        $component = DB::table('components')->where('id', $id)->first();
        if (!$component) {
            abort(404);
        }

        if ($component->type_id !== $validated['type_id']) {
            $oldType = DB::table('component_types')->where('id', $component->type_id)->value('type_name');
            $newType = DB::table('component_types')->where('id', $validated['type_id'])->value('type_name');
            $oldSlug = $this->mapTypeNameToSlug($oldType);
            $newSlug = $this->mapTypeNameToSlug($newType);
            $oldPath = public_path("images/components/{$oldSlug}/{$id}.jpg");
            $newDir = public_path("images/components/{$newSlug}");
            $newPath = "{$newDir}/{$id}.jpg";

            if (file_exists($oldPath)) {
                if (!is_dir($newDir)) {
                    mkdir($newDir, 0755, true);
                }
                rename($oldPath, $newPath);
            }
        }

        $updateData = [
            'name'    => $validated['name'],
            'type_id' => $validated['type_id'],
        ];

        if ($request->has('base_price') && $validated['base_price'] !== null) {
            $updateData['base_price'] = $validated['base_price'];
        }

        DB::table('components')->where('id', $id)->update($updateData);

        if (array_key_exists('base_price', $updateData)) {
            $this->syncComponentPrice($id, $updateData['base_price']);
        }

        if ($request->hasFile('image')) {
            $typeName = DB::table('component_types')->where('id', $validated['type_id'])->value('type_name');
            $categorySlug = $this->mapTypeNameToSlug($typeName);
            $this->saveComponentImage($request->file('image'), $categorySlug, $id);
        }

        $redirectTo = $request->input('return_url', route('dashboard'));
        return redirect($redirectTo)
            ->with('success', 'Cập nhật linh kiện thành công!');
    }

    private function saveComponentImage(\Illuminate\Http\UploadedFile $image, string $categorySlug, int $componentId)
    {
        $folder = public_path('images/components/' . $categorySlug);
        if (!is_dir($folder)) {
            mkdir($folder, 0755, true);
        }

        $target = $folder . DIRECTORY_SEPARATOR . $componentId . '.jpg';

        if (function_exists('imagejpeg')) {
            $source = match ($image->getMimeType()) {
                'image/jpeg' => imagecreatefromjpeg($image->getRealPath()),
                'image/png'  => function_exists('imagecreatefrompng') ? imagecreatefrompng($image->getRealPath()) : false,
                'image/webp' => function_exists('imagecreatefromwebp') ? imagecreatefromwebp($image->getRealPath()) : false,
                default      => false,
            };

            if ($source !== false) {
                $width = imagesx($source);
                $height = imagesy($source);
                $canvas = imagecreatetruecolor($width, $height);

                $white = imagecolorallocate($canvas, 255, 255, 255);
                imagefilledrectangle($canvas, 0, 0, $width, $height, $white);
                imagecopy($canvas, $source, 0, 0, 0, 0, $width, $height);
                imagejpeg($canvas, $target, 90);

                imagedestroy($canvas);
                imagedestroy($source);
                return;
            }
        }

        $image->move($folder, $componentId . '.jpg');
    }

    private function mapTypeNameToSlug(?string $typeName): string
    {
        if (!$typeName) {
            return 'other';
        }

        $slug = strtolower(trim($typeName));
        $slugMap = [
            'cpu'                 => 'cpu',
            'video card'          => 'gpu',
            'gpu'                 => 'gpu',
            'graphics card'       => 'gpu',
            'memory'              => 'ram',
            'ram'                 => 'ram',
            'internal hard drive' => 'storage',
            'storage'             => 'storage',
            'ssd'                 => 'storage',
            'motherboard'         => 'motherboard',
            'power supply'        => 'psu',
            'psu'                 => 'psu',
            'cpu cooler'          => 'cooler',
            'cooler'              => 'cooler',
            'case'                => 'case',
        ];

        return $slugMap[$slug] ?? str_replace(' ', '-', $slug);
    }

    // Xoá linh kiện
    public function destroy(int $id)
    {
        DB::table('components')->where('id', $id)->delete();
        $redirectTo = request('return_url', route('dashboard'));
        $scrollY = (int) request('scroll_y', 0);
        if ($scrollY > 0) {
            $redirectTo .= '#scroll=' . $scrollY;
        }
        return redirect($redirectTo)
            ->with('success', 'Đã xoá linh kiện!');
    }

    // Form cập nhật giá (base_price)
    public function editPrice(int $id)
    {
        $component = DB::table('components')->where('id', $id)->first();
        if (!$component) abort(404);

        return view('pages.admin.components.price', compact('component'));
    }

    // Lưu giá mới vào base_price
    public function updatePrice(Request $request, int $id)
    {
        $validated = $request->validate([
            'price' => 'required|numeric|min:0',
        ]);

        DB::table('components')->where('id', $id)->update([
            'base_price' => $validated['price'],
        ]);

        $this->syncComponentPrice($id, $validated['price']);

        return redirect()->route('dashboard')
            ->with('success', 'Cập nhật giá thành công!');
    }

    private function syncComponentPrice(int $componentId, float $price): void
    {
        $priceRowId = DB::table('component_prices')
            ->where('component_id', $componentId)
            ->orderBy('price')
            ->value('id');

        if ($priceRowId) {
            DB::table('component_prices')->where('id', $priceRowId)->update([
                'price'      => $price,
                'updated_at' => now(),
            ]);
            return;
        }

        $dealerId = DB::table('dealers')->orderBy('id')->value('id');
        if (!$dealerId) {
            return;
        }

        DB::table('component_prices')->insert([
            'component_id' => $componentId,
            'dealer_id'    => $dealerId,
            'price'        => $price,
            'updated_at'   => now(),
        ]);
    }
}
