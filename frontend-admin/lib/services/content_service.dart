import 'dart:convert';
import 'package:frontend_admin/services/api_client.dart';

class ContentService {
  /// Obtiene todos los contenidos (videos, audios, historias)
  static Future<List<Map<String, dynamic>>> getAllContent() async {
    final response = await ApiClient.get('/content');

    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      return data.cast<Map<String, dynamic>>();
    } else {
      throw Exception('Error al cargar contenidos: ${response.body}');
    }
  }

  /// Sube un nuevo contenido
  static Future<void> uploadContent(Map<String, dynamic> newContent) async {
    final response = await ApiClient.post('/content', newContent);

    if (response.statusCode != 201) {
      throw Exception('Error al subir contenido: ${response.body}');
    }
  }

  /// Edita metadatos del contenido
  static Future<void> updateContent(String id, Map<String, dynamic> updates) async {
    final response = await ApiClient.put('/content/$id', updates);

    if (response.statusCode != 200) {
      throw Exception('Error al actualizar contenido: ${response.body}');
    }
  }

  /// Elimina contenido por ID
  static Future<void> deleteContent(String id) async {
    final response = await ApiClient.delete('/content/$id');

    if (response.statusCode != 200) {
      throw Exception('Error al eliminar contenido: ${response.body}');
    }
  }
}
