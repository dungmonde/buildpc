<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class InternalHardDrive extends Model
{
    public $timestamps = false;
    protected $primaryKey = 'component_id';
    protected $fillable = [
        'component_id', 'capacity', 'price_per_gb',
        'type', 'cache', 'form_factor', 'interface'
    ];

    public function component()
    {
        return $this->belongsTo(Component::class, 'component_id');
    }
}
