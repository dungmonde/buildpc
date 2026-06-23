<?php

namespace Tests\Feature;

use Illuminate\Foundation\Testing\RefreshDatabase;
use Illuminate\Support\Facades\Http;
use Illuminate\Support\Facades\DB;
use Tests\TestCase;

class AiBuildControllerTest extends TestCase
{
    use RefreshDatabase;

    protected function setUp(): void
    {
        parent::setUp();
        // Cấu hình API key cho môi trường test
        $_ENV['GEMINI_API_KEY'] = 'fake_gemini_api_key';
        $_SERVER['GEMINI_API_KEY'] = 'fake_gemini_api_key';
        putenv("GEMINI_API_KEY=fake_gemini_api_key");
        $this->seedTestData();
    }

    private function seedTestData()
    {
        // Seeding types
        DB::table('component_types')->insert([
            ['id' => 1, 'type_name' => 'cpu'],
            ['id' => 2, 'type_name' => 'video_card'],
            ['id' => 3, 'type_name' => 'memory'],
            ['id' => 4, 'type_name' => 'internal_hard_drive'],
            ['id' => 5, 'type_name' => 'motherboard'],
            ['id' => 6, 'type_name' => 'power_supply'],
            ['id' => 8, 'type_name' => 'case'],
        ]);

        // CPU: Intel Core i5-12400F (LGA1700, 65W)
        DB::table('components')->insert(['id' => 10, 'name' => 'Intel Core i5-12400F', 'type_id' => 1, 'base_price' => 3200000]);
        DB::table('cpus')->insert(['component_id' => 10, 'socket' => 'LGA1700', 'tdp' => 65]);

        // CPU: AMD Ryzen 5 5600X (AM4, 65W)
        DB::table('components')->insert(['id' => 11, 'name' => 'AMD Ryzen 5 5600X', 'type_id' => 1, 'base_price' => 3500000]);
        DB::table('cpus')->insert(['component_id' => 11, 'socket' => 'AM4', 'tdp' => 65]);

        // MB: ASUS Prime H610M-K D4 (LGA1700, DDR4)
        DB::table('components')->insert(['id' => 20, 'name' => 'ASUS Prime H610M-K D4', 'type_id' => 5, 'base_price' => 1800000]);
        DB::table('motherboards')->insert(['component_id' => 20, 'socket' => 'LGA1700', 'ddr_gen' => 4]);

        // MB: ASRock B450M-HDV (AM4, DDR4)
        DB::table('components')->insert(['id' => 21, 'name' => 'ASRock B450M-HDV', 'type_id' => 5, 'base_price' => 1500000]);
        DB::table('motherboards')->insert(['component_id' => 21, 'socket' => 'AM4', 'ddr_gen' => 4]);

        // RAM: DDR4 16GB (DDR4)
        DB::table('components')->insert(['id' => 30, 'name' => 'Kingston Fury Beast 16GB DDR4', 'type_id' => 3, 'base_price' => 1100000]);
        DB::table('memory')->insert(['component_id' => 30, 'capacity' => 16, 'ddr_gen' => 4]);

        // RAM: DDR5 16GB (DDR5)
        DB::table('components')->insert(['id' => 31, 'name' => 'Kingston Fury Beast 16GB DDR5', 'type_id' => 3, 'base_price' => 1500000]);
        DB::table('memory')->insert(['component_id' => 31, 'capacity' => 16, 'ddr_gen' => 5]);

        // VGA: RTX 3060 (170W)
        DB::table('components')->insert(['id' => 40, 'name' => 'ASUS Dual GeForce RTX 3060', 'type_id' => 2, 'base_price' => 7500000]);
        DB::table('video_cards')->insert(['component_id' => 40, 'tdp' => 170, 'chipset' => 'GeForce RTX 3060']);

        // Storage: SSD 500GB
        DB::table('components')->insert(['id' => 50, 'name' => 'Crucial P3 500GB SSD', 'type_id' => 4, 'base_price' => 900000]);
        DB::table('internal_hard_drives')->insert(['component_id' => 50, 'capacity' => 500, 'type' => 'SSD']);

        // PSU: 600W
        DB::table('components')->insert(['id' => 60, 'name' => 'EVGA 600 W2 80+ White', 'type_id' => 6, 'base_price' => 1000000]);
        DB::table('power_supplies')->insert(['component_id' => 60, 'wattage' => 600]);

        // PSU: 300W
        DB::table('components')->insert(['id' => 61, 'name' => 'Antec Atom 300W', 'type_id' => 6, 'base_price' => 500000]);
        DB::table('power_supplies')->insert(['component_id' => 61, 'wattage' => 300]);

        // Case: Kenoo
        DB::table('components')->insert(['id' => 70, 'name' => 'Kenoo T12 Matte Case', 'type_id' => 8, 'base_price' => 600000]);
        DB::table('cases')->insert(['component_id' => 70]);

        // Cheap components for low budget tests (Total ~ 3.2M)
        DB::table('components')->insert(['id' => 12, 'name' => 'AMD Athlon 200GE', 'type_id' => 1, 'base_price' => 800000]);
        DB::table('cpus')->insert(['component_id' => 12, 'socket' => 'AM4', 'tdp' => 35]);

        DB::table('components')->insert(['id' => 22, 'name' => 'MSI A320M-A Pro', 'type_id' => 5, 'base_price' => 900000]);
        DB::table('motherboards')->insert(['component_id' => 22, 'socket' => 'AM4', 'ddr_gen' => 4]);

        DB::table('components')->insert(['id' => 32, 'name' => 'Kingston Value 4GB DDR4', 'type_id' => 3, 'base_price' => 400000]);
        DB::table('memory')->insert(['component_id' => 32, 'capacity' => 4, 'ddr_gen' => 4]);

        DB::table('components')->insert(['id' => 51, 'name' => 'Gloway 120GB SSD', 'type_id' => 4, 'base_price' => 400000]);
        DB::table('internal_hard_drives')->insert(['component_id' => 51, 'capacity' => 120, 'type' => 'SSD']);

        DB::table('components')->insert(['id' => 62, 'name' => 'Xigmatek X-Power III 400W', 'type_id' => 6, 'base_price' => 400000]);
        DB::table('power_supplies')->insert(['component_id' => 62, 'wattage' => 400]);

        DB::table('components')->insert(['id' => 71, 'name' => 'Sama Office Case', 'type_id' => 8, 'base_price' => 300000]);
        DB::table('cases')->insert(['component_id' => 71]);
    }

    public function test_suggest_returns_error_when_budget_is_missing_or_too_low(): void
    {
        $response = $this->post('/builder/goi-y', ['needs' => 'gaming']);
        $response->assertSessionHasErrors(['budget']);

        $response = $this->post('/builder/goi-y', ['budget' => 3000000, 'needs' => 'gaming']);
        $response->assertSessionHasErrors(['budget']);
    }

    public function test_suggest_returns_error_when_needs_is_missing(): void
    {
        $response = $this->post('/builder/goi-y', ['budget' => 20000000]);
        $response->assertSessionHasErrors(['needs']);
    }

    public function test_suggest_redirects_back_with_error_when_api_key_is_missing(): void
    {
        $oldEnv = $_ENV['GEMINI_API_KEY'] ?? null;
        $oldServer = $_SERVER['GEMINI_API_KEY'] ?? null;
        unset($_ENV['GEMINI_API_KEY']);
        unset($_SERVER['GEMINI_API_KEY']);
        putenv('GEMINI_API_KEY');

        Http::fake([
            'https://generativelanguage.googleapis.com/*' => Http::response(['error' => 'Unauthorized'], 401)
        ]);

        $response = $this->post('/builder/goi-y', ['budget' => 20000000, 'needs' => 'gaming']);
        
        if ($oldEnv !== null) $_ENV['GEMINI_API_KEY'] = $oldEnv;
        if ($oldServer !== null) $_SERVER['GEMINI_API_KEY'] = $oldServer;
        putenv("GEMINI_API_KEY=fake_gemini_api_key");

        $response->assertRedirect();
        $response->assertSessionHas('error', 'Tính năng chưa được cấu hình (thiếu GEMINI_API_KEY trong file .env).');
    }

    public function test_suggest_success_with_valid_ai_response(): void
    {
        Http::fake([
            'https://generativelanguage.googleapis.com/*' => Http::response([
                'choices' => [
                    [
                        'message' => [
                            'content' => json_encode([
                                'builds' => [
                                    [
                                        'title' => 'Cấu hình gaming tốt',
                                        'build_type' => 'gaming',
                                        'components' => [
                                            'cpu' => 10,
                                            'mainboard' => 20,
                                            'ram' => 30,
                                            'vga' => 40,
                                            'storage' => 50,
                                            'psu' => 60,
                                            'case' => 70
                                        ],
                                        'explanation' => 'Cấu hình này sử dụng bộ vi xử lý tầm trung mạnh mẽ kết hợp cùng card đồ họa rời hiệu năng cao để đáp ứng mượt mà nhu cầu chơi game. RAM dung lượng lớn cùng ổ cứng SSD tốc độ cao giúp hệ thống khởi động nhanh và xử lý đa nhiệm trơn tru.'
                                    ]
                                ]
                            ])
                        ]
                    ]
                ]
            ], 200)
        ]);

        $response = $this->post('/builder/goi-y', ['budget' => 25000000, 'needs' => 'gaming']);
        $response->assertStatus(200);
        $response->assertViewHas('suggestedBuilds');

        $builds = $response->viewData('suggestedBuilds');
        $this->assertCount(1, $builds);
        $this->assertEquals('ai', $builds[0]['source']);
        $this->assertEquals(10, $builds[0]['components']['cpu']['id']);
        $this->assertEquals(20, $builds[0]['components']['mainboard']['id']);
        $this->assertEquals(30, $builds[0]['components']['ram']['id']);
        $this->assertEquals(40, $builds[0]['components']['vga']['id']);
    }

    public function test_suggest_fallback_when_cpu_socket_incompatible(): void
    {
        // CPU 11 (Ryzen - AM4) đi kèm MB 20 (Intel - LGA1700) -> Không tương thích socket
        Http::fake([
            'https://generativelanguage.googleapis.com/*' => Http::response([
                'choices' => [
                    [
                        'message' => [
                            'content' => json_encode([
                                'builds' => [
                                    [
                                        'title' => 'Cấu hình lỗi socket',
                                        'build_type' => 'gaming',
                                        'components' => [
                                            'cpu' => 11,
                                            'mainboard' => 20,
                                            'ram' => 30,
                                            'vga' => 40,
                                            'storage' => 50,
                                            'psu' => 60,
                                            'case' => 70
                                        ],
                                        'explanation' => 'Cấu hình gaming hiệu năng cao.'
                                    ]
                                ]
                            ])
                        ]
                    ]
                ]
            ], 200)
        ]);

        $response = $this->post('/builder/goi-y', ['budget' => 25000000, 'needs' => 'gaming']);
        $response->assertRedirect();
        $response->assertSessionHas('error');
        $this->assertStringContainsString('không tương thích vật lý', session()->get('error'));
    }

    public function test_suggest_fallback_when_ram_ddr_gen_incompatible(): void
    {
        // RAM 31 (DDR5) đi kèm MB 20 (Hỗ trợ DDR4) -> Không tương thích RAM
        Http::fake([
            'https://generativelanguage.googleapis.com/*' => Http::response([
                'choices' => [
                    [
                        'message' => [
                            'content' => json_encode([
                                'builds' => [
                                    [
                                        'title' => 'Cấu hình lỗi RAM',
                                        'build_type' => 'gaming',
                                        'components' => [
                                            'cpu' => 10,
                                            'mainboard' => 20,
                                            'ram' => 31,
                                            'vga' => 40,
                                            'storage' => 50,
                                            'psu' => 60,
                                            'case' => 70
                                        ],
                                        'explanation' => 'Cấu hình lỗi ddr_gen'
                                    ]
                                ]
                            ])
                        ]
                    ]
                ]
            ], 200)
        ]);

        $response = $this->post('/builder/goi-y', ['budget' => 25000000, 'needs' => 'gaming']);
        $response->assertRedirect();
        $response->assertSessionHas('error');
        $this->assertStringContainsString('không tương thích vật lý', session()->get('error'));
    }

    public function test_suggest_fallback_when_psu_wattage_insufficient(): void
    {
        // CPU 10 (65W) + VGA 40 (170W) + 220W = 455W > PSU 61 (300W) -> Không đủ công suất nguồn
        Http::fake([
            'https://generativelanguage.googleapis.com/*' => Http::response([
                'choices' => [
                    [
                        'message' => [
                            'content' => json_encode([
                                'builds' => [
                                    [
                                        'title' => 'Cấu hình thiếu nguồn',
                                        'build_type' => 'gaming',
                                        'components' => [
                                            'cpu' => 10,
                                            'mainboard' => 20,
                                            'ram' => 30,
                                            'vga' => 40,
                                            'storage' => 50,
                                            'psu' => 61,
                                            'case' => 70
                                        ],
                                        'explanation' => 'Cấu hình thiếu nguồn.'
                                    ]
                                ]
                            ])
                        ]
                    ]
                ]
            ], 200)
        ]);

        $response = $this->post('/builder/goi-y', ['budget' => 25000000, 'needs' => 'gaming']);
        $response->assertRedirect();
        $response->assertSessionHas('error');
        $this->assertStringContainsString('không tương thích vật lý', session()->get('error'));
    }

    public function test_suggest_fallback_when_total_price_exceeds_budget(): void
    {
        // Tổng tiền vượt ngân sách 20 triệu rất nhiều
        Http::fake([
            'https://generativelanguage.googleapis.com/*' => Http::response([
                'choices' => [
                    [
                        'message' => [
                            'content' => json_encode([
                                'builds' => [
                                    [
                                        'title' => 'Cấu hình vượt ngân sách',
                                        'build_type' => 'gaming',
                                        'components' => [
                                            'cpu' => 10,
                                            'mainboard' => 20,
                                            'ram' => 30,
                                            'vga' => 40,
                                            'storage' => 50,
                                            'psu' => 60,
                                            'case' => 70
                                        ],
                                        'explanation' => 'Cấu hình vượt budget.'
                                    ]
                                ]
                            ])
                        ]
                    ]
                ]
            ], 200)
        ]);

        $response = $this->post('/builder/goi-y', ['budget' => 5000000, 'needs' => 'gaming']);
        $response->assertRedirect();
        $response->assertSessionHas('error');
        $this->assertStringContainsString('vượt ngân sách', session()->get('error'));
    }

    public function test_suggest_handles_rate_limit_error_from_gemini(): void
    {
        Http::fake([
            'https://generativelanguage.googleapis.com/*' => Http::response([
                'error' => 'Rate limit exceeded'
            ], 429)
        ]);

        $response = $this->post('/builder/goi-y', ['budget' => 20000000, 'needs' => 'gaming']);
        $response->assertRedirect();
        $response->assertSessionHas('error');
        $this->assertStringContainsString('Lỗi phản hồi từ AI', session()->get('error'));
    }

    public function test_suggest_handles_rate_limit_error_with_exact_wait_time_from_gemini(): void
    {
        Http::fake([
            'https://generativelanguage.googleapis.com/*' => Http::response([
                'error' => [
                    'message' => 'Rate limit reached on tokens per day (TPD: Limit 100000, Used 98911, Requested 1470. Please try again in 5m29.184s.'
                ]
            ], 429)
        ]);

        $response = $this->post('/builder/goi-y', ['budget' => 20000000, 'needs' => 'gaming']);
        $response->assertRedirect();
        $response->assertSessionHas('error');
        $this->assertStringContainsString('Lỗi phản hồi từ AI', session()->get('error'));
    }

    public function test_suggest_handles_generic_error_from_gemini(): void
    {
        Http::fake([
            'https://generativelanguage.googleapis.com/*' => Http::response([
                'error' => 'Internal Server Error'
            ], 500)
        ]);

        $response = $this->post('/builder/goi-y', ['budget' => 20000000, 'needs' => 'gaming']);
        $response->assertRedirect();
        $response->assertSessionHas('error');
        $this->assertStringContainsString('Lỗi phản hồi từ AI', session()->get('error'));
    }

    public function test_suggest_uses_php_fallback_when_ai_response_is_invalid_json(): void
    {
        Http::fake([
            'https://generativelanguage.googleapis.com/*' => Http::response([
                'choices' => [
                    [
                        'message' => [
                            'content' => 'invalid_json_string'
                        ]
                    ]
                ]
            ], 200)
        ]);

        $response = $this->post('/builder/goi-y', ['budget' => 20000000, 'needs' => 'gaming']);
        $response->assertRedirect();
        $response->assertSessionHas('error');
        $this->assertStringContainsString('Lỗi phản hồi từ AI', session()->get('error'));
    }

    public function test_suggest_clean_cjk_characters(): void
    {
        // Gửi về tiêu đề có chữ Trung Quốc (游戏 / 运行) để test bộ làm sạch
        Http::fake([
            'https://generativelanguage.googleapis.com/*' => Http::response([
                'choices' => [
                    [
                        'message' => [
                            'content' => json_encode([
                                'builds' => [
                                    [
                                        'title' => 'Cấu hình 游戏 AAA',
                                        'build_type' => 'gaming',
                                        'components' => [
                                            'cpu' => 10,
                                            'mainboard' => 20,
                                            'ram' => 30,
                                            'vga' => 40,
                                            'storage' => 50,
                                            'psu' => 60,
                                            'case' => 70
                                        ],
                                        'explanation' => 'Hỗ trợ 运行 game mượt.'
                                    ]
                                ]
                            ])
                        ]
                    ]
                ]
            ], 200)
        ]);

        $response = $this->post('/builder/goi-y', ['budget' => 25000000, 'needs' => 'gaming']);
        $response->assertStatus(200);

        $builds = $response->viewData('suggestedBuilds');
        $this->assertCount(1, $builds);
        // "游戏" dịch sang "chơi game", "运行" dịch sang "chạy / vận hành"
        $this->assertStringContainsString('chơi game', $builds[0]['title']);
        $this->assertStringContainsString('chạy / vận hành', $builds[0]['explanation']);
    }

    public function test_apply_ai_build_to_session(): void
    {
        $response = $this->post('/builder/goi-y/apply', [
            'components' => [
                'cpu' => 10,
                'mainboard' => 20,
                'ram' => 30,
                'vga' => 40,
                'storage' => 50,
                'psu' => 60,
                'case' => 70
            ]
        ]);

        $response->assertRedirect();
        $response->assertSessionHas('success', 'Đã áp dụng cấu hình đề xuất!');

        $sessionBuild = session()->get('build_pc');
        $this->assertNotNull($sessionBuild);
        $this->assertEquals(10, $sessionBuild['cpu']['id']);
        $this->assertEquals('Intel Core i5-12400F', $sessionBuild['cpu']['name']);
        $this->assertEquals(20, $sessionBuild['mainboard']['id']);
        $this->assertEquals(30, $sessionBuild['ram']['id']);
    }



    public function test_suggest_fallback_when_high_end_cpu_paired_with_low_end_mainboard(): void
    {
        // Ghi đè thông tin CPU 10 thành i7-12700K (5.5M)
        DB::table('components')->where('id', 10)->update([
            'name' => 'Intel Core i7-12700K',
            'base_price' => 5500000
        ]);

        Http::fake([
            'https://generativelanguage.googleapis.com/*' => Http::response([
                'choices' => [
                    [
                        'message' => [
                            'content' => json_encode([
                                'builds' => [
                                    [
                                        'title' => 'Cấu hình lỗi mainboard',
                                        'build_type' => 'gaming',
                                        'components' => [
                                            'cpu' => 10,
                                            'mainboard' => 20, // H610
                                            'ram' => 30,
                                            'vga' => 40,
                                            'storage' => 50,
                                            'psu' => 60,
                                            'case' => 70
                                        ],
                                        'explanation' => 'Cấu hình lỗi mainboard.'
                                    ]
                                ]
                            ])
                        ]
                    ]
                ]
            ], 200)
        ]);

        $response = $this->post('/builder/goi-y', ['budget' => 25000000, 'needs' => 'gaming']);
        $response->assertRedirect();
        $response->assertSessionHas('error');
        $this->assertStringContainsString('không tương thích vật lý', session()->get('error'));
    }



    public function test_upgrade_build_adds_vga_and_upgrades_psu_wattage(): void
    {
        // Mock AI response without VGA, but PSU is initially PSU 61 (300W)
        Http::fake([
            'https://generativelanguage.googleapis.com/*' => Http::response([
                'choices' => [
                    [
                        'message' => [
                            'content' => json_encode([
                                'builds' => [
                                    [
                                        'title' => 'Cấu hình gaming không card',
                                        'build_type' => 'gaming',
                                        'components' => [
                                            'cpu' => 10,       // CPU 10 (65W)
                                            'mainboard' => 20, // MB 20 (LGA1700)
                                            'ram' => 30,       // DDR4 16GB
                                            'vga' => null,
                                            'storage' => 50,   // SSD 500GB
                                            'psu' => 61,       // PSU 61 (300W)
                                            'case' => 70
                                        ],
                                        'explanation' => 'Cấu hình gaming.'
                                    ]
                                ]
                            ])
                        ]
                    ]
                ]
            ], 200)
        ]);

        $response = $this->post('/builder/goi-y', [
            'budget' => 25000000,
            'needs' => 'gaming'
        ]);
        $response->assertStatus(200);

        $builds = $response->viewData('suggestedBuilds');
        $this->assertCount(1, $builds);
        $this->assertEquals('ai', $builds[0]['source']);

        // Phải được tự động thêm VGA 40 (RTX 3060, tdp 170W)
        $this->assertArrayHasKey('vga', $builds[0]['components']);
        $this->assertEquals(40, $builds[0]['components']['vga']['id']);

        // PSU phải được nâng cấp từ PSU 61 (300W) lên PSU 60 (600W) để đáp ứng 65 + 170 + 220 = 455W
        $this->assertEquals(60, $builds[0]['components']['psu']['id']);
    }
}


