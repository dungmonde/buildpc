<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Post extends Model
{
    protected $fillable = [
        'user_id', 'title', 'content', 'post_type', 'build_id'
    ];

    public function user()
    {
        return $this->belongsTo(User::class);
    }

    public function build()
    {
        return $this->belongsTo(PcBuild::class, 'build_id');
    }

    public function votes()
    {
        return $this->hasMany(Vote::class);
    }

    public function upvoteCount()
    {
        return $this->votes()->where('vote_type', 'up')->count();
    }

    public function comments()
    {
        return $this->hasMany(Comment::class)->latest();
    }
}
