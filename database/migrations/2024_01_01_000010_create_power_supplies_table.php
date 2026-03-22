<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('power_supplies', function (Blueprint $table) {
            $table->foreignId('component_id')->primary()->constrained('components')->cascadeOnDelete();
            $table->string('type')->nullable();
            $table->string('efficiency')->nullable();
            $table->integer('wattage')->nullable();
            $table->boolean('modular')->nullable();
            $table->string('color')->nullable();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('power_supplies');
    }
};
