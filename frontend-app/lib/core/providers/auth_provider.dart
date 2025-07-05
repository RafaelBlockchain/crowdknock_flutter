import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthProvider extends ChangeNotifier {
  final _storage = const FlutterSecureStorage();
  String? _token;

  String? get token => _token;
  bool get isAuthenticated => _token != null;

  Future<void> loadToken() async {
    _token = await _storage.read(key: 'jwt_token');
    notifyListeners();
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
