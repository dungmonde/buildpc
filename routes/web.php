<?php

use App\Http\Controllers\ProfileController;
use App\Models\Component;
use Illuminate\Support\Facades\Route;

// Trang chủ
Route::get('/', fn() => view('pages.home'))->name('home');

// PC Builder
Route::get('/builder', fn() => view('pages.builder.manual'))->name('builder.manual');
Route::get('/builder/goi-y', fn() => view('pages.builder.recommend'))->name('builder.recommend');

// Linh kiện — map slug URL → type_id trong DB
Route::get('/linh-kien/{type}', function ($type) {
    $typeMap = [
        'cpu'         => 1,
        'gpu'         => 2,
        'ram'         => 3,
        'storage'     => 4,
        'motherboard' => 5,
        'psu'         => 6,
        'cooler'      => 7,
        'case'        => 8,
    ];

    if (!array_key_exists($type, $typeMap)) {
        abort(404);
    }

    $typeId = $typeMap[$type];

    // Query components + JOIN bảng spec + lấy giá thấp nhất
    $specRelation = match($type) {
        'cpu'         => 'cpu',
        'gpu'         => 'gpu',
        'ram'         => 'ram',
        'storage'     => 'storage',
        'motherboard' => 'motherboard',
        'psu'         => 'psu',
        'cooler'      => 'cooler',
        'case'        => 'case_',
    };

    $components = Component::where('type_id', $typeId)
        ->with([$specRelation, 'cheapestPrice'])
        ->paginate(20);


    return view('pages.components.index', compact('type', 'components', 'specRelation'));
    })->name('components.index');

    Route::get('/linh-kien/{type}/{id}', function ($type, $id) {
        return view('pages.components.show');
    })->name('components.show');

    // Diễn đàn
    Route::get('/dien-dan', fn() => view('pages.forum.index'))->name('forum.index');
    Route::get('/dien-dan/{id}', fn($id) => view('pages.forum.show'))->name('forum.show');

    // Dashboard
    Route::get('/dashboard', function () {
        return view('dashboard');
    })->middleware(['auth', 'verified'])->name('dashboard');

    Route::middleware('auth')->group(function () {
        Route::get('/profile', [ProfileController::class, 'edit'])->name('profile.edit');
        Route::patch('/profile', [ProfileController::class, 'update'])->name('profile.update');
        Route::delete('/profile', [ProfileController::class, 'destroy'])->name('profile.destroy');
    });

    require __DIR__.'/auth.php';