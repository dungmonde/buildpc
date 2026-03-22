<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('cases', function (Blueprint $table) {
            $table->foreignId('component_id')->primary()->constrained('components')->cascadeOnDelete();
            $table->string('type')->nullable();
            $table->string('color')->nullable();
            $table->integer('psu')->nullable();
            $table->string('side_panel')->nullable();
            $table->float('external_volume')->nullable();
            $table->integer('internal_35_bays')->nullable();
            // Lưu nhiều form factor: 'ATX,MicroATX,Mini ITX'
            $table->string('form_factor_support')->nullable();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('cases');
    }
};
