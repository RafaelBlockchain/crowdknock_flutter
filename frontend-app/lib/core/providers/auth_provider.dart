import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:frontend_app/core/models/auth_user.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthProvider extends ChangeNotifier {
  final _storage = const FlutterSecureStorage();
  String? _token;

  String? get token => _token;
  bool get isAuthenticated => _token != null;

  Future<void> loadToken() async {
    _token = await _storage.read(key: 'jwt_token');
    notifyListeners();
  }

  AuthUser? _currentUser;
AuthUser? get currentUser => _currentUser;

Future<void> fetchCurrentUser() async {
  if (_token == null) return;

  final res = await http.get(
    Uri.parse('$baseUrl/auth/me'),
    headers: {'Authorization': 'Bearer $_token'},
  );

  if (res.statusCode == 200) {
    final jsonData = json.decode(res.body);
    _currentUser = AuthUser.fromJson(jsonData);
    notifyListeners();
  } else {
    // Si falla, cerrar sesión
    await logout();
  }
}

  Future<void> login(String token) async {
    _token = token;
    await _storage.write(key: 'jwt_token', value: token);
    notifyListeners();
  }

  Future<void> logout() async {
    _token = null;
    await _storage.delete(key: 'jwt_token');
    notifyListeners();
  }
}
