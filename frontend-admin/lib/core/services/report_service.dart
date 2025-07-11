import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:frontend_admin/core/constants/api_routes.dart';
import 'package:frontend_admin/features/core/utils/http_client.dart';

class ReportService {
  final HttpClient _client = HttpClient();

  /// Obtiene todos los reportes de usuarios
  Future<List<Map<String, dynamic>>> fetchUserReports() async {
    final http.Response res = await _client.get(ApiRoutes.userReports);

    if (res.statusCode == 200) {
      final List data = jsonDecode(res.body);
      return data.cast<Map<String, dynamic>>();
    } else {
      throw Exception('No se pudieron cargar los reportes');
    }
  }

  /// Marca un reporte como resuelto
  Future<void> resolveReport(String id) async {
    final http.Response res = await _client.post(
      ApiRoutes.resolveReport,
      body: jsonEncode({'id': id}),
      headers: {'Content-Type': 'application/json'},
    );

    if (res.statusCode != 200) {
      throw Exception('No se pudo resolver el reporte');
    }
  }
}
