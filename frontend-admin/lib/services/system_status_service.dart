import 'package:frontend_admin/services/api_service.dart';
import 'package:frontend_admin/services/auth_service.dart';

class SystemStatusService {
  static Future<ApiService> _api() async {
    final token = await AuthService.getToken();
    return ApiService(
      baseUrl: 'https://api.crowdknock.com/api',
      jwtToken: token ?? '',
    );
  }

  /// 🔄 Estado general del sistema
  static Future<Map<String, dynamic>> getSystemHealth() async {
    final api = await _api();
    final data = await api.get('/status/health');
    return Map<String, dynamic>.from(data);
  }

  /// 🧩 Estado de servicios internos (DB, Redis, Cola, etc.)
  static Future<List<Map<String, dynamic>>> getServiceStatuses() async {
    final api = await _api();
    final data = await api.get('/status/services');
    return List<Map<String, dynamic>>.from(data);
  }

  /// 📊 Métricas del servidor (CPU, Memoria, Conexiones, etc.)
  static Future<Map<String, dynamic>> getServerMetrics() async {
    final api = await _api();
    final data = await api.get('/status/server-metrics');
    return Map<String, dynamic>.from(data);
  }
}
