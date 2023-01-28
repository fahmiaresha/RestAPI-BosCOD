<?php

namespace App\Http\Controllers;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use App\Http\Controllers\Controller;
use App\User;
use JWTAuth;
use JWTFactory;
use Tymon\JWTAuth\Exceptions\JWTException;
use Illuminate\Support\Facades\Validator;
use Carbon\Carbon;
use Tymon\JWTAuth\Token;
use Tymon\JWTAuth\Contracts\JWTSubject;

class AuthController extends Controller
{
    public function __construct()
    {
        $this->middleware('auth:api', ['except' => ['login','register','update-token']]);
    }

    public function register(Request $request)
    {
         // buat validasi data inputan user
        $validator = Validator::make($request->all(), [
            'name' => 'required|string|max:255',
            'username' => 'required|string|max:255|unique:users',
            'password' => 'required',
        ]);

        // cek validasi
        if ($validator->fails()) {
            return response()->json($validator->errors(), 400);
        }

        // buat user baru
        $user = User::create([
            'name' => $request->get('name'),
            'username' => $request->get('username'),
            'password' => bcrypt($request->get('password')),
        ]);

        // tampilkan pesan jika user berhasil atau gagal dibuat
        if($user){
            return response()->json([
                'success' => true,
                'message' => 'User berhasil dibuat',
                'data' => $user
            ], 201);
        }else{
            return response()->json([
                'success' => false,
                'message' => 'User gagal dibuat',
                'data' => ''
            ], 400);
        }
    }

    public function login(Request $request){
        // validasi inputan user
        $credentials = $request->only('username', 'password');
        $validator = Validator::make($credentials, [
            'username' => 'required|string',
            'password' => 'required'
        ]);

        // cek validasi
        if ($validator->fails()) {
            return response()->json($validator->errors(), 400);
        }

        // cek login user
        if (!$token = auth()->attempt($credentials)) {
            return response()->json(['error' => 'Unauthorized'], 401);
        }

        // buat custom claim for the access token
        $access_claims = [
            'exp' => Carbon::now()->addMinutes(config('jwt.access_ttl'))->timestamp,
            'type' => 'access'
        ];

        // create custom claim for the refresh token
        $refresh_claims = [
            'exp' => Carbon::now()->addMinutes(config('jwt.refresh_ttl'))->timestamp,
            'type' => 'refresh'
        ];

        // add the custom claim to the token
        $access_token = JWTAuth::fromUser(auth()->user(), $access_claims);
        $refresh_token = JWTAuth::fromUser(auth()->user(), $refresh_claims);
        
        // return the token
        return $this->respondWithToken($access_token, $refresh_token);
    }

    protected function respondWithToken($access_token, $refresh_token = null)
    {
        // return acces token & refresh token
        return response()->json([
            'accessToken' => $access_token,
            'refreshToken' => $refresh_token
        ]);
    }

    public function updateToken(Request $request)
    {
        // dapatkan request token
        $refresh_token = $request->input('token');
        // bandingkan inputan token dengan token saat ini
        if(strcmp($refresh_token,JWTAuth::getToken()) == 0){
            // cek autentikasi user
            $user = JWTAuth::authenticate($refresh_token);
            // jika tidak ada, tampilkan pesan error
            if (!$user) {
                return response()->json(['error' => 'Invalid refresh token'], 401);
            }
            // set token yang baru
            $customClaims = [
                'exp' => Carbon::now()->addMinutes(config('jwt.access_ttl'))->timestamp,
                'type' => 'access'
            ];

            // buat access token yang baru
            $access_token = JWTAuth::fromUser($user, $customClaims);
            // buat refresh token yang baru
            $refresh_token = JWTAuth::fromUser($user, [
                    'exp' => Carbon::now()->addMinutes(config('jwt.refresh_ttl'))->timestamp,
                    'type' => 'refresh'
            ]);
        }
        return $this->respondWithToken($access_token, $refresh_token);
    }

    public function me()
    {
        // cek status login user
        return response()->json(auth()->user());        
    }

    public function logout()
    {
        // logout
        auth()->logout();
        return response()->json(['message' => 'Successfully logged out']);
    }
   
}
