import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserService {
  static const String _baseUrl = 'https://your-backend-url.com/api';
  static const _storage = FlutterSecureStorage();

  /// Obtiene el token JWT almacenado
  static Future<String?> _getToken() async {
    return await _storage.read(key: 'jwt_token');
  }

  /// Obtiene todos los usuarios desde el backend
  static Future<List<Map<String, dynamic>>> fetchUsers() async {
    final token = await _getToken();
    final response = await http.get(
      Uri.parse('$_baseUrl/users'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.cast<Map<String, dynamic>>();
    } else {
      throw Exception('Failed to load users');
    }
  }

  /// Edita un usuario (PUT /users/:id)
  static Future<bool> updateUser({
    required String id,
    required String name,
    required String role,
  }) async {
    final token = await _getToken();
    final response = await http.put(
      Uri.parse('$_baseUrl/users/$id'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'name': name,
        'role': role,
      }),
    );

    return response.statusCode == 200;
  }

  /// Banea un usuario (PATCH /users/:id/ban)
  static Future<bool> banUser(String id) async {
    final token = await _getToken();
    final response = await http.patch(
      Uri.parse('$_baseUrl/users/$id/ban'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    return response.statusCode == 200;
  }
}

