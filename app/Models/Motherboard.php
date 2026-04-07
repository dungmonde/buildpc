<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Motherboard extends Model
{
    protected $table = 'motherboards';        // ← thiếu cái này
    protected $primaryKey = 'component_id';
    public $incrementing = false;             // ← thiếu cái này
    public $timestamps = false;

    protected $fillable = [
        'component_id', 'socket', 'form_factor',
        'max_memory', 'memory_slots', 'color', 'ddr_gen'
    ];

    public function component()
    {
        return $this->belongsTo(Component::class, 'component_id');
    }

    public function compatibleMemory()
    {
        return Memory::where('ddr_gen', $this->ddr_gen)->with('component');
    }
}