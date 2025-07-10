import 'package:flutter/material.dart';

class ContentTable extends StatelessWidget {
  final List<Map<String, dynamic>> contents;

  const ContentTable({super.key, required this.contents});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: const [
            DataColumn(label: Text('ID')),
            DataColumn(label: Text('Título')),
            DataColumn(label: Text('Tipo')),
            DataColumn(label: Text('Fecha')),
            DataColumn(label: Text('Estado')),
            DataColumn(label: Text('Acciones')),
          ],
          rows: contents.map((content) {
            return DataRow(
              cells: [
                DataCell(Text(content['id'].toString())),
                DataCell(Text(content['title'] ?? 'Sin título')),
                DataCell(Text(content['type'] ?? 'Desconocido')),
                DataCell(Text(content['createdAt'] ?? '')),
                DataCell(Text(
                  content['status'] ?? 'pendiente',
                  style: TextStyle(
                    color: _statusColor(content['status']),
                    fontWeight: FontWeight.bold,
                  ),
                )),
                DataCell(Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.visibility),
                      tooltip: 'Ver contenido',
                      onPressed: () {
                        // TODO: Mostrar modal o navegar a vista de detalle
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('🔍 Ver contenido')),
                        );
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.check_circle, color: Colors.green),
                      tooltip: 'Aprobar',
                      onPressed: () {
                        // TODO: Acción de aprobación
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('✅ Contenido aprobado')),
                        );
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      tooltip: 'Eliminar',
                      onPressed: () {
                        // TODO: Acción de eliminación
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('🗑 Contenido eliminado')),
                        );
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

  Color _statusColor(String? status) {
    switch (status) {
      case 'aprobado':
        return Colors.green;
      case 'pendiente':
        return Colors.orange;
      case 'rechazado':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}

