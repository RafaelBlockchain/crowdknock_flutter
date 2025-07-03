import 'package:flutter/material.dart';

class TemplatesPage extends StatelessWidget {
  const TemplatesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Row(
        children: [
          // Sidebar de navegación
          Container(
            width: 260,
            color: Colors.white,
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'CrowdKnock Admin',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.indigo,
                  ),
                ),
                const SizedBox(height: 24),
                ..._sidebarItems.map((item) {
                  final isActive = item == 'Email Templates';
                  return _buildSidebarLink(item, isActive);
                }).toList(),
              ],
            ),
          ),

          // Contenido principal
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Email Templates',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 24),

                  // Tabla de plantillas disponibles
                  Card(
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Available Templates',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 16),
                          DataTable(
                            columns: const [
                              DataColumn(label: Text('Template Name')),
                              DataColumn(label: Text('Subject')),
                              DataColumn(label: Text('Last Updated')),
                              DataColumn(label: Text('Actions')),
                            ],
                            rows: [
                              _buildTemplateRow('Welcome Email', 'Welcome to CrowdKnock!', '2025-06-20'),
                              _buildTemplateRow('Password Reset', 'Reset Your Password', '2025-06-15'),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 32),

                  // Formulario para crear/editar plantilla
                  Card(
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Create / Edit Template',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 16),
                          TextField(
                            decoration: InputDecoration(
                              hintText: 'Template Name',
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                            ),
                          ),
                          const SizedBox(height: 16),
                          TextField(
                            decoration: InputDecoration(
                              hintText: 'Email Subject',
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                            ),
                          ),
                          const SizedBox(height: 16),
                          TextField(
                            maxLines: 10,
                            decoration: InputDecoration(
                              hintText: 'HTML or Text Content',
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                            ),
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: () {
                              // Guardar plantilla
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.indigo,
                              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                            ),
                            child: const Text('Save Template'),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  // Sidebar links
  Widget _buildSidebarLink(String title, bool active) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: TextButton(
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          backgroundColor: active ? Colors.indigo : Colors.transparent,
          foregroundColor: active ? Colors.white : Colors.black,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        ),
        onPressed: () {
          // TODO: Navegar o cambiar página según título
        },
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(title),
        ),
      ),
    );
  }

  // Fila de la tabla de plantillas
  DataRow _buildTemplateRow(String name, String subject, String date) {
    return DataRow(
      cells: [
        DataCell(Text(name)),
        DataCell(Text(subject)),
        DataCell(Text(date)),
        DataCell(Row(
          children: [
            TextButton(
              onPressed: () {
                // Editar plantilla
              },
              child: const Text('Edit', style: TextStyle(color: Colors.indigo)),
            ),
            TextButton(
              onPressed: () {
                // Eliminar plantilla
              },
              child: const Text('Delete', style: TextStyle(color: Colors.red)),
            ),
          ],
        )),
      ],
    );
  }

  List<String> get _sidebarItems => [
        'Dashboard',
        'Manage Users',
        'Manage Content',
        'Moderation',
        'Analytics',
        'Reports',
        'Payments',
        'Email Templates',
        'Settings',
        'Audit Logs',
        'System Status',
        'Admin Logins',
        'Role Management',
      ];
}
