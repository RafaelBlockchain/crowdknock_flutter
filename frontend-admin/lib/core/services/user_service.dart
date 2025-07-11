import 'dart:convert';
import 'package:http/http.dart' as http;
import 'api_service.dart';

class UserService {
  final ApiService _api = ApiService();

  Future<List<Map<String, dynamic>>> fetchAllUsers() async {
    final response = await _api.get('/users');
    final List<dynamic> data = jsonDecode(response.body);
    return data.cast<Map<String, dynamic>>();
  }

  Future<Map<String, dynamic>> fetchUserById(int id) async {
    final response = await _api.get('/users/$id');
    return jsonDecode(response.body);
  }

  Future<bool> createUser(Map<String, dynamic> userData) async {
    final response = await _api.post('/users', userData);
    return response.statusCode == 201;
  }

  Future<bool> updateUser(int id, Map<String, dynamic> userData) async {
    final response = await _api.put('/users/$id', userData);
    return response.statusCode == 200;
  }

  Future<bool> deleteUser(int id) async {
    final response = await _api.delete('/users/$id');
    return response.statusCode == 200;
  }
}

