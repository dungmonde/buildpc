<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Dealer extends Model
{
    public $timestamps = false;
    protected $fillable = ['name', 'website', 'logo_url'];

    public function prices()
    {
        return $this->hasMany(ComponentPrice::class);
    }
}
