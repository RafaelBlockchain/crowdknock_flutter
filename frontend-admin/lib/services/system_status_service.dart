import 'dart:convert';
import 'package:http/http.dart' as http;

/// Modelo para representar el estado de un componente del sistema
class SystemComponentStatus {
  final String name;
  final bool status;
  final String lastChecked;

  SystemComponentStatus({
    required this.name,
    required this.status,
    required this.lastChecked,
  });

  factory SystemComponentStatus.fromJson(Map<String, dynamic> json) {
    return SystemComponentStatus(
      name: json['name'],
      status: json['status'],
      lastChecked: json['lastChecked'],
    );
  }
}

/// Servicio para obtener el estado del sistema desde el backend
class SystemStatusService {
  final String baseUrl;

  SystemStatusService({required this.baseUrl});

  Future<List<SystemComponentStatus>> fetchSystemStatus() async {
    final uri = Uri.parse('$baseUrl/api/system-status');

    try {
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        return jsonList
            .map((item) => SystemComponentStatus.fromJson(item))
            .toList();
      } else {
        throw Exception('Error al obtener el estado del sistema: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error al conectar con el servidor: $e');
    }
  }
}
