<?php
use Illuminate\Support\Facades\Route;

// Trang chủ
Route::get('/', fn() => view('pages.home'))->name('home');

// Linh kiện
Route::get('/components/{type}', fn($type) => view('pages.components.index'))->name('components.index');
Route::get('/components/{type}/{id}', fn($type, $id) => view('pages.components.show'))->name('components.show');

// PC Builder
Route::get('/builder', fn() => view('pages.builder.manual'))->name('builder.manual');
Route::get('/builder/recommend', fn() => view('pages.builder.recommend'))->name('builder.recommend');

// Forum
Route::get('/forum', fn() => view('pages.forum.index'))->name('forum.index');
Route::get('/forum/{id}', fn($id) => view('pages.forum.show'))->name('forum.show');

// Auth
Route::get('/login', fn() => view('pages.auth.login'))->name('login');
Route::get('/register', fn() => view('pages.auth.register'))->name('register');