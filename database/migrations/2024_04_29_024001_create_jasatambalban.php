<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('jasatambalbans', function (Blueprint $table) {

            $table->id();
            $table->string('nama');
            $table->text('alamat')->nullable();
            $table->string('noHp')->nullable();
            $table->string('gambarJasaBancor')->nullable();
            $table->double('longitude');
            $table->double('latitude');
            $table->string('harga');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('jasatambalban');
    }
};
