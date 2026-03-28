<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('compatibility_rules', function (Blueprint $table) {
            $table->id();
            $table->string('rule_name');
            $table->foreignId('component_type_a')->constrained('component_types');
            $table->foreignId('component_type_b')->constrained('component_types');
            $table->string('field_a');
            $table->string('field_b');
            $table->string('operator')->default('equals'); // equals, gte, lte
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('compatibility_rules');
    }
};
