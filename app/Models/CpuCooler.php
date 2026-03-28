<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class CpuCooler extends Model
{
    public $timestamps = false;
    protected $primaryKey = 'component_id';
    protected $fillable = [
        'component_id', 'rpm', 'noise_level', 'color', 'size'
    ];

    public function component()
    {
        return $this->belongsTo(Component::class, 'component_id');
    }
}
