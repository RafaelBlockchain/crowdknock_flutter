import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:frontend_admin/core/constants/api_routes.dart';
import 'package:frontend_admin/features/core/utils/http_client.dart';

class ContentService {
  final HttpClient _client = HttpClient();

  /// Obtiene todo el contenido enviado por los usuarios
  Future<List<Map<String, dynamic>>> fetchAllContent() async {
    final http.Response res = await _client.get(ApiRoutes.contentAll);

    if (res.statusCode == 200) {
      final List data = jsonDecode(res.body);
      return data.cast<Map<String, dynamic>>();
    } else {
      throw Exception('Error al obtener el contenido');
    }
  }

  /// Elimina un contenido por ID
  Future<void> deleteContent(String id) async {
    final http.Response res = await _client.delete('${ApiRoutes.contentById}/$id');

    if (res.statusCode != 200) {
      throw Exception('No se pudo eliminar el contenido');
    }
  }

  /// Aprueba o rechaza un contenido (moderación)
  Future<void> moderateContent({
    required String id,
    required String status, // 'approved', 'rejected'
    String? reason,
  }) async {
    final http.Response res = await _client.patch(
      '${ApiRoutes.contentById}/$id/moderate',
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'status': status,
        if (reason != null) 'reason': reason,
      }),
    );

    if (res.statusCode != 200) {
      throw Exception('Error al moderar el contenido');
    }
  }
}
