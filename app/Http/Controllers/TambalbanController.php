<?php

namespace App\Http\Controllers;

use App\Models\Jasatambalbans;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;

class TambalbanController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index(Request $request)
{
    $perPage = 5; // Jumlah data per halaman

    // Mengambil data dengan paginasi
    $tambalOnline = Jasatambalbans::paginate($perPage);

    // Menambahkan nomor urut pada setiap data
    $index = ($tambalOnline->currentPage() - 1) * $tambalOnline->perPage() + 1;
    foreach ($tambalOnline as $item) {
        $item->index = $index++;
    }

    return view('pages.admin.tambalbanonline.index', compact('tambalOnline'));
}

    /**
     * Show the form for creating a new resource.
     */
    public function create(Request $request)
    {
        return view('pages.admin.tambalbanonline.create');
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        $this->validate($request, [
            'nama' => 'required|string|max:255',
            'alamat' => 'required|string',
            'noHp' => 'required|string|max:125',
            'gambarJasaBancor' => 'required|image|mimes:jpeg,jpg,png,gif,svg|max:10024',
            'longitude' => 'required|numeric',
            'latitude' => 'required|numeric',
            'harga' => 'required|string|max:25',
        ]);

         // handle path image
         $pathImage = $request->file('gambarJasaBancor')->store('public/upload/image');

         $imageFileName = basename($pathImage);
         $image = url("storage/upload/image/{$imageFileName}");

         $tambalOnline = New Jasatambalbans();
         $tambalOnline->nama = $request->input('nama');
         $tambalOnline->alamat = $request->input('alamat');
         $tambalOnline->noHp = $request->input('noHp');
         $tambalOnline->gambarJasaBancor = $image;
         $tambalOnline->longitude = $request->input('longitude');
         $tambalOnline->latitude = $request->input('latitude');
         $tambalOnline->harga = $request->input('harga');
         $tambalOnline->save();

         return redirect()->route('tambalbanonline.index');
    }

    
    /**
     * Display the specified resource.
     */
    public function show(string $id)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit($id)
    {
         $tambalOnline = Jasatambalbans::find($id);
         return view('pages.admin.tambalbanonline.edit', compact('tambalOnline'));
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request,  $id)
    {
        $this->validate($request, [
            'nama' => 'string|max:255',
            'alamat' => 'string',
            'noHp' => 'string|max:125',
            'gambarJasaBancor' => 'image|mimes:jpeg,jpg,png,gif,svg|max:10024',
            'longitude' => 'numeric',
            'latitude' => 'numeric',
            'harga' => 'string|max:25',
        ]);

        $tambalOnline = Jasatambalbans::find($id);
        if($request->hasFile('gambarJasaBancor')) {
            $request->validate(
                [
                    'gambarJasaBancor' => 'image|mimes:jpeg,jpg,png,gif,svg|max:10024',
                ]
                );

                $pathImage = $request->file('gambarJasaBancor')->store('public/upload/image');
                $originalExtension = $request->file('gambarJasaBancor')->getClientOriginalExtension();
                $imageFileName = pathinfo($pathImage, PATHINFO_FILENAME). '_' . time() . '.' . $originalExtension;

                Storage::move($pathImage, 'public/upload/image/' . $imageFileName);

                $url = asset("storage/upload/image/{$imageFileName}");

                $tambalOnline->gambarJasaBancor = $url;
        }

            $tambalOnline->nama = $request->input('nama');
            $tambalOnline->alamat = $request->input('alamat');
            $tambalOnline->noHp = $request->input('noHp');
            $tambalOnline->longitude = $request->input('longitude');
            $tambalOnline->latitude = $request->input('latitude');
            $tambalOnline->harga = $request->input('harga');
            $tambalOnline->save();

            return redirect()->route('tambalbanonline.index');




          
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy($id)
    {  
       $tambalOnline = Jasatambalbans::find($id);
       $tambalOnline->delete();
       return redirect()->route('tambalbanonline.index');
    }
}
