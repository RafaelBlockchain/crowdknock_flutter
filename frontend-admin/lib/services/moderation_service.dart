import 'package:frontend_admin/services/api_service.dart';
import 'package:frontend_admin/services/auth_service.dart';

class ModerationService {
  static Future<ApiService> _api() async {
    final token = await AuthService.getToken();
    return ApiService(
      baseUrl: 'https://api.crowdknock.com/api',
      jwtToken: token ?? '',
    );
  }

  /// 🧾 Obtener todos los reportes pendientes de moderación
  static Future<List<Map<String, dynamic>>> getPendingReports() async {
    final api = await _api();
    final data = await api.get('/moderation/reports');
    return List<Map<String, dynamic>>.from(data);
  }

  /// ✅ Aprobar contenido reportado
  static Future<void> approveReport(String reportId) async {
    final api = await _api();
    await api.post('/moderation/$reportId/approve', {});
  }

  /// 🗑 Eliminar contenido reportado
  static Future<void> deleteReportedContent(String reportId) async {
    final api = await _api();
    await api.post('/moderation/$reportId/delete', {});
  }

  /// 🚫 Ignorar reporte
  static Future<void> ignoreReport(String reportId) async {
    final api = await _api();
    await api.post('/moderation/$reportId/ignore', {});
  }
}

