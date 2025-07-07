import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:frontend_app/core/constants/env.dart';
import 'package:frontend_app/features/system_status/models/system_status_model.dart';
import '../models/system_status_model.dart';
import '../../../core/constants/env.dart';

class SystemStatusService {
  Future<SystemStatus> fetchStatus() async {
    final response = await http.get(Uri.parse('$baseUrl/system/status'));
    final url = Uri.parse('$baseUrl/system/status');
    final res = await http.get(url, headers: {
      'Authorization': 'Bearer $jwtToken', // usa tu método JWT
    });

    if (res.statusCode == 200) {
      return SystemStatus.fromJson(json.decode(res.body));
    } else {
      throw Exception('Error al obtener estado del sistema');
    }
  }
}
