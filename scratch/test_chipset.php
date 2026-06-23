<?php
require __DIR__.'/../vendor/autoload.php';
$app = require_once __DIR__.'/../bootstrap/app.php';
$app->make('Illuminate\Contracts\Console\Kernel')->bootstrap();

$cpuNameVal = "Intel Core i7-14700K";
$mbNameVal = "MSI PRO H610M-G DDR4";

$cpuNameVal = strtolower($cpuNameVal);
$mbNameVal = strtolower($mbNameVal);
$cpuPriceVal = 9000000;

$isHighEndCpuVal = ($cpuPriceVal > 4000000)
    || preg_match('/\b(k|kf|ks|x3d)\b/i', $cpuNameVal)
    || str_contains($cpuNameVal, 'ryzen 7')
    || str_contains($cpuNameVal, 'ryzen 9')
    || str_contains($cpuNameVal, 'i7-')
    || str_contains($cpuNameVal, 'i9-');

echo "High End CPU: " . ($isHighEndCpuVal ? "Yes" : "No") . "\n";

$isCompatible = true;
if ($isHighEndCpuVal) {
    $badChipsets = ['h610', 'h510', 'h410', 'a320', 'a620', 'h710', 'b450', 'b460', 'b560'];
    foreach ($badChipsets as $chip) {
        if (str_contains($mbNameVal, $chip)) {
            $isCompatible = false;
            echo "Chipset rẻ tiền ($chip) nghẽn cổ chai CPU dòng cao cấp\n";
            break;
        }
    }
}

echo "Is Compatible: " . ($isCompatible ? "Yes" : "No") . "\n";
