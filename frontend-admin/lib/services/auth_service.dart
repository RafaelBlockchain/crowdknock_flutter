import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'api_service.dart';

class AuthService {
  static const _storage = FlutterSecureStorage();
  static const _tokenKey = 'auth_token';

  static Future<String?> getToken() async {
    return await _storage.read(key: _tokenKey);
  }

  static Future<void> saveToken(String token) async {
    await _storage.write(key: _tokenKey, value: token);
  }

  static Future<void> clearToken() async {
    await _storage.delete(key: _tokenKey);
  }

  static Future<bool> isLoggedIn() async {
    final token = await getToken();
    if (token == null || JwtDecoder.isExpired(token)) return false;
    return true;
  }

  static Future<Map<String, dynamic>> login(String email, String password) async {
    final service = ApiService(
      baseUrl: 'https://api.crowdknock.com/api',
      jwtToken: '', // aún sin token para login
    );

    final response = await service.post('/auth/login', {
      'email': email,
      'password': password,
    });

    if (response['token'] == null) {
      throw Exception('Token no recibido del servidor');
    }

    await saveToken(response['token']);
    return JwtDecoder.decode(response['token']);
  }

  static Future<void> logout() async {
    await clearToken();
  }

  static Future<Map<String, dynamic>> getUserProfile() async {
    final token = await getToken();
    if (token == null) throw Exception('No hay token disponible');

    final service = ApiService(
      baseUrl: 'https://api.crowdknock.com/api',
      jwtToken: token,
    );

    return await service.get('/auth/profile');
  }
}

