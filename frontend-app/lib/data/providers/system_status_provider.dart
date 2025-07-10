import 'package:flutter/material.dart';
import '../models/system_status_model.dart';
import '../../services/system_status_service.dart';

class SystemStatusProvider extends ChangeNotifier {
  SystemStatusModel? _status;
  bool _isLoading = false;
  String? _error;

  SystemStatusModel? get status => _status;
  bool get isLoading => _isLoading;
  String? get error => _error;

  /// Cargar estado del sistema desde el backend
  Future<void> loadSystemStatus() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final data = await SystemStatusService().getStatus();
      _status = data;
    } catch (e) {
      _error = 'Error al obtener el estado del sistema';
      _status = null;
    }

    _isLoading = false;
    notifyListeners();
  }

  /// Refrescar estado (alias público)
  Future<void> refresh() async {
    await loadSystemStatus();
  }
}

