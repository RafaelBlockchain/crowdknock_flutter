import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:frontend_app/core/utils/api_client.dart';

class AuthService {
  static const _secureStorage = FlutterSecureStorage();
  static final String _baseUrl = dotenv.env['API_URL'] ?? '';

  // ===========================
  // 🔐 Register
  // ===========================
  static Future<bool> register({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final response = await ApiClient.post('/auth/register', {
        'name': name,
        'email': email,
        'password': password,
      });

      return response.statusCode == 201;
    } catch (e) {
      print('Register error: $e');
      return false;
    }
  }

  // ===========================
  // 🔐 Login
  // ===========================
  static Future<bool> login(String email, String password) async {
    try {
      final url = Uri.parse('$_baseUrl/auth/login');

      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        final token = json['token'];
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('auth_token', token);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print('Login error: $e');
      return false;
    }
  }

  // ===========================
  // 🚪 Logout
  // ===========================
  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token');
  }

  // ===========================
  // 📥 Get Token
  // ===========================
  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }

  // ===========================
  // ✅ Is Logged In
  // ===========================
  static Future<bool> isLoggedIn() async {
    final token = await getToken();
    return token != null && token.isNotEmpty;
  }

  // ===========================
  // 🔄 Reset Password
  // ===========================
  Future<bool> resetPassword({
    required String token,
    required String newPassword,
  }) async {
    final url = Uri.parse('$_baseUrl/auth/reset-password');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'token': token,
        'password': newPassword,
      }),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Error al restablecer contraseña');
    }
  }
}
