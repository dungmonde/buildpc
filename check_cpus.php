<?php
require __DIR__ . '/vendor/autoload.php';
$app = require_once __DIR__ . '/bootstrap/app.php';
$kernel = $app->make(Illuminate\Contracts\Console\Kernel::class);
$kernel->bootstrap();

$cpus = \DB::table('components')
    ->join('cpus', 'cpus.component_id', '=', 'components.id')
    ->leftJoin(\DB::raw('(SELECT component_id, MIN(price) as price FROM component_prices GROUP BY component_id) cp'), 'cp.component_id', '=', 'components.id')
    ->where('components.type_id', 1)
    ->select('components.id', 'components.name', \DB::raw('COALESCE(components.base_price, cp.price) as price'))
    ->get();

foreach ($cpus as $c) {
    echo $c->id . ' | ' . $c->name . ' | ' . number_format($c->price) . PHP_EOL;
}
