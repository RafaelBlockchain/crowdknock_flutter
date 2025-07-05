import 'dart:convert';
import 'package:frontend_admin/services/api_client.dart';

class SystemStatusService {
  /// Obtiene el estado general del sistema
  static Future<Map<String, dynamic>> getSystemHealth() async {
    final response = await ApiClient.get('/status/health');

    if (response.statusCode == 200) {
      return jsonDecode(response.body) as Map<String, dynamic>;
    } else {
      throw Exception('Error al obtener estado del sistema: ${response.body}');
    }
  }

  /// Verifica estado de servicios internos (base de datos, colas, cache, etc.)
  static Future<List<Map<String, dynamic>>> getServiceStatuses() async {
    final response = await ApiClient.get('/status/services');

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.cast<Map<String, dynamic>>();
    } else {
      throw Exception('Error al obtener estado de servicios: ${response.body}');
    }
  }

  /// Verifica estado de uso de recursos del servidor
  static Future<Map<String, dynamic>> getServerMetrics() async {
    final response = await ApiClient.get('/status/server-metrics');

    if (response.statusCode == 200) {
      return jsonDecode(response.body) as Map<String, dynamic>;
    } else {
      throw Exception('Error al obtener métricas del servidor: ${response.body}');
    }
  }
}
