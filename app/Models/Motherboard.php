<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Motherboard extends Model
{
    public $timestamps = false;
    protected $primaryKey = 'component_id';
    protected $fillable = [
        'component_id', 'socket', 'form_factor',
        'max_memory', 'memory_slots', 'color', 'ddr_gen'
    ];

    public function component()
    {
        return $this->belongsTo(Component::class, 'component_id');
    }

    // Lọc RAM tương thích theo ddr_gen
    public function compatibleMemory()
    {
        return Memory::where('ddr_gen', $this->ddr_gen)->with('component');
    }
}
