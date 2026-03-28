<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class PowerSupply extends Model
{
    public $timestamps = false;
    protected $primaryKey = 'component_id';
    protected $fillable = [
        'component_id', 'type', 'efficiency',
        'wattage', 'modular', 'color'
    ];

    protected $casts = ['modular' => 'boolean'];

    public function component()
    {
        return $this->belongsTo(Component::class, 'component_id');
    }
}
