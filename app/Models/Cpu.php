<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Cpu extends Model
{
    public $timestamps = false;
    protected $primaryKey = 'component_id';
    protected $fillable = [
        'component_id', 'core_count', 'core_clock', 'boost_clock',
        'microarchitecture', 'tdp', 'graphics', 'socket'
    ];

    public function component()
    {
        return $this->belongsTo(Component::class, 'component_id');
    }

    // Lọc mainboard tương thích theo socket
    public function compatibleMotherboards()
    {
        return Motherboard::where('socket', $this->socket)->with('component');
    }
}
