<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Cases extends Model
{
    public $timestamps = false;
    protected $table = 'cases';
    protected $primaryKey = 'component_id';
    protected $fillable = [
        'component_id', 'type', 'color', 'psu',
        'side_panel', 'external_volume', 'internal_35_bays',
        'form_factor_support'
    ];

    public function component()
    {
        return $this->belongsTo(Component::class, 'component_id');
    }

    // Kiểm tra case có hỗ trợ form factor này không
    public function supports(string $formFactor): bool
    {
        return str_contains($this->form_factor_support ?? '', $formFactor);
    }
}
