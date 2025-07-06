import 'package:flutter/material.dart';
import 'package:frontend_app/features/reports/widgets/report_table.dart';
import 'package:frontend_app/core/widgets/admin_scaffold.dart';
import 'package:frontend_app/features/reports/models/report_model.dart';
import 'package:frontend_app/features/reports/services/reports_service.dart';

class ReportsScreen extends StatelessWidget {
  const ReportsScreen({super.key});

  
  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  final ReportsService _reportsService = ReportsService();
  late Future<List<Report>> _reportsFuture;

  @override
  void initState() {
    super.initState();
    _reportsFuture = _reportsService.getAllReports();
  }

  Future<void> _refreshReports() async {
    setState(() {
      _reportsFuture = _reportsService.getAllReports();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Reportes del Sistema')),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: ReportTable(),
      ),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
      title: 'Reportes de Contenido',
      child: FutureBuilder<List<Report>>(
        future: _reportsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          final reports = snapshot.data!;
          if (reports.isEmpty) {
            return const Center(child: Text('No hay reportes activos.'));
          }

          return RefreshIndicator(
            onRefresh: _refreshReports,
            child: ListView(
              children: [
                DataTable(
                  columns: const [
                    DataColumn(label: Text('ID')),
                    DataColumn(label: Text('Tipo')),
                    DataColumn(label: Text('Contenido')),
                    DataColumn(label: Text('Motivo')),
                    DataColumn(label: Text('Estado')),
                    DataColumn(label: Text('Acciones')),
                  ],
                  rows: reports.map((report) {
                    return DataRow(cells: [
                      DataCell(Text(report.id)),
                      DataCell(Text(report.type)),
                      DataCell(Text(report.contentId)),
                      DataCell(Text(report.reason)),
                      DataCell(Text(report.status)),
                      DataCell(Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.check_circle_outline),
                            tooltip: 'Marcar como resuelto',
                            onPressed: report.status == 'resuelto'
                                ? null
                                : () async {
                                    await _reportsService.updateReportStatus(report.id, 'resuelto');
                                    _refreshReports();
                                  },
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete_outline),
                            tooltip: 'Eliminar reporte',
                            onPressed: () async {
                              final confirm = await showDialog<bool>(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: const Text('Eliminar reporte'),
                                  content: const Text('¿Estás seguro de eliminar este reporte?'),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context, false),
                                      child: const Text('Cancelar'),
                                    ),
                                    TextButton(
                                      onPressed: () => Navigator.pop(context, true),
                                      child: const Text('Eliminar'),
                                    ),
                                  ],
                                ),
                              );

                              if (confirm == true) {
                                await _reportsService.deleteReport(report.id);
                                _refreshReports();
                              }
                            },
                          ),
                        ],
                      )),
                    ]);
                  }).toList(),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Reportes del Sistema')),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: ReportTable(),
      ),
    );
  }
}

