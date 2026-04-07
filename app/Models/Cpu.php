<?php
namespace App\Models;
use Illuminate\Database\Eloquent\Model;
class Cpu extends Model {
    protected $table = 'cpus';
    protected $primaryKey = 'component_id';
    public $incrementing = false;
    public $timestamps = false;
}
