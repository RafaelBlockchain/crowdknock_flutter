import 'package:flutter/material.dart';
 
class UserReportsScreen extends StatelessWidget {
  const UserReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const _Sidebar(),
      appBar: AppBar(
        title: const Text('📨 Reportes de Usuarios'),
        backgroundColor: Colors.indigo,
      ),
      backgroundColor: Colors.grey[100],
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: ListView(
          children: const [
            Text(
              '📨 Reportes de Usuarios',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 32),
            _ReportsTable(),
          ],
        ),
      ),
    );
  }
}

// 🔹 Sidebar modular reutilizable
class _Sidebar extends StatelessWidget {
  const _Sidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
        children: const [
          Text(
            'CrowdKnock Admin',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.indigo,
            ),
          ),
          SizedBox(height: 32),
          _SidebarItem(title: 'Dashboard', route: '/dashboard'),
          _SidebarItem(title: 'Gestionar Usuarios', route: '/manage-users'),
          _SidebarItem(title: 'Gestionar Contenido', route: '/manage-content'),
          _SidebarItem(title: 'Moderación', route: '/moderation'),
          _SidebarItem(title: 'Métricas App', route: '/app-metrics'),
          _SidebarItem(title: 'Reportes', route: '/reports', isActive: true),
          _SidebarItem(title: 'Pagos', route: '/payments'),
          _SidebarItem(title: 'Feedback', route: '/feedback'),
          _SidebarItem(title: 'Configuración', route: '/settings'),
        ],
      ),
    );
  }
}

class _SidebarItem extends StatelessWidget {
  final String title;
  final String route;
  final bool isActive;

  const _SidebarItem({
    required this.title,
    required this.route,
    this.isActive = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: isActive ? Colors.indigo.shade100 : null,
      title: Text(
        title,
        style: TextStyle(
          color: isActive ? Colors.indigo : Colors.black,
          fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      onTap: () {
        if (!isActive) {
          Navigator.pushNamed(context, route);
        } else {
          Navigator.pop(context);
        }
      },
    );
  }
}

// 🔹 Tabla de reportes
class _ReportsTable extends StatelessWidget {
  const _ReportsTable({super.key});

  final List<List<String>> reports = const [
    ['1', 'user@example.com', 'Bug', 'El video no carga en móviles.', '2025-06-28'],
    ['2', 'another@user.com', 'Abuso', 'Contenido ofensivo en comentario.', '2025-06-27'],
  ];

  final List<String> headers = const ['ID', 'Usuario', 'Tipo', 'Mensaje', 'Fecha', 'Acción'];

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: headers
              .map(
                (header) => DataColumn(
                  label: Text(
                    header,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              )
              .toList(),
          rows: reports.map((report) {
            return DataRow(
              cells: [
                ...report.map((value) => DataCell(Text(value))),
                DataCell(
                  ElevatedButton.icon(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('✅ Reporte marcado como resuelto'),
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: Colors.green,
                        ),
                      );
                      // TODO: PATCH /user-reports/:id/resolve con JWT
                    },
                    icon: const Icon(Icons.check_circle, size: 16),
                    label: const Text('Resolver'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      textStyle: const TextStyle(fontSize: 12),
                    ),
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

