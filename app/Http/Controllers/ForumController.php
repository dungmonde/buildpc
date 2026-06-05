<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Post;
use App\Models\Comment;
use Illuminate\Support\Facades\Auth;

class ForumController extends Controller
{
    /**
     * Hiển thị danh sách bài viết
     */
    public function index()
    {
        $posts = Post::with('user')
                     ->latest()
                     ->paginate(10);

        return view('pages.forum.forum', compact('posts'));
    }

    /**
     * Hiển thị form tạo bài viết mới
     */
    public function create()
    {
        return view('pages.forum.forum-create');
    }

    /**
     * Lưu bài viết mới vào database
     */
    public function store(Request $request)
    {
        $request->validate([
            'title'   => 'required|max:255',
            'content' => 'required|min:10',
        ], [
            'title.required'   => 'Bạn quên nhập tiêu đề rồi!',
            'content.required' => 'Nội dung không được để trống nhé.',
            'content.min'      => 'Nội dung phải có ít nhất 10 ký tự.',
        ]);

        Post::create([
            'title'    => $request->title,
            'content'  => $request->content,
            'user_id'  => Auth::id(),
        ]);

        return redirect()->route('forum.index')
                         ->with('success', 'Đăng bài thành công!');
    }

    /**
     * Hiển thị chi tiết bài viết + danh sách bình luận
     */
    public function show($id)
    {
        $post = Post::with(['user', 'comments.user'])
                    ->findOrFail($id);

        return view('pages.forum.show', compact('post'));
    }

    /**
     * Lưu bình luận mới
     */
    public function storeComment(Request $request, $postId)
    {
        $request->validate([
            'content' => 'required|min:3',
        ], [
            'content.required' => 'Bạn chưa nhập nội dung bình luận.',
            'content.min'      => 'Bình luận phải có ít nhất 3 ký tự.',
        ]);

        Comment::create([
            'post_id' => $postId,
            'user_id' => Auth::id(),
            'content' => $request->content,
        ]);

        return redirect()->route('forum.show', $postId)
                         ->with('success', 'Bình luận đã được đăng!');
    }
}