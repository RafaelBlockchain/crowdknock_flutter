import '../models/content_model.dart';
import '../../services/content_service.dart';

class ContentRepository {
  final ContentService _service = ContentService();

  /// Obtener todos los contenidos del backend
  Future<List<ContentModel>> fetchAll() async {
    return await _service.getAll();
  }

  /// Crear nuevo contenido
  Future<ContentModel> create(ContentModel content) async {
    return await _service.createContent(content);
  }

  /// Actualizar contenido existente
  Future<ContentModel> update(ContentModel content) async {
    return await _service.updateContent(content);
  }

  /// Eliminar contenido por ID
  Future<void> delete(String id) async {
    return await _service.deleteContent(id);
  }

  /// Obtener contenido individual por ID
  Future<ContentModel> fetchById(String id) async {
    return await _service.getById(id);
  }
}

