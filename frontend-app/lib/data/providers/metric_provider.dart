import 'package:flutter/material.dart';
import '../models/metric_model.dart';
import '../../services/metric_service.dart';

class MetricProvider extends ChangeNotifier {
  final List<MetricModel> _metrics = [];
  bool _isLoading = false;
  String? _error;

  List<MetricModel> get metrics => _metrics;
  bool get isLoading => _isLoading;
  String? get error => _error;

  /// Carga todas las métricas desde el backend
  Future<void> loadMetrics() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final data = await MetricService().getAllMetrics();
      _metrics
        ..clear()
        ..addAll(data);
    } catch (e) {
      _error = 'Error al cargar métricas';
    }

    _isLoading = false;
    notifyListeners();
  }

  /// Buscar una métrica específica por nombre
  MetricModel? getMetricByName(String name) {
    return _metrics.firstWhere((m) => m.name == name, orElse: () => null as MetricModel);
  }
}

