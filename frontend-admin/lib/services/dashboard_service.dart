import 'dart:convert';
import 'package:http/http.dart' as http;

class DashboardService {
  final String baseUrl;
  final String jwtToken;

  DashboardService({
    required this.baseUrl,
    required this.jwtToken,
  });

  Map<String, String> get _headers => {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $jwtToken',
      };

  /// Obtiene los datos principales del dashboard: total de usuarios, contenidos, reportes, etc.
  Future<Map<String, dynamic>> fetchDashboardStats() async {
    final response = await http.get(
      Uri.parse('$baseUrl/admin/dashboard/stats'),
      headers: _headers,
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('❌ Error fetching dashboard stats: ${response.body}');
    }
  }

  /// Obtiene actividad reciente de usuarios (inicios de sesión, publicaciones, etc.)
  Future<List<dynamic>> fetchRecentActivity() async {
    final response = await http.get(
      Uri.parse('$baseUrl/admin/dashboard/recent-activity'),
      headers: _headers,
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('❌ Error fetching recent activity: ${response.body}');
    }
  }

  /// Obtiene métricas por día para graficar (usuarios activos, publicaciones por día, etc.)
  Future<List<Map<String, dynamic>>> fetchDailyMetrics() async {
    final response = await http.get(
      Uri.parse('$baseUrl/admin/dashboard/daily-metrics'),
      headers: _headers,
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return List<Map<String, dynamic>>.from(data);
    } else {
      throw Exception('❌ Error fetching daily metrics: ${response.body}');
    }
  }
}

