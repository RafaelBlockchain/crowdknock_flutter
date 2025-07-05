import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:frontend_app/core/services/auth_service.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class DashboardRepository {
  static final String _baseUrl = dotenv.env['API_BASE_URL'] ?? 'http://localhost:3000';

  static Future<Map<String, dynamic>> fetchDashboardStats() async {
    final token = await AuthService.getToken();

    final response = await http.get(
      Uri.parse('$_baseUrl/api/dashboard'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Error al cargar estadísticas del dashboard');
    }
  }
}
