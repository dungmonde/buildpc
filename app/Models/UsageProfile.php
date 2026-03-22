<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class UsageProfile extends Model
{
    public $timestamps = false;
    protected $fillable = ['profile_name', 'description', 'logic_rules'];
    protected $casts = ['logic_rules' => 'array'];

    public function builds()
    {
        return $this->hasMany(PcBuild::class);
    }
}
