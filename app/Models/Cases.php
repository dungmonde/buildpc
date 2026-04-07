<?php
namespace App\Models;
use Illuminate\Database\Eloquent\Model;
class Cases extends Model {
    protected $table = 'cases';
    protected $primaryKey = 'component_id';
    public $incrementing = false;
    public $timestamps = false;
}
