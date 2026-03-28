<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('video_cards', function (Blueprint $table) {
            $table->foreignId('component_id')->primary()->constrained('components')->cascadeOnDelete();
            $table->string('chipset')->nullable();
            $table->integer('memory')->nullable();
            $table->integer('core_clock')->nullable();
            $table->integer('boost_clock')->nullable();
            $table->string('color')->nullable();
            $table->integer('length')->nullable();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('video_cards');
    }
};
