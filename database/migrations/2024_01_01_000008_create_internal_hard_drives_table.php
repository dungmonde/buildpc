<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('internal_hard_drives', function (Blueprint $table) {
            $table->foreignId('component_id')->primary()->constrained('components')->cascadeOnDelete();
            $table->integer('capacity')->nullable();
            $table->float('price_per_gb')->nullable();
            $table->string('type')->nullable();
            $table->integer('cache')->nullable();
            $table->string('form_factor')->nullable();
            $table->string('interface')->nullable();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('internal_hard_drives');
    }
};
