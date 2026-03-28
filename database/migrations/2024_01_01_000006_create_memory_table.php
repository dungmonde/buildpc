<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('memory', function (Blueprint $table) {
            $table->foreignId('component_id')->primary()->constrained('components')->cascadeOnDelete();
            $table->integer('speed')->nullable();
            $table->integer('module_count')->nullable();
            $table->integer('module_size')->nullable();
            $table->float('price_per_gb')->nullable();
            $table->string('color')->nullable();
            $table->float('first_word_latency')->nullable();
            $table->integer('cas_latency')->nullable();
            $table->integer('capacity')->nullable();
            $table->integer('ddr_gen')->nullable();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('memory');
    }
};
