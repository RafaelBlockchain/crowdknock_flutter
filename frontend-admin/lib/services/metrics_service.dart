import 'package:frontend_admin/services/api_service.dart';
import 'package:frontend_admin/services/auth_service.dart';

class MetricsService {
  static Future<ApiService> _api() async {
    final token = await AuthService.getToken();
    return ApiService(
      baseUrl: 'https://api.crowdknock.com/api',
      jwtToken: token ?? '',
    );
  }

  /// 📊 Obtiene métricas generales de la app (usuarios, sesiones, crashes, etc)
  static Future<Map<String, dynamic>> getAppMetrics() async {
    final api = await _api();
    return await api.get('/metrics/app');
  }

  /// 📈 Usuarios activos por día (para gráficos)
  static Future<List<Map<String, dynamic>>> getDailyActiveUsers() async {
    final api = await _api();
    final data = await api.get('/metrics/daily-active-users');
    return List<Map<String, dynamic>>.from(data);
  }

  /// ⏱ Tiempo promedio de sesión por día
  static Future<List<Map<String, dynamic>>> getSessionDurations() async {
    final api = await _api();
    final data = await api.get('/metrics/session-duration');
    return List<Map<String, dynamic>>.from(data);
  }

  /// 🛑 Reportes de fallos (crashes y errores recientes)
  static Future<List<Map<String, dynamic>>> getCrashReports() async {
    final api = await _api();
    final data = await api.get('/metrics/crash-reports');
    return List<Map<String, dynamic>>.from(data);
  }
}
