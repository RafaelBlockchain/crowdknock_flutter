import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class MetricsService {
  final String baseUrl;
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  MetricsService({required this.baseUrl});

  Future<String?> _getToken() async {
    return await _storage.read(key: 'jwt_token');
  }

  Future<Map<String, dynamic>?> getAppMetrics() async {
    try {
      final token = await _getToken();
      final response = await http.get(
        Uri.parse('$baseUrl/metrics/app'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        debugPrint('Error al obtener métricas: ${response.body}');
        return null;
      }
    } catch (e) {
      debugPrint('Excepción en getAppMetrics: $e');
      return null;
    }
  }

  Future<List<dynamic>> getCrashReports() async {
    try {
      final token = await _getToken();
      final response = await http.get(
        Uri.parse('$baseUrl/metrics/crashes'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        debugPrint('Error al obtener crash reports: ${response.body}');
        return [];
      }
    } catch (e) {
      debugPrint('Excepción en getCrashReports: $e');
      return [];
    }
  }
}

