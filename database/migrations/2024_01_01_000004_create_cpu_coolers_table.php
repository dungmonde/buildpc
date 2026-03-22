<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('cpu_coolers', function (Blueprint $table) {
            $table->foreignId('component_id')->primary()->constrained('components')->cascadeOnDelete();
            $table->integer('rpm')->nullable();
            $table->float('noise_level')->nullable();
            $table->string('color')->nullable();
            $table->integer('size')->nullable();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('cpu_coolers');
    }
};
