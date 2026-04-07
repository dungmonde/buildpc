<?php
namespace App\Models;
use Illuminate\Database\Eloquent\Model;
class InternalHardDrive extends Model {
    protected $table = 'internal_hard_drives';
    protected $primaryKey = 'component_id';
    public $incrementing = false;
    public $timestamps = false;
}
