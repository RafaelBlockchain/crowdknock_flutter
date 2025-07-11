import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:frontend_admin/core/constants/api_routes.dart';
import 'package:frontend_admin/features/core/utils/http_client.dart';

class EmailService {
  final HttpClient _client = HttpClient();

  /// Obtiene todas las plantillas de correo disponibles
  Future<List<Map<String, dynamic>>> fetchTemplates() async {
    final http.Response res = await _client.get(ApiRoutes.emailTemplates);

    if (res.statusCode == 200) {
      final List data = jsonDecode(res.body);
      return data.cast<Map<String, dynamic>>();
    } else {
      throw Exception('No se pudieron cargar las plantillas de correo');
    }
  }

  /// Actualiza una plantilla de correo electrónico por ID
  Future<void> updateTemplate(String id, String content) async {
    final http.Response res = await _client.post(
      ApiRoutes.updateEmailTemplate,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'id': id, 'content': content}),
    );

    if (res.statusCode != 200) {
      throw Exception('No se pudo actualizar la plantilla');
    }
  }
}
