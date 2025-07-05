import 'dart:convert';
import 'package:frontend_admin/services/api_client.dart';

class ModerationService {
  /// Obtiene todos los reportes pendientes
  static Future<List<Map<String, dynamic>>> getPendingReports() async {
    final response = await ApiClient.get('/moderation/reports');

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.cast<Map<String, dynamic>>();
    } else {
      throw Exception('Error al cargar reportes: ${response.body}');
    }
  }

  /// Aprueba el contenido reportado
  static Future<void> approveReport(String reportId) async {
    final response = await ApiClient.post('/moderation/$reportId/approve', {});

    if (response.statusCode != 200) {
      throw Exception('Error al aprobar reporte: ${response.body}');
    }
  }

  /// Elimina el contenido reportado
  static Future<void> deleteReportedContent(String reportId) async {
    final response = await ApiClient.post('/moderation/$reportId/delete', {});

    if (response.statusCode != 200) {
      throw Exception('Error al eliminar contenido reportado: ${response.body}');
    }
  }

  /// Ignora un reporte
  static Future<void> ignoreReport(String reportId) async {
    final response = await ApiClient.post('/moderation/$reportId/ignore', {});

    if (response.statusCode != 200) {
      throw Exception('Error al ignorar reporte: ${response.body}');
    }
  }
}

