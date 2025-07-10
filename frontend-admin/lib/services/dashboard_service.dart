import 'package:frontend_admin/services/api_service.dart';
import 'package:frontend_admin/services/auth_service.dart';

class DashboardService {
  static Future<ApiService> _api() async {
    final token = await AuthService.getToken();
    return ApiService(
      baseUrl: 'https://api.crowdknock.com/api',
      jwtToken: token ?? '',
    );
  }

  /// 📊 Estadísticas principales del dashboard (usuarios, contenidos, reportes)
  static Future<Map<String, dynamic>> fetchDashboardStats() async {
    final api = await _api();
    return await api.get('/admin/dashboard/stats');
  }

  /// 🕵️‍♂️ Actividad reciente de usuarios (sesiones, acciones)
  static Future<List<dynamic>> fetchRecentActivity() async {
    final api = await _api();
    return await api.get('/admin/dashboard/recent-activity');
  }

  /// 📈 Métricas diarias (usuarios activos, publicaciones por día)
  static Future<List<Map<String, dynamic>>> fetchDailyMetrics() async {
    final api = await _api();
    final data = await api.get('/admin/dashboard/daily-metrics');
    return List<Map<String, dynamic>>.from(data);
  }
}

