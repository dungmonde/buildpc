<?php

namespace App\Http\Controllers;

use App\Models\Component;

class ComponentController extends Controller
{
    public function show($type, $id)
    {
        $map = [
            'cpu' => 'cpu',
            'gpu' => 'gpu',
            'ram' => 'ram',
            'storage' => 'storage',
            'motherboard' => 'motherboard',
            'psu' => 'psu',
            'cooler' => 'cooler',
            'case' => 'case_'
        ];

        $relation = $map[$type] ?? null;

        $component = Component::with([$relation, 'prices'])
            ->findOrFail($id);

        $spec = $component->$relation;

        $price = $component->prices->min('price');

        return view('pages.components.show', compact(
            'component',
            'spec',
            'price',
            'type'
        ));
    }
}