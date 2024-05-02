<?php

namespace App\Http\Controllers\ApiController;

use App\Http\Controllers\Controller;
use App\Models\Jasatambalbans;
use Illuminate\Http\Request;

class BancorApiController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        try {
            $tambalOnline = Jasatambalbans::all();
            if ( $tambalOnline->isEmpty()) {
                return response()->json([
                    'warning' => 'Tidak ada data jasa tambal ban online'
                ], 404);

            }
            return response()->json($tambalOnline, 200);
        } catch (\Throwable $th) {
            return response()->json(['message' => 'Berhasil mendapatkan data tambal ban online, namun terjadi kesalahan server'], 200);
        }
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        //
    }

    /**
     * Display the specified resource.
     */
    public function show(string $id)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, string $id)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        //
    }
}
