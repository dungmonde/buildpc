<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('cpus', function (Blueprint $table) {
            $table->foreignId('component_id')->primary()->constrained('components')->cascadeOnDelete();
            $table->integer('core_count')->nullable();
            $table->float('core_clock')->nullable();
            $table->float('boost_clock')->nullable();
            $table->string('microarchitecture')->nullable();
            $table->integer('tdp')->nullable();
            $table->string('graphics')->nullable();
            $table->string('socket')->nullable();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('cpus');
    }
};
