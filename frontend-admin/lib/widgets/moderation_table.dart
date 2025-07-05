import 'package:flutter/material.dart';
import 'moderation_actions.dart';

class ModerationTable extends StatelessWidget {
  final List<Map<String, dynamic>> reports;

  const ModerationTable({super.key, required this.reports});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columns: const [
          DataColumn(label: Text('ID')),
          DataColumn(label: Text('Tipo')),
          DataColumn(label: Text('Reportado por')),
          DataColumn(label: Text('Razón')),
          DataColumn(label: Text('Fecha')),
          DataColumn(label: Text('Acciones')),
        ],
        rows: reports.map((report) {
          return DataRow(cells: [
            DataCell(Text(report['id'].toString())),
            DataCell(Text(report['type'] ?? '')),
            DataCell(Text(report['reportedBy'] ?? '')),
            DataCell(Text(report['reason'] ?? '')),
            DataCell(Text(report['date'] ?? '')),
            DataCell(ModerationActions(report: report)),
          ]);
        }).toList(),
      ),
    );
  }
}
