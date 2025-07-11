// lib/core/services/audit_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:frontend_admin/core/constants/api_routes.dart';
import 'package:frontend_admin/features/core/utils/http_client.dart';

class AuditService {
  final HttpClient _client = HttpClient();

  Future<List<Map<String, dynamic>>> fetchAuditLogs() async {
    final res = await _client.get(ApiRoutes.auditLogs); // Ej: /audit/logs
    if (res.statusCode == 200) {
      final List data = jsonDecode(res.body);
      return data.cast<Map<String, dynamic>>();
    } else {
      throw Exception('Error al cargar logs');
    }
  }
}
