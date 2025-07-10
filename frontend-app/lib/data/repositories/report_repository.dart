import '../models/report_model.dart';
import '../../services/report_service.dart';

class ReportRepository {
  final ReportService _service = ReportService();

  /// Obtener todos los reportes desde el backend
  Future<List<ReportModel>> fetchAllReports() async {
    return await _service.getAllReports();
  }

  /// Obtener reportes filtrados por tipo
  Future<List<ReportModel>> fetchReportsByType(String type) async {
    final all = await _service.getAllReports();
    return all.where((r) => r.reportType == type).toList();
  }

  /// Enviar un nuevo reporte
  Future<ReportModel> submitReport(ReportModel report) async {
    return await _service.submitReport(report);
  }
}

