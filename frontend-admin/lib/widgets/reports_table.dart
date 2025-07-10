import 'package:flutter/material.dart';

class ReportsTable extends StatelessWidget {
  final List<Map<String, dynamic>> reports;
  final void Function(String reportId)? onResolve;

  const ReportsTable({
    super.key,
    required this.reports,
    this.onResolve,
  });

  @override
  Widget build(BuildContext context) {
    if (reports.isEmpty) {
      return const Center(
        child: Text('No hay reportes disponibles.'),
      );
    }

    return Card(
      elevation: 2,
      child: SingleChildScrollView(
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
          rows: reports.map((report) {
            return DataRow(
              cells: [
                DataCell(Text(report['id'].toString())),
                DataCell(Text(report['user'] ?? 'N/A')),
                DataCell(Text(report['type'] ?? 'Desconocido')),
                DataCell(Text(report['message'] ?? '')),
                DataCell(Text(report['date'] ?? '')),
                DataCell(
                  ElevatedButton(
                    onPressed: () {
                      if (onResolve != null) {
                        onResolve!(report['id'].toString());
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('✅ Reporte marcado como resuelto'),
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      textStyle: const TextStyle(fontSize: 12),
                    ),
                    child: const Text('Resolver'),
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

