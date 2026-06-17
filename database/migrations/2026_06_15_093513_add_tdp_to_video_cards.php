<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::table('video_cards', function (Blueprint $table) {
            $table->integer('tdp')->nullable()->after('length')
                  ->comment('Công suất tiêu thụ của VGA (Watt)');
        });
    }

    public function down(): void
    {
        Schema::table('video_cards', function (Blueprint $table) {
            $table->dropColumn('tdp');
        });
    }
};