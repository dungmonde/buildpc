<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class AirCoolerSeeder extends Seeder
{
    public function run(): void
    {
        $coolers = [
            // Tên, rpm, noise_level, color, size(mm fan), price
            ['Cooler Master Hyper 212 Black Edition', 2000, 26.0, 'Black', 120, 850000],
            ['Cooler Master Hyper 212 RGB', 2000, 26.0, 'Black', 120, 950000],
            ['Cooler Master Hyper 212 Spectrum V3', 1800, 25.0, 'Black', 120, 1050000],
            ['Cooler Master Hyper 622 Halo', 1800, 28.0, 'Black', 120, 1400000],
            ['Deepcool AK400', 1850, 28.9, 'Black', 120, 750000],
            ['Deepcool AK400 WH', 1850, 28.9, 'White', 120, 800000],
            ['Deepcool AK400 Zero Dark', 1850, 28.9, 'Black', 120, 850000],
            ['Deepcool AK500', 1850, 27.8, 'Black', 120, 1100000],
            ['Deepcool AK500 WH', 1850, 27.8, 'White', 120, 1150000],
            ['Deepcool AK620', 1850, 28.9, 'Black', 120, 1350000],
            ['Deepcool AK620 WH', 1850, 28.9, 'White', 120, 1400000],
            ['Deepcool AG400', 1850, 28.9, 'Black', 120, 650000],
            ['Deepcool AG400 WH', 1850, 28.9, 'White', 120, 700000],
            ['Deepcool AG620', 1850, 28.9, 'Black', 120, 950000],
            ['ID-Cooling SE-214-XT', 1800, 30.0, 'Black', 120, 550000],
            ['ID-Cooling SE-224-XT', 1800, 30.0, 'Black', 120, 700000],
            ['ID-Cooling SE-224-XT ARGB', 1800, 30.0, 'Black', 120, 800000],
            ['ID-Cooling SE-226-XT', 1800, 30.0, 'Black', 120, 850000],
            ['ID-Cooling SE-226-XT ARGB', 1800, 30.0, 'Black', 120, 950000],
            ['ID-Cooling TC-12 PLUS', 2000, 31.0, 'Black', 120, 450000],
            ['be quiet! Pure Rock 2', 1500, 25.5, 'Black', 120, 950000],
            ['be quiet! Pure Rock 2 White', 1500, 25.5, 'White', 120, 1000000],
            ['be quiet! Shadow Rock 3', 1600, 24.4, 'Black', 120, 1300000],
            ['be quiet! Dark Rock 4', 1400, 24.3, 'Black', 120, 1700000],
            ['be quiet! Dark Rock Pro 4', 1500, 24.3, 'Black', 120, 2100000],
            ['Noctua NH-U12S redux', 1500, 25.1, 'Brown / Beige', 120, 1450000],
            ['Noctua NH-U12A', 2000, 22.6, 'Brown / Beige', 120, 2500000],
            ['Noctua NH-D15', 1500, 24.6, 'Brown / Beige', 140, 3000000],
            ['Noctua NH-D15S chromax.black', 1500, 24.6, 'Black', 140, 3200000],
            ['Noctua NH-U14S', 1500, 25.1, 'Brown / Beige', 140, 1800000],
            ['Arctic Freezer 34 eSports', 2100, 0.5, 'Black', 120, 700000],
            ['Arctic Freezer 34 eSports Duo', 2100, 0.5, 'Black', 120, 900000],
            ['Arctic Freezer 36', 1700, 0.3, 'Black', 120, 750000],
            ['Arctic Freezer 36 A-RGB', 1700, 0.3, 'Black', 120, 900000],
            ['Scythe Mugen 6', 1200, 24.9, 'Black', 120, 1600000],
            ['Scythe Fuma 3', 1500, 23.5, 'Black', 120, 1900000],
            ['Thermalright Peerless Assassin 120', 1550, 25.6, 'Black', 120, 850000],
            ['Thermalright Peerless Assassin 120 SE', 1550, 25.6, 'Black', 120, 950000],
            ['Thermalright Peerless Assassin 120 SE ARGB', 1550, 25.6, 'Black', 120, 1050000],
            ['Thermalright Assassin X 120 R SE', 1550, 25.6, 'Black', 120, 650000],
            ['Thermalright True Spirit 120 BX', 1500, 25.6, 'Black', 120, 500000],
            ['ASUS TUF Gaming LC II 120', 2500, 30.0, 'Black', 120, 700000],
            ['MSI MAG CoreLiquid E240', 2600, 32.0, 'Black', 120, 900000],
            ['Zalman CNPS10X Optima II', 1500, 35.0, 'Black', 120, 600000],
            ['Zalman CNPS10X Performa Black', 1500, 35.0, 'Black', 120, 700000],
            ['SilverStone Hydrogon D120', 1800, 28.0, 'Black', 120, 800000],
            ['Cougar Forza 85 Essential', 1800, 30.0, 'Black', 120, 450000],
            ['Cougar Forza 50 Essential', 1800, 30.0, 'Black', 120, 350000],
            ['Jonsbo CR-1000 GT', 2000, 30.0, 'Black', 120, 550000],
            ['Jonsbo HX6240D', 2000, 30.0, 'Black', 120, 750000],
        ];

        $startId = 4936;

        foreach ($coolers as $i => $cooler) {
            $componentId = $startId + $i;

            // Insert vào bảng components
            DB::table('components')->insert([
                'id'      => $componentId,
                'name'    => $cooler[0],
                'type_id' => 7, // COOLER
            ]);

            // Insert vào bảng cpu_coolers
            DB::table('cpu_coolers')->insert([
                'component_id' => $componentId,
                'rpm'          => $cooler[1],
                'noise_level'  => $cooler[2],
                'color'        => $cooler[3],
                'size'         => $cooler[4],
            ]);

            // Insert giá vào component_prices nếu có
            // DB::table('component_prices')->insert([...]);
        }

        $this->command->info('Đã thêm ' . count($coolers) . ' tản khí thành công!');
    }
}