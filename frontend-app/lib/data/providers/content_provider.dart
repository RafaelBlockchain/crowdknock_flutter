import 'package:flutter/material.dart';
import '../models/content_model.dart';
import '../../services/content_service.dart';

class ContentProvider extends ChangeNotifier {
  final List<ContentModel> _contents = [];
  bool _isLoading = false;
  String? _error;

  List<ContentModel> get contents => _contents;
  bool get isLoading => _isLoading;
  String? get error => _error;

  /// Carga contenido desde el backend
  Future<void> loadContents() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final result = await ContentService().getAll();
      _contents
        ..clear()
        ..addAll(result);
    } catch (e) {
      _error = 'Error al cargar contenidos';
    }

    _isLoading = false;
    notifyListeners();
  }

  /// Agrega nuevo contenido a la lista
  void addContent(ContentModel content) {
    _contents.insert(0, content);
    notifyListeners();
  }

  /// Elimina contenido por ID
  void removeContent(String id) {
    _contents.removeWhere((item) => item.id == id);
    notifyListeners();
  }

  /// Actualiza contenido existente
  void updateContent(ContentModel updated) {
    final index = _contents.indexWhere((item) => item.id == updated.id);
    if (index != -1) {
      _contents[index] = updated;
      notifyListeners();
    }
  }
}

