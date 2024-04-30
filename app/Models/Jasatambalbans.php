<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Jasatambalbans extends Model
{
    use HasFactory;


    protected $fillable = [
        'nama',
        'alamat',
        'noHp',
        'gambarJasaBancor',
        'longitude',
        'latitude',
        'harga',
    ];

}
