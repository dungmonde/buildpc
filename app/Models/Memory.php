<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Memory extends Model
{
    protected $table = 'memory';
    protected $primaryKey = 'component_id';
    public $incrementing = false;             // ← thiếu cái này
    public $timestamps = false;

    protected $fillable = [
        'component_id', 'speed', 'modules',
        'price_per_gb', 'color', 'first_word_latency', 'cas_latency',
        'capacity', 'ddr_gen'
    ];

    public function component()
    {
        return $this->belongsTo(Component::class, 'component_id');
    }
}