<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Post; // Đảm bảo bạn đã có Model Post
use Illuminate\Support\Facades\Auth;

class ForumController extends Controller
{
    // Hiển thị trang danh sách bài viết
    public function index() {
        $posts = Post::with('user')->latest()->paginate(10);
        return view('pages.forum.forum', compact('posts'));
    }

    // Hiển thị trang tạo bài viết mới
    public function create() {
        return view('pages.forum.forum-create');
    }

    // Lưu bài viết vào database
    public function store(Request $request) {
        // 1. Kiểm tra dữ liệu đầu vào
        $request->validate([
            'title' => 'required|max:255',
            'content' => 'required',
        ], [
            'title.required' => 'Bạn quên nhập tiêu đề rồi!',
            'content.required' => 'Nội dung không được để trống nhé.',
        ]);

        // 2. Lưu vào database
        Post::create([
            'title' => $request->title,
            'content' => $request->content,
            'user_id' => Auth::id(), // Lấy ID của người dùng đang đăng nhập
        ]);

        // 3. Quay lại trang diễn đàn với thông báo thành công
        return redirect()->route('forum.index')->with('success', 'Đăng bài thành công!');
    }
}
