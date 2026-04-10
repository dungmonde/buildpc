<?php

use App\Http\Controllers\ProfileController;
use App\Http\Controllers\ForumController;
use App\Http\Controllers\BuildController;
use App\Http\Controllers\ComponentController;
use App\Models\Component;
use Illuminate\Support\Facades\Route;

// Trang chủ
Route::get('/', fn() => view('pages.home'))->name('home');

// Hướng dẫn
Route::get('/huong-dan', fn() => view('pages.guides.index'))->name('guides.index');

// Linh kiện
Route::get('/linh-kien/{type}', [ComponentController::class, 'index'])->name('components.index');
Route::get('/linh-kien/{type}/{id}', function ($type, $id) {
    $map = [
        'cpu'         => 'cpu',
        'gpu'         => 'gpu',
        'ram'         => 'ram',
        'storage'     => 'storage',
        'motherboard' => 'motherboard',
        'psu'         => 'psu',
        'cooler'      => 'cooler',
        'case'        => 'case_'
    ];

    if (!array_key_exists($type, $map)) {
        abort(404);
    }

    $relation  = $map[$type];
    $component = Component::with([$relation, 'prices'])->findOrFail($id);
    $spec      = $component->$relation;
    $price     = $component->prices->min('price');

    return view('pages.components.show', compact('component', 'spec', 'price', 'type'));
})->name('components.show');

// PC Builder
Route::get('/builder', fn() => view('pages.builder.manual'))->name('builder.manual');
Route::get('/builder/goi-y', fn() => view('pages.builder.recommend'))->name('builder.recommend');

// Diễn đàn
Route::get('/forum', [ForumController::class, 'index'])->name('forum.index');
Route::get('/forum/post/{id}', [ForumController::class, 'show'])->name('forum.show');
Route::middleware(['auth'])->group(function () {
    Route::get('/forum/create', [ForumController::class, 'create'])->name('forum.create');
    Route::post('/forum/store', [ForumController::class, 'store'])->name('forum.store');
});

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