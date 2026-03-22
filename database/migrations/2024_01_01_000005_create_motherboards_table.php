<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('motherboards', function (Blueprint $table) {
            $table->foreignId('component_id')->primary()->constrained('components')->cascadeOnDelete();
            $table->string('socket')->nullable();
            $table->string('form_factor')->nullable();
            $table->integer('max_memory')->nullable();
            $table->integer('memory_slots')->nullable();
            $table->string('color')->nullable();
            $table->integer('ddr_gen')->nullable();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('motherboards');
    }
};
