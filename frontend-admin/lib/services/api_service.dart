import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

class ApiService {
  final String baseUrl;
  final String jwtToken;

  ApiService({
    required this.baseUrl,
    required this.jwtToken,
  });

  Map<String, String> get _headers => {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $jwtToken',
      };

  Future<dynamic> get(String endpoint) async {
    final uri = Uri.parse('$baseUrl$endpoint');
    final response = await http.get(uri, headers: _headers);
    _logResponse('GET', uri, response);
    return _handleResponse(response);
  }

  Future<dynamic> post(String endpoint, Map<String, dynamic> data) async {
    final uri = Uri.parse('$baseUrl$endpoint');
    final response = await http.post(uri, headers: _headers, body: jsonEncode(data));
    _logResponse('POST', uri, response);
    return _handleResponse(response);
  }

  Future<dynamic> put(String endpoint, Map<String, dynamic> data) async {
    final uri = Uri.parse('$baseUrl$endpoint');
    final response = await http.put(uri, headers: _headers, body: jsonEncode(data));
    _logResponse('PUT', uri, response);
    return _handleResponse(response);
  }

  Future<dynamic> patch(String endpoint, Map<String, dynamic> data) async {
    final uri = Uri.parse('$baseUrl$endpoint');
    final response = await http.patch(uri, headers: _headers, body: jsonEncode(data));
    _logResponse('PATCH', uri, response);
    return _handleResponse(response);
  }

  Future<dynamic> delete(String endpoint) async {
    final uri = Uri.parse('$baseUrl$endpoint');
    final response = await http.delete(uri, headers: _headers);
    _logResponse('DELETE', uri, response);
    return _handleResponse(response);
  }

  dynamic _handleResponse(http.Response response) {
    final statusCode = response.statusCode;

    if (statusCode >= 200 && statusCode < 300) {
      return response.body.isNotEmpty ? jsonDecode(response.body) : null;
    } else {
      throw Exception('❌ Error ${response.statusCode} → ${response.body}');
    }
  }

  void _logResponse(String method, Uri uri, http.Response res) {
    if (kDebugMode) {
      debugPrint('[$method] ${uri.toString()} → ${res.statusCode}');
      if (res.statusCode >= 400) {
        debugPrint('❌ Body: ${res.body}');
      }
    }
  }
}
