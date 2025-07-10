import 'package:flutter/material.dart';
import '../layout/admin_scaffold.dart';

class UserReportsScreen extends StatelessWidget {
  const UserReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
      title: '📨 Reportes de Usuarios',
      currentRoute: '/reports',
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              '📨 Reportes de Usuarios',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 32),
            Expanded(child: _UserReportsTable()),
          ],
        ),
      ),
    );
  }
}

class _UserReportsTable extends StatelessWidget {
  const _UserReportsTable({super.key});

  final List<List<String>> reports = const [
    ['1', 'user@example.com', 'Bug', 'El video no carga en móviles.', '2025-06-28'],
    ['2', 'another@user.com', 'Abuso', 'Contenido ofensivo en comentario.', '2025-06-27'],
  ];

  final List<String> headers = const ['ID', 'Usuario', 'Tipo', 'Mensaje', 'Fecha', 'Acción'];

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: headers
              .map(
                (h) => DataColumn(
                  label: Text(
                    h,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              )
              .toList(),
          rows: reports.map((report) {
            return DataRow(cells: [
              ...report.map((value) => DataCell(Text(value))),
              DataCell(
                ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('✅ Reporte marcado como resuelto'),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    textStyle: const TextStyle(fontSize: 12),
                  ),
                  child: const Text('Resolver'),
                ),
              ),
            ]);
          }).toList(),
        ),
      ),
    );
  }
}

