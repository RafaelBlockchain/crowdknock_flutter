import 'package:flutter/material.dart';
import 'package:frontend_admin/core/constants/app_colors.dart';
import 'package:frontend_admin/core/layouts/admin_layout.dart';
import 'package:frontend_admin/core/services/report_service.dart';

class UserReportsScreen extends StatefulWidget {
  const UserReportsScreen({super.key});

  @override
  State<UserReportsScreen> createState() => _UserReportsScreenState();
}

class _UserReportsScreenState extends State<UserReportsScreen> {
  final ReportService _reportService = ReportService();
  List<Map<String, dynamic>> _reports = [];
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadReports();
  }

  Future<void> _loadReports() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final data = await _reportService.fetchUserReports();
      setState(() => _reports = data);
    } catch (e) {
      setState(() => _error = 'Error al cargar los reportes de usuarios.');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _resolveReport(String id) async {
    try {
      await _reportService.resolveReport(id);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('✅ Reporte marcado como resuelto'),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.green,
        ),
      );
      _loadReports(); // Refresh
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('❌ Error al resolver reporte: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AdminLayout(
      title: 'Reportes de Usuarios',
      child: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
              ? Center(child: Text(_error!, style: const TextStyle(color: Colors.red)))
              : _reports.isEmpty
                  ? const Center(child: Text('No hay reportes activos.'))
                  : SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        columns: const [
                          DataColumn(label: Text('ID')),
                          DataColumn(label: Text('Usuario')),
                          DataColumn(label: Text('Tipo')),
                          DataColumn(label: Text('Mensaje')),
                          DataColumn(label: Text('Fecha')),
                          DataColumn(label: Text('Acción')),
                        ],
                        rows: _reports.map((report) {
                          return DataRow(
                            cells: [
                              DataCell(Text(report['id'].toString())),
                              DataCell(Text(report['reported_user'] ?? 'Desconocido')),
                              DataCell(Text(report['reason'] ?? '-')),
                              DataCell(Text(report['details'] ?? '')),
                              DataCell(Text(report['created_at'] ?? '')),
                              DataCell(
                                ElevatedButton.icon(
                                  onPressed: () => _resolveReport(report['id'].toString()),
                                  icon: const Icon(Icons.check_circle, size: 16),
                                  label: const Text('Resolver'),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.green,
                                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                    textStyle: const TextStyle(fontSize: 12),
                                  ),
                                ),
                              ),
                            ],
                          );
                        }).toList(),
                      ),
                    ),
    );
  }
}
