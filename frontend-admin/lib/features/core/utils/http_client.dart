import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:frontend_admin/core/constants/app_config.dart';
import 'package:frontend_admin/core/services/auth_service.dart';

class HttpClient {
  final String _baseUrl = AppConfig.baseUrl;
  final Duration _timeout = Duration(seconds: AppConfig.requestTimeout);

  Future<http.Response> get(String endpoint) async {
    final headers = await _buildHeaders();
    final uri = Uri.parse('$_baseUrl$endpoint');
    return http.get(uri, headers: headers).timeout(_timeout);
  }

  Future<http.Response> post(String endpoint, Map<String, dynamic> body) async {
    final headers = await _buildHeaders();
    final uri = Uri.parse('$_baseUrl$endpoint');
    return http
        .post(uri, headers: headers, body: jsonEncode(body))
        .timeout(_timeout);
  }

  Future<http.Response> put(String endpoint, Map<String, dynamic> body) async {
    final headers = await _buildHeaders();
    final uri = Uri.parse('$_baseUrl$endpoint');
    return http
        .put(uri, headers: headers, body: jsonEncode(body))
        .timeout(_timeout);
  }

  Future<http.Response> delete(String endpoint) async {
    final headers = await _buildHeaders();
    final uri = Uri.parse('$_baseUrl$endpoint');
    return http.delete(uri, headers: headers).timeout(_timeout);
  }

  Future<Map<String, String>> _buildHeaders() async {
    final token = await AuthService().getToken();
    return {
      'Content-Type': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };
  }
}

