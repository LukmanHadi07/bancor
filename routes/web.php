<?php

use App\Http\Controllers\TambalbanController;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "web" middleware group. Make something great!
|
*/

Route::get('/', function () {
    return view('pages.auth.login');
});

Route::middleware(['auth', 'verified'])->group(function () {
    Route::get('home', function () {
        return view('pages.admin.dashboard', ['type_menu' => '']);
    })->name('home'); 
    route::resource('admin/tambalbanonline', TambalbanController::class);
    // route::resource('admin/category', CategoryController::class);
    // route::resource('admin/produk', ProdukController::class);
    // Route::get('admin/profile', [UserController::class, 'index'])->name('profile.index');
    // Route::get('admin/profile/edit', [UserController::class, 'edit'])->name('profile.edit');
    // Route::put('admin/profile/update', [UserController::class, 'update'])->name('profile.update');
});
