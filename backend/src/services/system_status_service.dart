import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SystemStatusService {
  static const String _baseUrl = 'https://your-backend-url.com/api';
  static final _storage = FlutterSecureStorage();

  /// Obtiene el token JWT almacenado
  static Future<String?> _getToken() async {
    return await _storage.read(key: 'jwt_token');
  }

  /// Obtiene el estado del sistema desde el backend
  static Future<Map<String, dynamic>> fetchStatus() async {
    final token = await _getToken();
    final response = await http.get(
      Uri.parse('$_baseUrl/system/status'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Error loading system status: ${response.body}');
    }
  }
}
