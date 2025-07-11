import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:frontend_admin/core/constants/api_routes.dart';
import 'package:frontend_admin/features/core/utils/http_client.dart';

class LogService {
  final HttpClient _client = HttpClient();

  /// Obtiene los registros de actividad del sistema
  Future<List<Map<String, dynamic>>> fetchActivityLogs() async {
    final http.Response res = await _client.get(ApiRoutes.activityLogs); // Ej: '/logs/activity'

    if (res.statusCode == 200) {
      final List data = jsonDecode(res.body);
      return data.cast<Map<String, dynamic>>();
    } else {
      throw Exception('Error al obtener los logs de actividad');
    }
  }
}
