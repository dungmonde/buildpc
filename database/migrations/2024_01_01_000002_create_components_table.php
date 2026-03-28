<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('components', function (Blueprint $table) {
            $table->id();
            $table->string('name');
            $table->foreignId('type_id')->constrained('component_types');
            $table->decimal('base_price', 10, 2)->nullable();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('components');
    }
};
