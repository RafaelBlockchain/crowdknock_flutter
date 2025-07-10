import '../models/metric_model.dart';
import '../../services/metric_service.dart';

class MetricRepository {
  final MetricService _service = MetricService();

  /// Obtener todas las métricas del sistema
  Future<List<MetricModel>> fetchAllMetrics() async {
    return await _service.getAllMetrics();
  }

  /// Obtener una métrica específica por su nombre
  Future<MetricModel?> fetchMetricByName(String name) async {
    try {
      final all = await _service.getAllMetrics();
      return all.firstWhere((m) => m.name == name, orElse: () => null);
    } catch (_) {
      return null;
    }
  }
}

