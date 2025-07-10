import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ApiClient {
  static const String _baseUrl = 'https://api.crowdknock.com/api'; // ✅ cambia según entorno
  static String? _token;

  /// Establece el token JWT de sesión actual
  static void setToken(String token) {
    _token = token;
  }

  /// Limpia el token (logout)
  static void clearToken() {
    _token = null;
  }

  /// GET
  static Future<http.Response> get(String endpoint) async {
    final uri = Uri.parse('$_baseUrl$endpoint');
    final res = await http.get(uri, headers: _headers());
    _debugResponse('GET', uri.toString(), res);
    return res;
  }

  /// POST
  static Future<http.Response> post(String endpoint, Map<String, dynamic> body) async {
    final uri = Uri.parse('$_baseUrl$endpoint');
    final res = await http.post(uri, headers: _headers(), body: jsonEncode(body));
    _debugResponse('POST', uri.toString(), res);
    return res;
  }

  /// PUT
  static Future<http.Response> put(String endpoint, Map<String, dynamic> body) async {
    final uri = Uri.parse('$_baseUrl$endpoint');
    final res = await http.put(uri, headers: _headers(), body: jsonEncode(body));
    _debugResponse('PUT', uri.toString(), res);
    return res;
  }

  /// DELETE
  static Future<http.Response> delete(String endpoint) async {
    final uri = Uri.parse('$_baseUrl$endpoint');
    final res = await http.delete(uri, headers: _headers());
    _debugResponse('DELETE', uri.toString(), res);
    return res;
  }

  /// Headers con JWT
  static Map<String, String> _headers() {
    return {
      'Content-Type': 'application/json',
      if (_token != null) 'Authorization': 'Bearer $_token',
    };
  }

  /// Debug de respuesta
  static void _debugResponse(String method, String url, http.Response res) {
    debugPrint('[$method] $url → ${res.statusCode}');
    if (res.statusCode >= 400) {
      debugPrint('❌ Body: ${res.body}');
    }
  }
}
