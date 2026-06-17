<?php
require __DIR__.'/vendor/autoload.php';
$app = require_once __DIR__.'/bootstrap/app.php';
$kernel = $app->make(Illuminate\Contracts\Console\Kernel::class);
$kernel->bootstrap();

use Illuminate\Support\Facades\Http;

$url = 'https://www.newegg.com/p/pl?d=GeForce+RTX+4060';
$html = Http::withHeaders(['User-Agent' => 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36'])->get($url)->body();

if (preg_match('/class="price-current".*?<strong>([0-9,]+)<\/strong><sup>\.([0-9]+)<\/sup>/s', $html, $matches)) {
    echo "Found price: " . $matches[1] . "." . $matches[2] . "\n";
} else {
    echo "Not found. HTML preview:\n";
    echo substr($html, 0, 500) . "\n";
    // Let's check if the word "Are you a human" is in there
    if (strpos($html, 'Are you a human') !== false) {
        echo "Blocked by Cloudflare/Captcha.\n";
    }
}
