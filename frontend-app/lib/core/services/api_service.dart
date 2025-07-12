import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../config/api_config.dart';

class ApiService {
  static final ApiService _instance = ApiService._internal();
  factory ApiService() => _instance;
  ApiService._internal();

  final _storage = const FlutterSecureStorage();

  Future<String?> _getToken() async {
    return await _storage.read(key: 'access_token');
  }

  Future<Map<String, String>> _headers({bool auth = true}) async {
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    if (auth) {
      final token = await _getToken();
      if (token != null) {
        headers['Authorization'] = 'Bearer $token';
      }
    }

    return headers;
  }

  Future<dynamic> get(String endpoint, {bool auth = true}) async {
    final url = Uri.parse('${ApiConfig.baseUrl}$endpoint');
    final headers = await _headers(auth: auth);

    final response = await http.get(url, headers: headers);
    return _handleResponse(response);
  }

  Future<dynamic> post(String endpoint, dynamic body, {bool auth = true}) async {
    final url = Uri.parse('${ApiConfig.baseUrl}$endpoint');
    final headers = await _headers(auth: auth);

    final response = await http.post(
      url,
      headers: headers,
      body: jsonEncode(body),
    );
    return _handleResponse(response);
  }

  Future<dynamic> put(String endpoint, dynamic body, {bool auth = true}) async {
    final url = Uri.parse('${ApiConfig.baseUrl}$endpoint');
    final headers = await _headers(auth: auth);

    final response = await http.put(
      url,
      headers: headers,
      body: jsonEncode(body),
    );
    return _handleResponse(response);
  }

  Future<dynamic> delete(String endpoint, {bool auth = true}) async {
    final url = Uri.parse('${ApiConfig.baseUrl}$endpoint');
    final headers = await _headers(auth: auth);

    final response = await http.delete(url, headers: headers);
    return _handleResponse(response);
  }

  dynamic _handleResponse(http.Response response) {
    final statusCode = response.statusCode;
    final data = response.body.isNotEmpty ? jsonDecode(response.body) : null;

    if (statusCode >= 200 && statusCode < 300) {
      return data;
    } else {
      debugPrint('API Error: ${response.statusCode} - ${response.body}');
      throw ApiException(statusCode, data?['message'] ?? 'Error desconocido');
    }
  }
}

class ApiException implements Exception {
  final int statusCode;
  final String message;

  ApiException(this.statusCode, this.message);

  @override
  String toString() => 'ApiException [$statusCode]: $message';
}

