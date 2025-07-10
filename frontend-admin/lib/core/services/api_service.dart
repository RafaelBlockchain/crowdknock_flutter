import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static final ApiService _instance = ApiService._internal();
  factory ApiService() => _instance;
  ApiService._internal();

  String baseUrl = 'https://api.tu-backend.com'; // TODO: reemplaza con tu backend real
  String? _jwtToken;

  void updateToken(String token) {
    _jwtToken = token;
  }

  Map<String, String> get _headers => {
        'Content-Type': 'application/json',
        if (_jwtToken != null) 'Authorization': 'Bearer $_jwtToken',
      };

  Future<http.Response> get(String endpoint) async {
    final uri = Uri.parse('$baseUrl$endpoint');
    final response = await http.get(uri, headers: _headers);
    _checkStatus(response);
    return response;
  }

  Future<http.Response> post(String endpoint, Map<String, dynamic> body) async {
    final uri = Uri.parse('$baseUrl$endpoint');
    final response =
        await http.post(uri, headers: _headers, body: jsonEncode(body));
    _checkStatus(response);
    return response;
  }

  Future<http.Response> put(String endpoint, Map<String, dynamic> body) async {
    final uri = Uri.parse('$baseUrl$endpoint');
    final response =
        await http.put(uri, headers: _headers, body: jsonEncode(body));
    _checkStatus(response);
    return response;
  }

  Future<http.Response> delete(String endpoint) async {
    final uri = Uri.parse('$baseUrl$endpoint');
    final response = await http.delete(uri, headers: _headers);
    _checkStatus(response);
    return response;
  }

  void _checkStatus(http.Response response) {
    if (response.statusCode >= 400) {
      throw Exception(
        'Error ${response.statusCode}: ${response.reasonPhrase}\n${response.body}',
      );
    }
  }
}

