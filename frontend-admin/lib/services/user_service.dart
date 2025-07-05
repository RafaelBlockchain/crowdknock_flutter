import 'dart:convert';
import 'package:frontend_admin/services/api_client.dart';

class UserService {
  /// Obtiene todos los usuarios del backend
  static Future<List<Map<String, dynamic>>> getAllUsers() async {
    final response = await ApiClient.get('/users');

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.cast<Map<String, dynamic>>();
    } else {
      throw Exception('Error al cargar usuarios: ${response.body}');
    }
  }

  /// Actualiza la información de un usuario por ID
  static Future<void> updateUser(String id, Map<String, dynamic> updates) async {
    final response = await ApiClient.put('/users/$id', updates);

    if (response.statusCode != 200) {
      throw Exception('Error al actualizar usuario: ${response.body}');
    }
  }

  /// Banea a un usuario por ID
  static Future<void> banUser(String id) async {
    final response = await ApiClient.post('/users/$id/ban', {});

    if (response.statusCode != 200) {
      throw Exception('Error al banear usuario: ${response.body}');
    }
  }
}

