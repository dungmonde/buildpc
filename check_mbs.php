<?php
require __DIR__ . '/vendor/autoload.php';
$app = require_once __DIR__ . '/bootstrap/app.php';
$kernel = $app->make(Illuminate\Contracts\Console\Kernel::class);
$kernel->bootstrap();

$mbs = \DB::table('components')
    ->join('motherboards', 'motherboards.component_id', '=', 'components.id')
    ->leftJoin(\DB::raw('(SELECT component_id, MIN(price) as price FROM component_prices GROUP BY component_id) cp'), 'cp.component_id', '=', 'components.id')
    ->select('components.id', 'components.name', 'motherboards.socket', \DB::raw('COALESCE(components.base_price, cp.price) as price'))
    ->orderBy('price')
    ->get();

foreach ($mbs as $m) {
    echo $m->id . ' | ' . $m->name . ' | ' . $m->socket . ' | ' . number_format($m->price) . PHP_EOL;
}
