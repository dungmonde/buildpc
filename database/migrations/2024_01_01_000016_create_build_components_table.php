<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('build_components', function (Blueprint $table) {
            $table->id();
            $table->foreignId('build_id')->constrained('pc_builds')->cascadeOnDelete();
            $table->foreignId('component_id')->constrained('components')->cascadeOnDelete();
            $table->integer('quantity')->default(1);
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('build_components');
    }
};
