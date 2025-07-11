import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:frontend_admin/core/constants/api_routes.dart';
import 'package:frontend_admin/features/core/utils/http_client.dart';

class ModerationService {
  final HttpClient _client = HttpClient();

  /// Obtiene contenido pendiente de aprobación
  Future<List<Map<String, dynamic>>> fetchPendingContent() async {
    final http.Response res = await _client.get(ApiRoutes.moderationPending);

    if (res.statusCode == 200) {
      final List data = jsonDecode(res.body);
      return data.cast<Map<String, dynamic>>();
    } else {
      throw Exception('No se pudo cargar contenido pendiente');
    }
  }

  /// Aprueba o rechaza contenido
  Future<void> moderateContent(String contentId, String action) async {
    final res = await _client.post(
      ApiRoutes.moderationAction,
      body: jsonEncode({
        'id': contentId,
        'action': action, // 'approve' o 'reject'
      }),
      headers: {'Content-Type': 'application/json'},
    );

    if (res.statusCode != 200) {
      throw Exception('Error al ejecutar acción de moderación');
    }
  }
}
