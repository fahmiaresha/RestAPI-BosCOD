<?php

namespace App\Http\Controllers;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use App\Http\Controllers\Controller;
use JWTAuth;
use Tymon\JWTAuth\Exceptions\JWTException;
use Illuminate\Support\Facades\Validator;
use DB;
use Carbon\Carbon;

class TransferController extends Controller
{
    public function __construct()
    {
        $this->middleware('auth:api', ['except' => ['login','register']]);
    }
  
    public function transfer(Request $request){
        // buat validasi data inputan user
        $validator = Validator::make($request->all(), [
            'nilai_transfer' => 'required|numeric',
            'bank_tujuan' => 'required|string',
            'rekening_tujuan' => 'required|string',
            'atasnama_tujuan' => 'required|string',
            'bank_pengirim' => 'required|string',
        ]);

        // cek validasi
        if ($validator->fails()) {
            return response()->json($validator->errors(), 400);
        }

        // cek bank tujuan dan bank pengirim pada sistem
        $bank_tujuan = DB::table('bank')->where('nama_bank', $request->bank_tujuan)->first();
        $bank_pengirim = DB::table('bank')->where('nama_bank', $request->bank_pengirim)->first();

        // tampilkan error jika bank tujuan dan bank pengirim tidak terdaftar pada sistem
        $errors = [];
        if (!$bank_tujuan) {
            $errors[] = 'Bank tujuan tidak terdaftar pada sistem';
        }
        if (!$bank_pengirim) {
            $errors[] = 'Bank pengirim tidak terdaftar pada sistem';
        }
        if (!empty($errors)) {
            return response()->json(['error' => $errors], 401);
        }

        // ambil nama bank pengirim dari request input 
        $bank = DB::table('bank')->where('nama_bank', $request->bank_pengirim)->first();
       
        // ambil nomor rekening admin dari tabel rekening admin
        $rek_admin = DB::table('rekening_admin')->where('id_bank', $bank->id_bank)->first();
        $rek_perantara = $rek_admin->nomor_rekening;
        
        // ambil jumlah total tranksaksi dari tabel transaksi_transfer
        $counter = DB::table('transaksi_transfer')->whereDate('created_at','=',Carbon::today())->count()+1;
        
        // tampilkan eror jika jumlah total tranksaksi melebihi 5 digit
        if ($counter > 99999) {
            return response()->json(['error' => 'Counter telah melebihi 99999'], 401);
        }

        // generate id transaksi sesuai dengan format yang ditentukan
        $transaction_id = "TF" . date('ymd') . str_pad($counter, 5, '0', STR_PAD_LEFT);

        // generate kode unik
        $kode_unik = rand(100, 999);

        // hitung total transfer
        $biaya_admin = 0;
        $total_transfer = $request->nilai_transfer + $biaya_admin + $kode_unik;

        // set berlaku hingga sesuai format yang ditentukan pada waktu jakarta
        $datetime = Carbon::now('Asia/Jakarta');
        $berlaku_hingga = $datetime->toIso8601String();

        // simpan data ke tabel transaksi_transfer
        DB::table('transaksi_transfer')->insert([
            'id_transaksi' => $transaction_id,
            'nilai_transfer' => $request->nilai_transfer,
            'bank_tujuan' => $request->bank_tujuan,
            'rekening_tujuan' => $request->rekening_tujuan,
            'atasnama_tujuan' => $request->atasnama_tujuan,
            'bank_pengirim' => $request->bank_pengirim,
            'kode_unik' => $kode_unik,
            'biaya_admin' => $biaya_admin,
            'total_transfer' => $total_transfer,
            'bank_perantara' => $request->bank_pengirim,
            'rekening_perantara' => $rek_perantara,
            'berlaku_hingga' => $berlaku_hingga,
        ]);

        // kirim response yang dibutuhkan
        return response()->json([
            'id_transaksi' => $transaction_id,
            'nilai_transfer' => $request->nilai_transfer,
            'kode_unik' => $kode_unik,
            'biaya_admin' => $biaya_admin,
            'total_transfer' => $total_transfer,
            'bank_perantara' => $request->bank_pengirim,
            'rekening_perantara' => $rek_perantara,
            'berlaku_hingga' => $berlaku_hingga,
            ], 200);
    }

    
}
