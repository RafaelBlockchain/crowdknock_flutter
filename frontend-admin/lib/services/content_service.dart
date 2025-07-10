import 'package:frontend_admin/services/api_service.dart';
import 'package:frontend_admin/services/auth_service.dart';

class ContentService {
  static Future<ApiService> _api() async {
    final token = await AuthService.getToken();
    return ApiService(
      baseUrl: 'https://api.crowdknock.com/api',
      jwtToken: token ?? '',
    );
  }

  /// ✅ Obtiene todos los contenidos (videos, audios, historias)
  static Future<List<Map<String, dynamic>>> getAllContent() async {
    final api = await _api();
    final data = await api.get('/content');
    return List<Map<String, dynamic>>.from(data);
  }

  /// ✅ Sube nuevo contenido
  static Future<void> uploadContent(Map<String, dynamic> newContent) async {
    final api = await _api();
    await api.post('/content', newContent);
  }

  /// ✅ Edita metadatos de contenido por ID
  static Future<void> updateContent(String id, Map<String, dynamic> updates) async {
    final api = await _api();
    await api.put('/content/$id', updates);
  }

  /// ✅ Elimina contenido por ID
  static Future<void> deleteContent(String id) async {
    final api = await _api();
    await api.delete('/content/$id');
  }
}
