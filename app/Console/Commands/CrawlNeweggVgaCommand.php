<?php

namespace App\Console\Commands;

use Illuminate\Console\Command;
use App\Models\Component;
use App\Models\ComponentPrice;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Http;

class CrawlNeweggVgaCommand extends Command
{
    protected $signature = 'crawl:newegg-vga';
    protected $description = 'Crawl real prices for VGAs from Newegg and convert to VND';

    public function handle()
    {
        $this->info('Starting to crawl VGA prices from Newegg...');

        $vgas = DB::table('components')
            ->join('video_cards', 'components.id', '=', 'video_cards.component_id')
            ->select('components.id', 'components.name', 'video_cards.chipset')
            ->where('components.type_id', 2)
            ->get();

        $dealerId = DB::table('dealers')->orderBy('id')->value('id') ?? 1;
        $exchangeRate = 25400; // 1 USD = 25,400 VND

        $count = 0;
        foreach ($vgas as $vga) {
            // Sleep to avoid rate limiting
            usleep(1000000); // 1 second

            $searchTerms = trim(($vga->chipset ?? '') . ' ' . $vga->name);
            // Replace spaces with +
            $query = urlencode($searchTerms);
            
            try {
                $response = Http::timeout(10)->withHeaders([
                    'User-Agent' => 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36',
                    'Accept-Language' => 'en-US,en;q=0.9',
                ])->get("https://www.newegg.com/p/pl?d={$query}");

                $html = $response->body();
                
                // Regex to find price-current
                if (preg_match('/class="price-current".*?<strong>([0-9,]+)<\/strong><sup>\.([0-9]+)<\/sup>/s', $html, $matches)) {
                    $dollars = str_replace(',', '', $matches[1]);
                    $cents = $matches[2];
                    $usdPrice = (float) ($dollars . '.' . $cents);

                    if ($usdPrice > 0) {
                        $vndPrice = round($usdPrice * $exchangeRate);

                        // Update base price
                        DB::table('components')->where('id', $vga->id)->update(['base_price' => $vndPrice]);

                        // Update or create component_price
                        ComponentPrice::updateOrCreate(
                            ['component_id' => $vga->id],
                            ['price' => $vndPrice, 'dealer_id' => $dealerId, 'updated_at' => now()]
                        );

                        $this->info("Updated {$searchTerms} -> $" . $usdPrice . " (~" . number_format($vndPrice) . " ₫)");
                        $count++;
                        continue;
                    }
                }
                
                $this->error("Could not find price for {$searchTerms}");

            } catch (\Exception $e) {
                $this->error("Failed to crawl {$searchTerms}: " . $e->getMessage());
            }
        }

        $this->info("Finished! Successfully updated $count VGA prices from Newegg.");
    }
}
