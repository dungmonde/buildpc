<?php
namespace App\Models;
use Illuminate\Database\Eloquent\Model;
class ComponentPrice extends Model {
    protected $table = 'component_prices';
    public $timestamps = false;
    protected $fillable = ['component_id', 'dealer_id', 'price', 'product_url'];
    public function component() {
        return $this->belongsTo(Component::class, 'component_id');
    }
}
