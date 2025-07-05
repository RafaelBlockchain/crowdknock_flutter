import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:frontend_app/core/services/auth_service.dart';
import 'package:frontend_app/data/models/report.dart';

class ReportRepository {
  final String _baseUrl = dotenv.env['API_URL'] ?? 'http://localhost:3000';

  Future<List<Report>> getReports() async {
    final token = await AuthService.getToken();

    final response = await http.get(
      Uri.parse('$_baseUrl/api/reports'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Report.fromJson(json)).toList();
    } else {
      throw Exception('Error al obtener reportes');
    }
  }
}

