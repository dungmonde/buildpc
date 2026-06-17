<?php

namespace App\Console\Commands;

use Illuminate\Console\Command;
use App\Models\Component;
use App\Models\ComponentPrice;
use Illuminate\Support\Facades\Http;

class CrawlPricesCommand extends Command
{
    protected $signature = 'crawl:prices';
    protected $description = 'Crawl real prices from memoryzone.com.vn for all components';

    public function handle()
    {
        $this->info('Starting to crawl prices...');

        $components = Component::all();
        $dealerId = \Illuminate\Support\Facades\DB::table('dealers')->orderBy('id')->value('id') ?? 1;

        $count = 0;
        foreach ($components as $component) {
            // Sleep to avoid rate limiting
            usleep(200000); // 0.2s

            $query = urlencode($component->name);
            try {
                $response = Http::timeout(5)->withHeaders([
                    'User-Agent' => 'Mozilla/5.0 (Windows NT 10.0; Win64; x64)'
                ])->get("https://memoryzone.com.vn/search?type=product&q={$query}");

                $html = $response->body();
                
                // Try to find the price in the first search result
                if (preg_match('/class="product-price">\s*([0-9\.,]+)₫/i', $html, $matches) || preg_match('/class="price">\s*([0-9\.,]+)₫/i', $html, $matches)) {
                    $priceStr = $matches[1];
                    $priceStr = str_replace(['.', ','], '', $priceStr);
                    $price = (float) $priceStr;

                    if ($price > 0) {
                        // Update base price
                        $component->base_price = $price;
                        $component->save();

                        // Update or create component_price
                        ComponentPrice::updateOrCreate(
                            ['component_id' => $component->id],
                            ['price' => $price, 'dealer_id' => $dealerId, 'updated_at' => now()]
                        );

                        $this->info("Updated {$component->name} -> " . number_format($price) . " ₫");
                        $count++;
                        continue;
                    }
                }
                
                // Fallback: try Phongvu API if Memoryzone fails
                $pvResponse = Http::timeout(5)->withHeaders([
                    'User-Agent' => 'Mozilla/5.0'
                ])->get("https://hacom.vn/search?q={$query}");
                
                if (preg_match('/class="price">\s*([0-9\.,]+)\s*[đđ₫]/i', $pvResponse->body(), $pvMatches)) {
                    $priceStr = $pvMatches[1];
                    $priceStr = str_replace(['.', ','], '', $priceStr);
                    $price = (float) $priceStr;

                    if ($price > 0) {
                        $component->base_price = $price;
                        $component->save();

                        ComponentPrice::updateOrCreate(
                            ['component_id' => $component->id],
                            ['price' => $price, 'dealer_id' => $dealerId, 'updated_at' => now()]
                        );

                        $this->info("Updated {$component->name} (Hacom) -> " . number_format($price) . " ₫");
                        $count++;
                        continue;
                    }
                }
                
                $this->error("Could not find price for {$component->name}");

            } catch (\Exception $e) {
                $this->error("Failed to crawl {$component->name}: " . $e->getMessage());
            }
        }

        $this->info("Finished! Successfully updated $count components.");
    }
}
