import 'package:flutter/material.dart';

class ContentModerationTable extends StatelessWidget {
  final List<Map<String, dynamic>> rows;

  const ContentModerationTable({super.key, required this.rows});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      clipBehavior: Clip.hardEdge,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          headingRowColor:
              MaterialStateProperty.all(Colors.grey.shade100),
          columns: const [
            DataColumn(label: Text('ID')),
            DataColumn(label: Text('Title')),
            DataColumn(label: Text('Uploader')),
            DataColumn(label: Text('Status')),
            DataColumn(label: Text('Actions')),
          ],
          rows: rows.map((row) {
            final String id = row['id']?.toString() ?? '-';
            final String title = row['title'] ?? 'Untitled';
            final String uploader = row['uploader'] ?? 'Unknown';
            final String status = row['status'] ?? 'Pending';
            return DataRow(
              cells: [
                DataCell(Text(id)),
                DataCell(Text(title)),
                DataCell(Text(uploader)),
                DataCell(Text(status,
                    style: TextStyle(
                      color: status == 'Approved'
                          ? Colors.green
                          : status == 'Rejected'
                              ? Colors.red
                              : Colors.orange,
                    ))),
                DataCell(Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        // Acción: Eliminar contenido
                      },
                      tooltip: 'Delete',
                      icon: const Icon(Icons.delete, color: Colors.red),
                    ),
                    IconButton(
                      onPressed: () {
                        // Acción: Vista previa o detalles
                      },
                      tooltip: 'Preview',
                      icon: const Icon(Icons.visibility, color: Colors.blue),
                    ),
                    IconButton(
                      onPressed: () {
                        // Acción: Aprobar contenido
                      },
                      tooltip: 'Approve',
                      icon: const Icon(Icons.check_circle, color: Colors.green),
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

