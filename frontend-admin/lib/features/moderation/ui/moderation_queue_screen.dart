import 'package:flutter/material.dart';
import 'package:crowdknock_admin/widgets/admin_scaffold.dart';

class ModerationQueueScreen extends StatelessWidget {
  const ModerationQueueScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
      title: '🛡️ Cola de Moderación',
      currentRoute: '/moderation',
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: ListView(
          children: [
            const Text(
              'Panel de Moderación',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 32),

            // 📽️ Videos reportados
            const Text(
              '🎥 Videos Reportados',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            _ModerationTable(
              columns: const ['ID', 'Título', 'Reportes', 'Acciones'],
              rows: const [
                ['101', 'Dance Battle', '3'],
              ],
            ),
            const SizedBox(height: 40),

            // 💬 Comentarios reportados
            const Text(
              '💬 Comentarios Reportados',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            _ModerationTable(
              columns: const ['ID', 'Comentario', 'Reportes', 'Acciones'],
              rows: const [
                ['205', '¡Este contenido es inapropiado!', '5'],
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ModerationTable extends StatelessWidget {
  final List<String> columns;
  final List<List<String>> rows;

  const _ModerationTable({
    required this.columns,
    required this.rows,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: columns.map((col) => DataColumn(label: Text(col))).toList(),
          rows: rows.map((row) {
            final id = row[0];
            final cells = row.sublist(0, row.length);
            return DataRow(
              cells: [
                ...cells.map((value) => DataCell(Text(value))),
                DataCell(Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('✅ Contenido #$id aprobado')),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        textStyle: const TextStyle(fontSize: 12),
                      ),
                      child: const Text('Aprobar'),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('🗑️ Contenido #$id eliminado')),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        textStyle: const TextStyle(fontSize: 12),
                      ),
                      child: const Text('Eliminar'),
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

