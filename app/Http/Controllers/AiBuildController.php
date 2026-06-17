<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Http;
use App\Models\Component;

class AiBuildController extends Controller
{
    public function index()
    {
        return view('pages.build_pc.ai-suggest');
    }

    public function suggest(Request $request)
    {
        $request->validate([
            'budget' => 'required|numeric|min:3000000',
            'needs'  => 'required|string|max:500',
        ]);

        $apiKey = env('GEMINI_API_KEY');
        if (!$apiKey) {
            return back()->with('error', 'Tính năng AI chưa được cấu hình (thiếu API Key trong file .env).');
        }

        $budget = $request->budget;
        $needs = $request->needs;

        $prompt = "Ngân sách tối đa: " . number_format($budget) . " VNĐ.\nNhu cầu: " . $needs;

        $systemPrompt = <<<EOT
Bạn là một chuyên gia lắp ráp máy tính (PC Builder). Hãy đọc nhu cầu và ngân sách của người dùng, sau đó phân bổ ngân sách hợp lý cho từng linh kiện.
LUẬT QUAN TRỌNG:
1. Trả về định dạng JSON thuần túy, KHÔNG CÓ markdown (không có ```json).
2. Nếu ngân sách lớn hơn nhu cầu quá nhiều (ví dụ: chỉ làm văn phòng mà có 30 triệu), PHẢI trả về 2 builds: 1 "Đủ dùng" và 1 "Tối đa ngân sách".
3. Nếu nhu cầu cao mà ngân sách thấp (ví dụ: game nặng mà chỉ 5 triệu), trả về 1 build với require_vga=false và giải thích.
4. TỔNG các giá trị trong "allocations" PHẢI bằng đúng budget_allocated.
5. Trường cpu_brand: "intel", "amd", hoặc "any".
6. KHÔNG được nhắc tên linh kiện cụ thể trong explanation. Chỉ dùng từ chung ("CPU tầm trung", "card đồ họa tầm cao").
7. Phân bổ ngân sách hợp lý theo tỉ lệ: CPU+Mainboard chiếm khoảng 30-35%, VGA chiếm 35-45%, RAM+Storage+PSU+Case chiếm phần còn lại.
8. Mainboard luôn được phân bổ tối thiểu 2.500.000đ.
9. Storage luôn phân bổ tối thiểu 800.000đ.

Cấu trúc JSON bắt buộc (trả về đúng format này, KHÔNG THÊM gì ngoài):
{
  "builds": [
    {
      "title": "Tên cấu hình",
      "explanation": "Giải thích chung chung bằng tiếng Việt...",
      "budget_allocated": 15000000,
      "cpu_brand": "intel",
      "require_vga": true,
      "ram_capacity": 16,
      "storage_capacity": 500,
      "allocations": {
        "cpu": 3500000,
        "mainboard": 2500000,
        "ram": 1000000,
        "vga": 5000000,
        "storage": 1000000,
        "psu": 1000000,
        "case": 1000000
      }
    }
  ]
}
EOT;

        try {
            $response = Http::withoutVerifying()->withHeaders([
                'Content-Type' => 'application/json',
            ])->post('https://generativelanguage.googleapis.com/v1beta/models/gemini-flash-latest:generateContent?key=' . $apiKey, [
                'contents' => [
                    ['parts' => [['text' => $prompt]]]
                ],
                'systemInstruction' => [
                    'parts' => [['text' => $systemPrompt]]
                ],
                'generationConfig' => [
                    'responseMimeType' => 'application/json'
                ]
            ]);

            if (!$response->successful()) {
                \Log::error('Gemini API Error: ' . $response->body());
                if ($response->status() === 429) {
                    return back()->with('error', 'Hệ thống đang quá tải. Vui lòng chờ sau ít phút.');
                }
                return back()->with('error', 'Lỗi kết nối hệ thống. Vui lòng thử lại sau.');
            }

            $aiData = $response->json();
            $jsonString = $aiData['candidates'][0]['content']['parts'][0]['text'] ?? '';
            $jsonString = str_replace(['```json', '```'], '', $jsonString);
            $aiResult = json_decode(trim($jsonString), true);

            if (!$aiResult || !isset($aiResult['builds'])) {
                return back()->with('error', 'Dữ liệu trả về không hợp lệ. Vui lòng thử lại.');
            }

            $suggestedBuilds = [];
            foreach ($aiResult['builds'] as $build) {
                $suggestedBuilds[] = $this->buildFromAiConstraints($build);
            }

            return view('pages.build_pc.ai-result', compact('suggestedBuilds', 'budget', 'needs'));

        } catch (\Exception $e) {
            return back()->with('error', 'Có lỗi xảy ra: ' . $e->getMessage());
        }
    }

    /**
     * Chọn linh kiện tốt nhất (sát giá nhất) trong tầm tiền cho trước.
     * Dùng raw query để JOIN thẳng vào bảng spec.
     */
    private function pickByBudget(int $typeId, string $specTable, float $maxBudget, ?\Closure $filter = null): ?object
    {
        $ep = 'COALESCE(components.base_price, cp.price)';

        $selectExtra = $specTable === 'video_cards'
            ? ['video_cards.chipset']
            : [];

        $buildQuery = function() use ($typeId, $specTable, $ep, $selectExtra, $filter) {
            $q = \DB::table('components')
                ->join($specTable, "{$specTable}.component_id", '=', 'components.id')
                ->leftJoin(
                    \DB::raw('(SELECT component_id, MIN(price) as price FROM component_prices GROUP BY component_id) cp'),
                    'cp.component_id', '=', 'components.id'
                )
                ->where('components.type_id', $typeId)
                ->whereRaw("{$ep} > 0")
                ->select(array_merge(['components.id', 'components.name', \DB::raw("{$ep} as price")], $selectExtra));

            if ($filter) $filter($q);
            return $q;
        };

        // Ưu tiên: Món xịn nhất trong tầm giá
        $item = $buildQuery()
            ->whereRaw("{$ep} <= ?", [$maxBudget])
            ->orderByDesc('price')
            ->first();

        // Fallback: Món rẻ nhất thoả mãn điều kiện nếu budget quá thấp
        if (!$item) {
            $item = $buildQuery()
                ->orderBy('price')
                ->first();
        }

        return $item;
    }

    /**
     * Chọn vỏ case (không có spec table riêng)
     */
    private function pickCase(float $maxBudget): ?object
    {
        $ep = 'COALESCE(components.base_price, cp.price)';

        $buildQuery = function() use ($ep) {
            return \DB::table('components')
                ->join('cases', 'cases.component_id', '=', 'components.id')
                ->leftJoin(
                    \DB::raw('(SELECT component_id, MIN(price) as price FROM component_prices GROUP BY component_id) cp'),
                    'cp.component_id', '=', 'components.id'
                )
                ->where('components.type_id', 8)
                ->whereRaw("{$ep} > 0")
                ->select('components.id', 'components.name', \DB::raw("{$ep} as price"));
        };

        $item = $buildQuery()
            ->whereRaw("{$ep} <= ?", [$maxBudget])
            ->orderByDesc('price')
            ->first();

        if (!$item) {
            $item = $buildQuery()
                ->orderBy('price')
                ->first();
        }

        return $item;
    }

    private function buildFromAiConstraints(array $constraints): array
    {
        $allocs = $constraints['allocations'] ?? [];
        $build = [
            'title'            => $constraints['title'] ?? 'Cấu hình Đề xuất',
            'explanation'      => $constraints['explanation'] ?? '',
            'budget_allocated' => $constraints['budget_allocated'] ?? 0,
            'components'       => [],
            'total_price'      => 0,
        ];

        $brand  = strtolower($constraints['cpu_brand'] ?? 'any');
        $vgaTdp = 0;
        $cpuTdp = 65;
        $socket = null;
        $ddrGen = null;

        // ─── 1. CPU (type_id=1, table=cpus) ──────────────────────────────
        $cpuMax = (float)($allocs['cpu'] ?? 3000000);
        $cpu = $this->pickByBudget(1, 'cpus', $cpuMax, function ($q) use ($brand) {
            if ($brand !== 'any') {
                $q->where('components.name', 'ILIKE', "%{$brand}%");
            }
        });

        if ($cpu) {
            $build['components']['cpu'] = ['id' => $cpu->id, 'name' => $cpu->name, 'price' => (float)$cpu->price, 'image' => null];
            $build['total_price'] += (float)$cpu->price;
            // lấy socket & tdp từ bảng cpus
            $cpuSpec = \DB::table('cpus')->where('component_id', $cpu->id)->first();
            $socket  = $cpuSpec->socket ?? null;
            $cpuTdp  = $cpuSpec->tdp ?? 65;
        }

        // ─── 2. MAINBOARD (type_id=5, table=motherboards) ────────────────
        $mbMax = (float)($allocs['mainboard'] ?? 2000000);
        $mb = $this->pickByBudget(5, 'motherboards', $mbMax, function ($q) use ($socket) {
            if ($socket) {
                $q->where('motherboards.socket', $socket);
            }
        });

        if ($mb) {
            $build['components']['mainboard'] = ['id' => $mb->id, 'name' => $mb->name, 'price' => (float)$mb->price, 'image' => null];
            $build['total_price'] += (float)$mb->price;
            $mbSpec = \DB::table('motherboards')->where('component_id', $mb->id)->first();
            $ddrGen = $mbSpec->ddr_gen ?? null;
        }

        // ─── 3. RAM (type_id=3, table=memory) ────────────────────────────
        $ramMax = (float)($allocs['ram'] ?? 1000000);
        $ramCap = (int)($constraints['ram_capacity'] ?? 16);
        $ram = $this->pickByBudget(3, 'memory', $ramMax, function ($q) use ($ramCap, $ddrGen) {
            $q->where('memory.capacity', '>=', $ramCap);
            if ($ddrGen) {
                $q->where('memory.ddr_gen', $ddrGen);
            }
        });

        if ($ram) {
            $build['components']['ram'] = ['id' => $ram->id, 'name' => $ram->name, 'price' => (float)$ram->price, 'image' => null];
            $build['total_price'] += (float)$ram->price;
        }

        // ─── 4. VGA (type_id=2, table=video_cards) ───────────────────────
        if (!empty($constraints['require_vga'])) {
            $vgaMax = (float)($allocs['vga'] ?? 5000000);
            $vga = $this->pickByBudget(2, 'video_cards', $vgaMax);
            if ($vga) {
                $vgaName = $vga->name;
                if (!empty($vga->chipset)) {
                    $vgaName .= ' (' . $vga->chipset . ')';
                }
                $build['components']['vga'] = ['id' => $vga->id, 'name' => $vgaName, 'price' => (float)$vga->price, 'image' => null];
                $build['total_price'] += (float)$vga->price;
                $vgaSpec = \DB::table('video_cards')->where('component_id', $vga->id)->first();
                $vgaTdp  = $vgaSpec->tdp ?? 0;
            }
        }

        // ─── 5. STORAGE (type_id=4, table=internal_hard_drives) ──────────
        $storageMax = (float)($allocs['storage'] ?? 1000000);
        $storageCap = (int)($constraints['storage_capacity'] ?? 256);

        // Ưu tiên SSD trước, nếu không tìm được mới lấy HDD
        $storage = $this->pickByBudget(4, 'internal_hard_drives', $storageMax, function ($q) use ($storageCap) {
            $q->where('internal_hard_drives.capacity', '>=', $storageCap)
              ->where('internal_hard_drives.type', 'SSD');
        });

        if (!$storage) {
            // fallback: lấy bất kỳ loại storage nào
            $storage = $this->pickByBudget(4, 'internal_hard_drives', $storageMax, function ($q) use ($storageCap) {
                $q->where('internal_hard_drives.capacity', '>=', $storageCap);
            });
        }

        if ($storage) {
            $build['components']['storage'] = ['id' => $storage->id, 'name' => $storage->name, 'price' => (float)$storage->price, 'image' => null];
            $build['total_price'] += (float)$storage->price;
        }

        // ─── 6. PSU (type_id=6, table=power_supplies) ────────────────────
        $psuMax = (float)($allocs['psu'] ?? 1000000);
        $requiredWattage = $cpuTdp + $vgaTdp + 150;
        $psu = $this->pickByBudget(6, 'power_supplies', $psuMax, function ($q) use ($requiredWattage) {
            $q->where('power_supplies.wattage', '>=', $requiredWattage);
        });

        if ($psu) {
            $build['components']['psu'] = ['id' => $psu->id, 'name' => $psu->name, 'price' => (float)$psu->price, 'image' => null];
            $build['total_price'] += (float)$psu->price;
        }

        // ─── 7. CASE (type_id=8, table=cases) ────────────────────────────
        $caseMax = (float)($allocs['case'] ?? 1000000);
        $case = $this->pickCase($caseMax);

        if ($case) {
            $build['components']['case'] = ['id' => $case->id, 'name' => $case->name, 'price' => (float)$case->price, 'image' => null];
            $build['total_price'] += (float)$case->price;
        }

        return $build;
    }

    public function applyAiBuild(Request $request)
    {
        $components = $request->input('components', []);

        $build = [];
        foreach ($components as $cat => $id) {
            $comp = Component::with(['cheapestPrice'])->find($id);
            if ($comp) {
                $build[$cat] = [
                    'id'    => $comp->id,
                    'name'  => trim($comp->name),
                    'price' => $comp->base_price ?? $comp->cheapestPrice?->price ?? 0,
                    'image' => $comp->image_url ?? null,
                ];
            }
        }

        session()->put('build_pc', $build);
        return redirect()->route('build.index')->with('success', 'Đã áp dụng cấu hình AI đề xuất!');
    }
}
