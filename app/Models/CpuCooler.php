<?php
namespace App\Models;
use Illuminate\Database\Eloquent\Model;
class CpuCooler extends Model {
    protected $table = 'cpu_coolers';
    protected $primaryKey = 'component_id';
    public $incrementing = false;
    public $timestamps = false;
}
