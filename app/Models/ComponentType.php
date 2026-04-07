<?php
namespace App\Models;
use Illuminate\Database\Eloquent\Model;
class ComponentType extends Model {
    protected $table = 'component_types';
    public $timestamps = false;
    public function components() {
        return $this->hasMany(Component::class, 'type_id');
    }
}
