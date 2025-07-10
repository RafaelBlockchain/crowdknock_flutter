import 'package:frontend_admin/services/api_service.dart';
import 'package:frontend_admin/services/auth_service.dart';

class ReportService {
  static Future<ApiService> _api() async {
    final token = await AuthService.getToken();
    return ApiService(
      baseUrl: 'https://api.crowdknock.com/api',
      jwtToken: token ?? '',
    );
  }

  /// 📥 Obtener todos los reportes de usuarios
  static Future<List<Map<String, dynamic>>> getUserReports() async {
    final api = await _api();
    final data = await api.get('/reports/users');
    return List<Map<String, dynamic>>.from(data);
  }

  /// ✅ Marcar reporte como resuelto
  static Future<bool> resolveReport(String reportId) async {
    final api = await _api();
    try {
      await api.post('/reports/$reportId/resolve', {});
      return true;
    } catch (_) {
      return false;
    }
  }

  /// 🗑 Eliminar reporte por ID
  static Future<bool> deleteReport(String reportId) async {
    final api = await _api();
    try {
      await api.delete('/reports/$reportId');
      return true;
    } catch (_) {
      return false;
    }
  }
}

