import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../models/user_model.dart';

class UserService {
  static final String baseUrl = dotenv.env['API_URL'] ?? 'http://localhost:3000/api';

  /// Crea un nuevo usuario
static Future<void> createUser(UserModel user) async {
  final response = await http.post(
    Uri.parse('$baseUrl/users'),
    headers: {
      'Authorization': 'Bearer ${await _getToken()}',
      'Content-Type': 'application/json',
    },
    body: jsonEncode(user.toJson()),
  );

  if (response.statusCode != 201) {
    throw Exception('Error al crear el usuario: ${response.body}');
  }
}

/// Actualiza un usuario existente por su ID
static Future<void> updateUser(String userId, Map<String, dynamic> updatedData) async {
  final response = await http.put(
    Uri.parse('$baseUrl/users/$userId'),
    headers: {
      'Authorization': 'Bearer ${await _getToken()}',
      'Content-Type': 'application/json',
    },
    body: jsonEncode(updatedData),
  );

  if (response.statusCode != 200) {
    throw Exception('Error al actualizar el usuario: ${response.body}');
  }
}


  /// Obtiene todos los usuarios del backend
  static Future<List<UserModel>> getAllUsers() async {
    final response = await http.get(
      Uri.parse('$baseUrl/users'),
      headers: {
        'Authorization': 'Bearer ${await _getToken()}',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(response.body);
      return jsonList.map((json) => UserModel.fromJson(json)).toList();
    } else {
      throw Exception('Error al obtener usuarios: ${response.body}');
    }
  }

  /// Elimina un usuario por su ID
  static Future<void> deleteUser(String userId) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/users/$userId'),
      headers: {
        'Authorization': 'Bearer ${await _getToken()}',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Error al eliminar el usuario: ${response.body}');
    }
  }

  static Future<void> deleteUser(String id) async {
  final response = await http.delete(
    Uri.parse('$_baseUrl/$id'),
    headers: {'Content-Type': 'application/json'},
  );

  if (response.statusCode != 200) {
    throw Exception('Error al eliminar el usuario');
  }
}

  /// Simulación de recuperación de token (deberías usar tu lógica real aquí)
  static Future<String> _getToken() async {
    // TODO: Reemplaza por tu lógica real para recuperar el JWT (ej: SharedPreferences)
    return 'tu_token_de_autenticacion';
  }
}
