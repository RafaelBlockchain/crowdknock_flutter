import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:frontend_app/features/reports/models/report_model.dart';
import 'package:frontend_app/core/services/auth_interceptor.dart';

class ReportsService {
  final String baseUrl = dotenv.env['API_BASE_URL'] ?? 'http://localhost:3000';

  Future<List<Report>> getAllReports() async {
    final response = await http.get(
      Uri.parse('$baseUrl/reports'),
      headers: await AuthInterceptor.getHeaders(),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Report.fromJson(json)).toList();
    } else {
      throw Exception('Error al cargar los reportes');
    }
  }

  Future<void> updateReportStatus(String reportId, String status) async {
    final response = await http.patch(
      Uri.parse('$baseUrl/reports/$reportId'),
      headers: await AuthInterceptor.getHeaders(),
      body: jsonEncode({'status': status}),
    );

    if (response.statusCode != 200) {
      throw Exception('Error al actualizar el estado del reporte');
    }
  }

  Future<void> deleteReport(String reportId) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/reports/$reportId'),
      headers: await AuthInterceptor.getHeaders(),
    );

    if (response.statusCode != 200) {
      throw Exception('Error al eliminar el reporte');
    }
  }
}
