<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class ComponentPrice extends Model
{
    public $timestamps = false;
    protected $fillable = [
        'component_id', 'dealer_id', 'price', 'product_url', 'updated_at'
    ];

    public function component()
    {
        return $this->belongsTo(Component::class);
    }

    public function dealer()
    {
        return $this->belongsTo(Dealer::class);
    }
}
