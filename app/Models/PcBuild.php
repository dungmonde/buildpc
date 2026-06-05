<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class PcBuild extends Model
{
    protected $fillable = [
        'user_id', 'build_name', 'total_price', 'usage_profile_id'
    ];

    public function user()
    {
        return $this->belongsTo(User::class);
    }

    public function usageProfile()
    {
        return $this->belongsTo(UsageProfile::class);
    }

    public function components()
    {
        // pivot table uses `build_id` and `component_id` columns
        return $this->belongsToMany(Component::class, 'build_components', 'build_id', 'component_id')
                    ->withPivot('quantity');
    }

    public function posts()
    {
        return $this->hasMany(Post::class, 'build_id');
    }
}
