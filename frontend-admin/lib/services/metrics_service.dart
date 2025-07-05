import 'dart:convert';
import 'package:frontend_admin/services/api_client.dart';

class MetricsService {
  /// Obtiene métricas generales de la app
  static Future<Map<String, dynamic>> getAppMetrics() async {
    final response = await ApiClient.get('/metrics/app');

    if (response.statusCode == 200) {
      return jsonDecode(response.body) as Map<String, dynamic>;
    } else {
      throw Exception('Error al obtener métricas de la app: ${response.body}');
    }
  }

  /// Obtiene datos para los gráficos de usuarios activos por día
  static Future<List<Map<String, dynamic>>> getDailyActiveUsers() async {
    final response = await ApiClient.get('/metrics/daily-active-users');

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.cast<Map<String, dynamic>>();
    } else {
      throw Exception('Error al obtener usuarios activos diarios: ${response.body}');
    }
  }

  /// Obtiene el tiempo promedio de sesión por día
  static Future<List<Map<String, dynamic>>> getSessionDurations() async {
    final response = await ApiClient.get('/metrics/session-duration');

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.cast<Map<String, dynamic>>();
    } else {
      throw Exception('Error al obtener duración de sesión: ${response.body}');
    }
  }

  /// Obtiene cantidad de errores reportados (crashes, excepciones)
  static Future<List<Map<String, dynamic>>> getCrashReports() async {
    final response = await ApiClient.get('/metrics/crash-reports');

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.cast<Map<String, dynamic>>();
    } else {
      throw Exception('Error al obtener reportes de fallos: ${response.body}');
    }
  }
}
