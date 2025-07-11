import 'dart:convert';
import 'package:http/http.dart' as http;
import 'api_service.dart';

class ContentService {
  final ApiService _api = ApiService();

  Future<List<Map<String, dynamic>>> fetchAllContents() async {
    final response = await _api.get('/content');
    final List<dynamic> data = jsonDecode(response.body);
    return data.cast<Map<String, dynamic>>();
  }

  Future<Map<String, dynamic>> fetchContentById(int id) async {
    final response = await _api.get('/content/$id');
    return jsonDecode(response.body);
  }

  Future<bool> createContent(Map<String, dynamic> contentData) async {
    final response = await _api.post('/content', contentData);
    return response.statusCode == 201;
  }

  Future<bool> updateContent(int id, Map<String, dynamic> contentData) async {
    final response = await _api.put('/content/$id', contentData);
    return response.statusCode == 200;
  }

  Future<bool> deleteContent(int id) async {
    final response = await _api.delete('/content/$id');
    return response.statusCode == 200;
  }
}

