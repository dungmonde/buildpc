<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class VideoCard extends Model
{
    public $timestamps = false;
    protected $primaryKey = 'component_id';
    protected $fillable = [
        'component_id', 'chipset', 'memory',
        'core_clock', 'boost_clock', 'color', 'length'
    ];

    public function component()
    {
        return $this->belongsTo(Component::class, 'component_id');
    }
}
