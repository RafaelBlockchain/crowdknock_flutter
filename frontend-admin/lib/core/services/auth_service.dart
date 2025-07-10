import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'api_service.dart';

class AuthService {
  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;
  AuthService._internal();

  final _api = ApiService();
  final _storage = const FlutterSecureStorage();

  static const _tokenKey = 'auth_token';

  Future<bool> login(String email, String password) async {
    final response = await _api.post('/auth/login', {
      'email': email,
      'password': password,
    });

    final data = jsonDecode(response.body);
    final token = data['token'];

    if (token != null) {
      await _storage.write(key: _tokenKey, value: token);
      _api.updateToken(token);
      return true;
    }

    return false;
  }

  Future<void> logout() async {
    await _storage.delete(key: _tokenKey);
    _api.updateToken('');
  }

  Future<bool> isLoggedIn() async {
    final token = await _storage.read(key: _tokenKey);
    if (token != null) {
      _api.updateToken(token);
      return true;
    }
    return false;
  }

  Future<String?> getToken() async {
    return await _storage.read(key: _tokenKey);
  }
}

