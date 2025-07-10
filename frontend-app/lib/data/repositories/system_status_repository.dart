import '../models/system_status_model.dart';
import '../../services/system_status_service.dart';

class SystemStatusRepository {
  final SystemStatusService _service = SystemStatusService();

  /// Obtener el estado actual del sistema desde el backend
  Future<SystemStatusModel> fetchStatus() async {
    return await _service.getStatus();
  }

  /// Forzar recarga o verificación (alias de fetch)
  Future<SystemStatusModel> refreshStatus() async {
    return await fetchStatus();
  }
}

