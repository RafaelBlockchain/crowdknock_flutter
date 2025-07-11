import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:frontend_admin/core/constants/api_routes.dart';
import 'package:frontend_admin/features/core/utils/http_client.dart';

class FeedbackService {
  final HttpClient _client = HttpClient();

  /// Obtiene todos los feedbacks enviados por usuarios
  Future<List<Map<String, dynamic>>> getAllFeedback() async {
    final http.Response res = await _client.get(ApiRoutes.feedbackAll); // Ej: /feedback/all

    if (res.statusCode == 200) {
      final List data = jsonDecode(res.body);
      return data.cast<Map<String, dynamic>>();
    } else {
      throw Exception('Error al cargar feedback');
    }
  }
}
