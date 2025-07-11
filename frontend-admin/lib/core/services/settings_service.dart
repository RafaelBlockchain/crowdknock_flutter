import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:frontend_admin/core/constants/api_routes.dart';
import 'package:frontend_admin/features/core/utils/http_client.dart';

class SettingsService {
  final HttpClient _client = HttpClient();

  /// Obtiene la configuración actual del sistema
  Future<Map<String, dynamic>> fetchSettings() async {
    final http.Response res = await _client.get(ApiRoutes.getSettings);

    if (res.statusCode == 200) {
      return jsonDecode(res.body) as Map<String, dynamic>;
    } else {
      throw Exception('Error al obtener la configuración');
    }
  }

  /// Actualiza los valores de configuración
  Future<void> updateSettings(Map<String, dynamic> data) async {
    final http.Response res = await _client.post(
      ApiRoutes.updateSettings,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );

    if (res.statusCode != 200) {
      throw Exception('Error al actualizar la configuración');
    }
  }
}
