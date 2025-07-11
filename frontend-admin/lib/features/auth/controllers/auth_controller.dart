import 'package:flutter/material.dart';
import 'package:frontend_admin/core/services/auth_service.dart';

class AuthController extends ChangeNotifier {
  final AuthService _authService = AuthService();

  bool _isAuthenticated = false;
  bool get isAuthenticated => _isAuthenticated;

  String? _error;
  String? get error => _error;

  Future<void> initializeSession() async {
    final isLogged = await _authService.isLoggedIn();
    _isAuthenticated = isLogged;
    notifyListeners();
  }

  Future<bool> login(String email, String password) async {
    try {
      final success = await _authService.login(email, password);
      _isAuthenticated = success;
      _error = success ? null : 'Credenciales inválidas';
      notifyListeners();
      return success;
    } catch (e) {
      _error = 'Error en el servidor o conexión';
      _isAuthenticated = false;
      notifyListeners();
      return false;
    }
  }

  Future<void> logout() async {
    await _authService.logout();
    _isAuthenticated = false;
    notifyListeners();
  }

  Future<String?> getToken() async {
    return await _authService.getToken();
  }
}

