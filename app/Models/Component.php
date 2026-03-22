<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Component extends Model
{
    public $timestamps = false;
    protected $fillable = ['name', 'type_id', 'base_price'];

    public function type()
    {
        return $this->belongsTo(ComponentType::class, 'type_id');
    }

    public function prices()
    {
        return $this->hasMany(ComponentPrice::class);
    }

    // Lấy giá thấp nhất từ các dealer
    public function lowestPrice()
    {
        return $this->prices()->min('price');
    }

    public function cpu()       { return $this->hasOne(Cpu::class, 'component_id'); }
    public function cpuCooler() { return $this->hasOne(CpuCooler::class, 'component_id'); }
    public function motherboard(){ return $this->hasOne(Motherboard::class, 'component_id'); }
    public function memory()    { return $this->hasOne(Memory::class, 'component_id'); }
    public function videoCard() { return $this->hasOne(VideoCard::class, 'component_id'); }
    public function hardDrive() { return $this->hasOne(InternalHardDrive::class, 'component_id'); }
    public function case_()     { return $this->hasOne(Cases::class, 'component_id'); }
    public function psu()       { return $this->hasOne(PowerSupply::class, 'component_id'); }
}
