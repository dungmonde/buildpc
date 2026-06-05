<?php
use App\Http\Controllers\RecommendController;
use App\Http\Controllers\ProfileController;
use App\Http\Controllers\ForumController;
use App\Http\Controllers\BuildController;
use App\Http\Controllers\ComponentController;
use App\Models\Component;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\DashboardController;
use App\Http\Controllers\AdminComponentController;

// Trang chủ
use Illuminate\Support\Facades\DB;

Route::get('/', function () {
    $posts = App\Models\Post::with('user')
        ->latest()
        ->limit(5)
        ->get();

    return view('pages.home', compact('posts'));

})->name('home');

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
Route::get('/builder', [BuildController::class, 'index'])->name('builder.manual');
Route::get('/builder/goi-y', [RecommendController::class, 'index'])->name('builder.recommend');
Route::post('/builder/goi-y', [RecommendController::class, 'recommend'])->name('builder.recommend.result');
Route::post('/builder/goi-y/apply', [RecommendController::class, 'applyRecommend'])
    ->middleware('auth')->name('build.apply-recommend');

// Build PC chi tiết
Route::prefix('build-pc')->name('build.')->group(function () {

    Route::get('/', [BuildController::class, 'index'])->name('index');

    Route::get('/select/{category}', [BuildController::class, 'select'])->name('select');

    Route::get('/apply-guide', [BuildController::class, 'applyGuide'])->name('apply-guide');

    Route::get('/add/{category}/{component_id}', [BuildController::class, 'addComponent'])->name('add');

    Route::get('/remove/{category}', [BuildController::class, 'removeComponent'])->name('remove');

    Route::get('/reset', [BuildController::class, 'reset'])->name('reset');

    Route::post('/save', [BuildController::class, 'save'])->name('save');
    Route::get('/slot/{slot}', [BuildController::class, 'switchSlot'])->name('slot');
});

// Diễn đàn
Route::get('/forum', [ForumController::class, 'index'])->name('forum.index');
Route::get('/forum/post/{id}', [ForumController::class, 'show'])->name('forum.show');

Route::middleware(['auth'])->group(function () {
    Route::get('/forum/create', [ForumController::class, 'create'])->name('forum.create');
    Route::post('/forum/store', [ForumController::class, 'store'])->name('forum.store');
});


Route::middleware('auth')->group(function () {
    Route::get('/profile', [ProfileController::class, 'edit'])->name('profile.edit');
    Route::patch('/profile', [ProfileController::class, 'update'])->name('profile.update');
    Route::delete('/profile', [ProfileController::class, 'destroy'])->name('profile.destroy');
});

// Bình luận
Route::post('/forum/post/{id}/comment', [ForumController::class, 'storeComment'])
     ->name('forum.comment.store')
     ->middleware('auth');

// Dashboard
Route::get('/dashboard', [DashboardController::class, 'index'])
    ->middleware('auth')
    ->name('dashboard');

Route::get('/linh-kien', [ComponentController::class, 'all'])->name('components.all');
 
// Quản lý linh kiện — chỉ admin
Route::middleware(['auth', 'admin'])->prefix('admin')->name('admin.')->group(function () {
    Route::get('/components/create',          [AdminComponentController::class, 'create'])->name('components.create');
    Route::post('/components',                [AdminComponentController::class, 'store'])->name('components.store');
    Route::get('/components/{id}/edit',       [AdminComponentController::class, 'edit'])->name('components.edit');
    Route::put('/components/{id}',            [AdminComponentController::class, 'update'])->name('components.update');
    Route::delete('/components/{id}',         [AdminComponentController::class, 'destroy'])->name('components.destroy');
    Route::get('/components/{id}/price',      [AdminComponentController::class, 'editPrice'])->name('components.price');
    Route::put('/components/{id}/price',      [AdminComponentController::class, 'updatePrice'])->name('components.update-price');
});

require __DIR__.'/auth.php';