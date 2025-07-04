import 'api_service.dart';

class ContentService {
  final ApiService api;

  ContentService(this.api);

  /// Obtener todos los contenidos (videos, audios, historias)
  Future<List<dynamic>> fetchAllContent() async {
    return await api.get('/admin/content');
  }

  /// Obtener contenido por tipo: video, audio, historia
  Future<List<dynamic>> fetchContentByType(String type) async {
    return await api.get('/admin/content/type/$type');
  }

  /// Aprobar contenido (PUT)
  Future<void> approveContent(String contentId) async {
    await api.put('/admin/content/$contentId/approve', {});
  }

  /// Rechazar contenido (PUT)
  Future<void> rejectContent(String contentId, {String reason = ''}) async {
    await api.put('/admin/content/$contentId/reject', {
      'reason': reason,
    });
  }

  /// Eliminar contenido (DELETE)
  Future<void> deleteContent(String contentId) async {
    await api.delete('/admin/content/$contentId');
  }

  /// Obtener detalles de un contenido específico
  Future<Map<String, dynamic>> getContentDetails(String contentId) async {
    return await api.get('/admin/content/$contentId');
  }

  /// Agregar nuevo contenido manualmente (opcional)
  Future<void> createContent(Map<String, dynamic> newContent) async {
    await api.post('/admin/content', newContent);
  }
}

