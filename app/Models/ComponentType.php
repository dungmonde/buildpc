<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class ComponentType extends Model
{
    public $timestamps = false;
    protected $fillable = ['type_name'];

    public function components()
    {
        return $this->hasMany(Component::class, 'type_id');
    }
}
