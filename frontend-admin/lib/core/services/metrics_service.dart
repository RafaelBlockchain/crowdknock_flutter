import 'dart:convert';
import 'package:http/http.dart' as http;
import 'api_service.dart';

class MetricsService {
  final ApiService _api = ApiService();

  Future<Map<String, dynamic>> fetchGlobalMetrics() async {
    final response = await _api.get('/metrics/global');
    return jsonDecode(response.body);
  }

  Future<List<Map<String, dynamic>>> fetchUserGrowthOverTime() async {
    final response = await _api.get('/metrics/user-growth');
    final List<dynamic> data = jsonDecode(response.body);
    return data.cast<Map<String, dynamic>>();
  }

  Future<List<Map<String, dynamic>>> fetchContentActivityStats() async {
    final response = await _api.get('/metrics/content-activity');
    final List<dynamic> data = jsonDecode(response.body);
    return data.cast<Map<String, dynamic>>();
  }

  Future<List<Map<String, dynamic>>> fetchTopCategories() async {
    final response = await _api.get('/metrics/top-categories');
    final List<dynamic> data = jsonDecode(response.body);
    return data.cast<Map<String, dynamic>>();
  }
}

