<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Memory extends Model
{
    public $timestamps = false;
    protected $primaryKey = 'component_id';
    protected $fillable = [
        'component_id', 'speed', 'module_count', 'module_size',
        'price_per_gb', 'color', 'first_word_latency', 'cas_latency',
        'capacity', 'ddr_gen'
    ];

    public function component()
    {
        return $this->belongsTo(Component::class, 'component_id');
    }
}
