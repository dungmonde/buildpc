<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class VideoCardTdpSeeder extends Seeder
{
    /**
     * Bảng map chipset → TDP (Watt).
     * Key là substring khớp với tên chipset (case-insensitive).
     * Được sắp xếp từ specific → generic để match đúng hơn.
     */
    private array $tdpMap = [
        // === NVIDIA RTX 50 series ===
        'RTX 5090'      => 575,
        'RTX 5080'      => 360,
        'RTX 5070 Ti'   => 300,
        'RTX 5070'      => 250,
        'RTX 5060 Ti'   => 180,
        'RTX 5060'      => 150,

        // === NVIDIA RTX 40 series ===
        'RTX 4090'      => 450,
        'RTX 4080 Super'=> 320,
        'RTX 4080'      => 320,
        'RTX 4070 Ti Super' => 285,
        'RTX 4070 Ti'   => 285,
        'RTX 4070 Super'=> 220,
        'RTX 4070'      => 200,
        'RTX 4060 Ti'   => 165,
        'RTX 4060'      => 115,
        'RTX 4050'      => 100,

        // === NVIDIA RTX 30 series ===
        'RTX 3090 Ti'   => 450,
        'RTX 3090'      => 350,
        'RTX 3080 Ti'   => 350,
        'RTX 3080'      => 320,
        'RTX 3070 Ti'   => 290,
        'RTX 3070'      => 220,
        'RTX 3060 Ti'   => 200,
        'RTX 3060'      => 170,
        'RTX 3050'      => 130,

        // === NVIDIA RTX 20 series ===
        'RTX 2080 Ti'   => 250,
        'RTX 2080 Super'=> 250,
        'RTX 2080'      => 215,
        'RTX 2070 Super'=> 215,
        'RTX 2070'      => 175,
        'RTX 2060 Super'=> 175,
        'RTX 2060'      => 160,

        // === NVIDIA GTX 16 series ===
        'GTX 1660 Ti'   => 120,
        'GTX 1660 Super'=> 125,
        'GTX 1660'      => 120,
        'GTX 1650 Super'=> 100,
        'GTX 1650'      => 75,

        // === NVIDIA GTX 10 series ===
        'GTX 1080 Ti'   => 250,
        'GTX 1080'      => 180,
        'GTX 1070 Ti'   => 180,
        'GTX 1070'      => 150,
        'GTX 1060'      => 120,
        'GTX 1050 Ti'   => 75,
        'GTX 1050'      => 75,

        // === AMD RX 9000 series ===
        'RX 9070 XT'    => 304,
        'RX 9070'       => 220,

        // === AMD RX 7000 series ===
        'RX 7900 XTX'   => 355,
        'RX 7900 XT'    => 315,
        'RX 7900 GRE'   => 260,
        'RX 7800 XT'    => 263,
        'RX 7700 XT'    => 245,
        'RX 7600 XT'    => 190,
        'RX 7600'       => 165,
        'RX 7500 XT'    => 150,

        // === AMD RX 6000 series ===
        'RX 6950 XT'    => 335,
        'RX 6900 XT'    => 300,
        'RX 6800 XT'    => 300,
        'RX 6800'       => 250,
        'RX 6750 XT'    => 250,
        'RX 6700 XT'    => 230,
        'RX 6700'       => 175,
        'RX 6650 XT'    => 180,
        'RX 6600 XT'    => 160,
        'RX 6600'       => 132,
        'RX 6500 XT'    => 107,
        'RX 6400'       => 53,

        // === AMD RX 5000 series ===
        'RX 5700 XT'    => 225,
        'RX 5700'       => 180,
        'RX 5600 XT'    => 150,
        'RX 5500 XT'    => 130,

        // === Intel Arc ===
        'Arc B580'      => 190,
        'Arc B570'      => 150,
        'Arc A770'      => 225,
        'Arc A750'      => 225,
        'Arc A580'      => 175,
        'Arc A380'      => 75,
        // === NVIDIA GTX 900 series ===
'GTX 980 Ti'        => 250,
'GTX 980'           => 165,
'GTX 970'           => 145,
'GTX 960'           => 120,
'GTX 950'           => 90,

// === NVIDIA Quadro / Professional ===
'Quadro M5000'      => 150,
'Quadro M4000'      => 120,
'Quadro M2000'      => 75,
'Quadro P6000'      => 250,
'Quadro P5000'      => 180,
'Quadro P4000'      => 105,
'Quadro P2000'      => 75,
'Quadro P1000'      => 47,
'Quadro P400'       => 30,

// === AMD Radeon RX 500 series ===
'RX 590'            => 175,
'RX 580'            => 185,
'RX 570'            => 150,
'RX 560'            => 80,
'RX 550'            => 50,

// === AMD Radeon VEGA ===
'Radeon RX Vega 64' => 295,
'Radeon RX Vega 56' => 210,
'RX Vega 64'        => 295,
'RX Vega 56'        => 210,

// === AMD RTX Ada Generation (workstation) ===
'RTX 4500 Ada'      => 210,
'RTX 4000 Ada'      => 130,
'RTX 3500 Ada'      => 150,
'RTX 2000 Ada'      => 70,
// === NVIDIA T-series (workstation) ===
'T600'              => 40,
'T400'              => 31,
'T1000'             => 50,
'T2000'             => 70,

// === NVIDIA Quadro RTX ===
'Quadro RTX 8000'   => 295,
'Quadro RTX 6000'   => 295,
'Quadro RTX 5000'   => 230,
'Quadro RTX 4000'   => 160,

// === NVIDIA Quadro K-series ===
'Quadro K1200'      => 45,
'Quadro K2200'      => 68,
'Quadro K4200'      => 105,
'Quadro K5200'      => 150,

// === NVIDIA Quadro P620 ===
'Quadro P620'       => 40,

// === NVIDIA GeForce GT ===
'GT 1030'           => 30,
'GT 710'            => 19,

// === NVIDIA RTX 50 mobile ===
'RTX 5050'          => 90,

// === AMD Radeon PRO W-series ===
'Radeon PRO W7600'  => 130,
'Radeon PRO W7500'  => 70,
'Radeon PRO W6800'  => 250,
'Radeon PRO W6600'  => 100,

// === AMD Radeon Pro WX-series ===
'Radeon Pro WX 5100' => 75,
'Radeon Pro WX 4100' => 50,
'Radeon Pro WX 7100' => 130,

// === AMD RX 9060 ===
'RX 9060 XT'        => 150,
'RX 9060'           => 120,

// === NVIDIA TITAN series ===
'TITAN RTX'         => 280,
'TITAN V'           => 250,
'TITAN Xp'          => 250,
'TITAN X'           => 250,
'GTX Titan Black'   => 250,
'GTX Titan'         => 250,

// === NVIDIA GTX 700 series ===
'GTX 780 Ti'        => 250,
'GTX 780'           => 250,
'GTX 770'           => 230,
'GTX 760'           => 170,
'GTX 750 Ti'        => 60,
'GTX 750'           => 55,
    ];

    public function run(): void
    {
        $updated = 0;
        $skipped = 0;

        foreach ($this->tdpMap as $chipset => $tdp) {
            $rows = DB::table('video_cards')
                ->whereRaw('LOWER(chipset) LIKE ?', ['%' . strtolower($chipset) . '%'])
                ->whereNull('tdp') // Không ghi đè nếu đã có giá trị
                ->update(['tdp' => $tdp]);

            if ($rows > 0) {
                $updated += $rows;
                $this->command->line("  ✓ {$chipset} ({$tdp}W) → {$rows} dòng");
            } else {
                $skipped++;
            }
        }

        $this->command->info("\nHoàn thành: cập nhật {$updated} VGA, bỏ qua {$skipped} chipset không tìm thấy.");

        // Thống kê VGA vẫn chưa có TDP
        $missing = DB::table('video_cards')->whereNull('tdp')->count();
        if ($missing > 0) {
            $this->command->warn("{$missing} VGA vẫn chưa có TDP — kiểm tra lại chipset name.");

            // In ra 10 chipset đầu để debug
            $samples = DB::table('video_cards')
                ->join('components', 'video_cards.component_id', '=', 'components.id')
                ->whereNull('video_cards.tdp')
                ->limit(10)
                ->pluck('video_cards.chipset')
                ->toArray();

            foreach ($samples as $s) {
                $this->command->line("  - {$s}");
            }
        }
    }
}