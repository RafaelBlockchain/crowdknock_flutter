import 'package:flutter/material.dart';

class ModerationTable extends StatelessWidget {
  const ModerationTable({super.key});

  @override
  Widget build(BuildContext context) {
    // Simulación de datos de moderación
    final List<Map<String, String>> reports = [
      {
        'id': '1',
        'type': 'Video',
        'reason': 'Contenido ofensivo',
        'status': 'Pendiente',
        'reportedBy': 'usuario123'
      },
      {
        'id': '2',
        'type': 'Comentario',
        'reason': 'Spam',
        'status': 'Pendiente',
        'reportedBy': 'moderador456'
      },
    ];

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: const [
            DataColumn(label: Text('ID')),
            DataColumn(label: Text('Tipo')),
            DataColumn(label: Text('Motivo')),
            DataColumn(label: Text('Reportado por')),
            DataColumn(label: Text('Estado')),
            DataColumn(label: Text('Acciones')),
          ],
          rows: reports.map((report) {
            return DataRow(
              cells: [
                DataCell(Text(report['id']!)),
                DataCell(Text(report['type']!)),
                DataCell(Text(report['reason']!)),
                DataCell(Text(report['reportedBy']!)),
                DataCell(Text(report['status']!)),
                DataCell(Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.check, color: Colors.green),
                      tooltip: 'Aprobar',
                      onPressed: () {
                        // Acción de aprobación
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, color: Colors.red),
                      tooltip: 'Rechazar',
                      onPressed: () {
                        // Acción de rechazo
                      },
                    ),
                  ],
                )),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}
