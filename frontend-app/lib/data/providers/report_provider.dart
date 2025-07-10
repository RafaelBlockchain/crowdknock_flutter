import 'package:flutter/material.dart';
import '../models/report_model.dart';
import '../../services/report_service.dart';

class ReportProvider extends ChangeNotifier {
  final List<ReportModel> _reports = [];
  bool _isLoading = false;
  String? _error;

  List<ReportModel> get reports => _reports;
  bool get isLoading => _isLoading;
  String? get error => _error;

  /// Carga los reportes desde el backend
  Future<void> loadReports() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final data = await ReportService().getAllReports();
      _reports
        ..clear()
        ..addAll(data);
    } catch (e) {
      _error = 'Error al cargar reportes';
    }

    _isLoading = false;
    notifyListeners();
  }

  /// Envía un nuevo reporte al backend
  Future<void> submitReport(ReportModel report) async {
    try {
      final created = await ReportService().submitReport(report);
      _reports.insert(0, created);
      notifyListeners();
    } catch (e) {
      _error = 'Error al enviar el reporte';
      notifyListeners();
    }
  }

  /// Filtrar reportes por tipo
  List<ReportModel> getReportsByType(String type) {
    return _reports.where((r) => r.reportType == type).toList();
  }
}

