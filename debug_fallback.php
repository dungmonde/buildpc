<?php
require __DIR__ . '/vendor/autoload.php';
$app = require_once __DIR__ . '/bootstrap/app.php';
$kernel = $app->make(Illuminate\Contracts\Console\Kernel::class);
$kernel->bootstrap();

$typeId = 1;
$specTable = 'cpus';
$maxBudget = 2240000;
$cpuMin = 0;
$ep = 'COALESCE(components.base_price, cp.price)';

$q = \DB::table('components')
    ->join($specTable, "{$specTable}.component_id", '=', 'components.id')
    ->leftJoin(
        \DB::raw('(SELECT component_id, MIN(price) as price FROM component_prices GROUP BY component_id) cp'),
        'cp.component_id', '=', 'components.id'
    )
    ->where('components.type_id', $typeId)
    ->whereRaw("{$ep} > 0")
    ->whereRaw("{$ep} <= ?", [$maxBudget])
    ->select(['components.id', 'components.name', \DB::raw("{$ep} as price")]);

$sql = $q->toSql();
$bindings = $q->getBindings();

echo "SQL: " . $sql . PHP_EOL;
echo "Bindings: " . implode(', ', $bindings) . PHP_EOL;

$results = $q->get();
echo "Count: " . count($results) . PHP_EOL;
foreach($results as $r) {
    echo $r->id . ' | ' . $r->name . ' | ' . number_format($r->price) . PHP_EOL;
}
