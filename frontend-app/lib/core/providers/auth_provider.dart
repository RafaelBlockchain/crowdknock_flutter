import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:frontend_app/core/models/user_model.dart';
import 'package:frontend_app/config/api_config.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthProvider extends ChangeNotifier {
  final _storage = const FlutterSecureStorage();
  String? _token;
  UserModel? _user;

  String? get token => _token;
  UserModel? get user => _user;
  bool get isAuthenticated => _token != null && _user != null;

  /// Carga el token desde almacenamiento seguro al iniciar la app
  Future<void> loadSession() async {
    _token = await _storage.read(key: 'jwt_token');
    if (_token != null) {
      ApiConfig.setAuthToken(_token!);
      await _fetchProfile();
    }
  }

  /// Login con token directo (usualmente devuelto por AuthService.login)
  Future<void> login(String token) async {
    _token =_
