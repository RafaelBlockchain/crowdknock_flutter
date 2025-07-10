import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:frontend_app/data/models/moderation_report.dart';
import 'package:frontend_app/core/services/auth_service.dart';

class ModerationRepository {
  final String _baseUrl = dotenv.env['API_URL'] ?? 'http://localhost:3000';

  /// Obtener reportes con filtros opcionales por tipo o estado
  Future<List<ModerationReport>> getReports({String? type, String? status}) async {
    final token = await AuthService.getToken();

    final uri = Uri.parse('$_baseUrl/api/moderation').replace(queryParameters: {
      if (type != null) 'type': type,
      if (status != null) 'status': status,
    });

    final response = await http.get(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => ModerationReport.fromJson(json)).toList();
    } else {
      throw Exception('Error al cargar los reportes de moderación');
    }
  }

  /// Resolver un reporte (marcar como aprobado/resuelto)
  Future<void> resolveReport(String reportId, {required String resolutionNote}) async {
    final token = await AuthService.getToken();

    final uri = Uri.parse('$_baseUrl/api/moderation/$reportId/resolve');
    final response = await http.put(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({'note': resolutionNote}),
    );

    if (response.statusCode != 200) {
      throw Exception('Error al resolver el reporte');
    }
  }

  /// Rechazar un reporte
  Future<void> rejectReport(String reportId, {required String reason}) async {
    final token = await AuthService.getToken();

    final uri = Uri.parse('$_baseUrl/api/moderation/$reportId/reject');
    final response = await http.put(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({'reason': reason}),
    );

    if (response.statusCode != 200) {
      throw Exception('Error al rechazar el reporte');
    }
  }

  /// Eliminar contenido reportado
  Future<void> deleteReportedContent(String contentId) async {
    final token = await AuthService.getToken();

    final uri = Uri.parse('$_baseUrl/api/content/$contentId');
    final response = await http.delete(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Error al eliminar el contenido');
    }
  }
}
