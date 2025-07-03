import 'package:flutter/material.dart';
import '../widgets/admin_sidebar.dart';
import '../widgets/admin_text_field.dart';

class AuditLogsScreen extends StatelessWidget {
  const AuditLogsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          const AdminSidebar(selected: 'Audit Logs'),

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Audit Logs',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 24),

                  // 🔎 Filtro de logs
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: const [BoxShadow(blurRadius: 2, color: Colors.black12)],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Filtrar registros', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                        const SizedBox(height: 16),
                        Wrap(
                          runSpacing: 12,
                          spacing: 12,
                          children: [
                            const SizedBox(
                              width: 250,
                              child: AdminTextField(
                                label: 'Usuario / Acción',
                                hintText: 'Buscar...',
                              ),
                            ),
                            SizedBox(
                              width: 200,
                              child: DropdownButtonFormField<String>(
                                value: 'All Actions',
                                items: const [
                                  DropdownMenuItem(value: 'All Actions', child: Text('Todas las acciones')),
                                  DropdownMenuItem(value: 'User Login', child: Text('Inicio de sesión')),
                                  DropdownMenuItem(value: 'Content Deleted', child: Text('Contenido eliminado')),
                                  DropdownMenuItem(value: 'Permission Updated', child: Text('Permisos actualizados')),
                                ],
                                onChanged: (_) {},
                                decoration: InputDecoration(
                                  labelText: 'Acción',
                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                                  contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 180,
                              child: AdminTextField(
                                label: 'Fecha',
                                hintText: 'YYYY-MM-DD',
                                keyboardType: TextInputType.datetime,
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                // Acción de aplicar filtros
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.indigo,
                                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                              ),
                              child: const Text('Aplicar Filtros'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),

                  // 📋 Tabla de logs
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: const [BoxShadow(blurRadius: 2, color: Colors.black12)],
                    ),
                    child: DataTable(
                      headingRowColor: MaterialStateColor.resolveWith((_) => Colors.grey[200]!),
                      columns: const [
                        DataColumn(label: Text('Fecha y hora')),
                        DataColumn(label: Text('Usuario')),
                        DataColumn(label: Text('Acción')),
                        DataColumn(label: Text('Detalle')),
                        DataColumn(label: Text('IP')),
                      ],
                      rows: const [
                        DataRow(cells: [
                          DataCell(Text('2025-06-28 14:32')),
                          DataCell(Text('admin@crowdknock.com')),
                          DataCell(Text('Inicio de sesión', style: TextStyle(color: Colors.indigo))),
                          DataCell(Text('Inicio de sesión exitoso')),
                          DataCell(Text('192.168.1.10')),
                        ]),
                        DataRow(cells: [
                          DataCell(Text('2025-06-28 13:11')),
                          DataCell(Text('mod@crowdknock.com')),
                          DataCell(Text('Contenido eliminado', style: TextStyle(color: Colors.red))),
                          DataCell(Text('Meme ID #43 eliminado por ofensas')),
                          DataCell(Text('192.168.1.23')),
                        ]),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
