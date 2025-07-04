import 'api_service.dart';

class ModerationService {
  final ApiService api;

  ModerationService(this.api);

  /// Obtener todos los reportes de contenido (videos, audios, historias)
  Future<List<dynamic>> fetchReportedContent() async {
    return await api.get('/admin/moderation/reported-content');
  }

  /// Obtener todos los comentarios reportados
  Future<List<dynamic>> fetchReportedComments() async {
    return await api.get('/admin/moderation/reported-comments');
  }

  /// Aprobar contenido reportado (ignorar el reporte)
  Future<void> approveReportedContent(String contentId) async {
    await api.put('/admin/moderation/content/$contentId/approve', {});
  }

  /// Eliminar contenido reportado (eliminarlo de la plataforma)
  Future<void> removeReportedContent(String contentId) async {
    await api.delete('/admin/moderation/content/$contentId');
  }

  /// Aprobar comentario reportado (ignorar el reporte)
  Future<void> approveReportedComment(String commentId) async {
    await api.put('/admin/moderation/comment/$commentId/approve', {});
  }

  /// Eliminar comentario reportado
  Future<void> removeReportedComment(String commentId) async {
    await api.delete('/admin/moderation/comment/$commentId');
  }

  /// Obtener detalle de un reporte específico (opcional)
  Future<Map<String, dynamic>> fetchReportDetails(String reportId) async {
    return await api.get('/admin/moderation/report/$reportId');
  }
}

