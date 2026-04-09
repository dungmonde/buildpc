<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

class BuildController extends Controller
{
    public function index() {
    // Lấy các linh kiện theo category (CPU, GPU, RAM...)
    $components = \App\Models\Component::all()->groupBy('category');
    return view('pages.build-pc', compact('components'));
    }
}
