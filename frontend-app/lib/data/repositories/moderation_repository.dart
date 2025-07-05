import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:frontend_app/data/models/moderation_report.dart';
import 'package:frontend_app/core/services/auth_service.dart';

class ModerationRepository {
  final String _baseUrl = dotenv.env['API_URL'] ?? 'http://localhost:3000';

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
}
