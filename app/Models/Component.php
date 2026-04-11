<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Component extends Model
{
    protected $table = 'components';
    public $timestamps = false;

    protected $fillable = ['name', 'type_id'];

    public function componentType()
    {
        return $this->belongsTo(ComponentType::class, 'type_id');
    }

    public function prices()
    {
        return $this->hasMany(ComponentPrice::class, 'component_id');
    }

    public function cheapestPrice()
    {
        return $this->hasOne(ComponentPrice::class, 'component_id')->orderBy('price', 'asc');
    }

    public function cpu()
    {
        return $this->hasOne(Cpu::class, 'component_id');
    }

    public function gpu()
    {
        return $this->hasOne(VideoCard::class, 'component_id');
    }

    public function ram()
    {
        return $this->hasOne(Memory::class, 'component_id');
    }

    public function storage()
    {
        return $this->hasOne(InternalHardDrive::class, 'component_id');
    }

    public function motherboard()
    {
        return $this->hasOne(Motherboard::class, 'component_id');
    }

    public function psu()
    {
        return $this->hasOne(PowerSupply::class, 'component_id');
    }

    public function cooler()
    {
        return $this->hasOne(CpuCooler::class, 'component_id');
    }

    public function pcCase()
    {
        return $this->hasOne(Cases::class, 'component_id');
    }
}