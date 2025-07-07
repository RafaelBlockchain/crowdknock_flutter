import 'package:flutter/material.dart';
import 'package:frontend_app/features/reports/models/report_model.dart';
import 'package:frontend_app/features/reports/services/reports_service.dart';

class ReportTable extends StatelessWidget {
  final List<Report> reports;
  final Future<void> Function() onRefresh;

  const ReportTable({
    super.key,
    required this.reports,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    final ReportsService reportsService = ReportsService();

    if (reports.isEmpty) {
      return const Center(child: Text('No hay reportes activos.'));
    }

    return RefreshIndicator(
      onRefresh: onRefresh,
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          DataTable(
            columnSpacing: 12,
            horizontalMargin: 8,
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
                              await reportsService.updateReportStatus(
                                report.id,
                                'resuelto',
                              );
                              onRefresh();
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
                            content: const Text(
                                '¿Estás seguro de eliminar este reporte?'),
                            actions: [
                              TextButton(
                                onPressed: () =>
                                    Navigator.pop(context, false),
                                child: const Text('Cancelar'),
                              ),
                              TextButton(
                                onPressed: () =>
                                    Navigator.pop(context, true),
                                child: const Text('Eliminar'),
                              ),
                            ],
                          ),
                        );

                        if (confirm == true) {
                          await reportsService.deleteReport(report.id);
                          onRefresh();
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
  }
}
