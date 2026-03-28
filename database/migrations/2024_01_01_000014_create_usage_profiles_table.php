<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('usage_profiles', function (Blueprint $table) {
            $table->id();
            $table->string('profile_name');
            $table->text('description')->nullable();
            $table->json('logic_rules')->nullable();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('usage_profiles');
    }
};
