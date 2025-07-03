import 'package:flutter/material.dart';

class ReportsPage extends StatelessWidget {
  const ReportsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const _Sidebar(),
      appBar: AppBar(
        title: const Text('User Reports'),
        backgroundColor: Colors.indigo,
      ),
      backgroundColor: Colors.grey[100],
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: ListView(
          children: const [
            Text(
              'User Reports',
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

/// Sidebar modular reutilizable
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
          _SidebarItem(title: 'Manage Users', route: '/users'),
          _SidebarItem(title: 'Manage Content', route: '/content'),
          _SidebarItem(title: 'Moderation', route: '/moderation'),
          _SidebarItem(title: 'Analytics', route: '/analytics'),
          _SidebarItem(title: 'Reports', route: '/reports', isActive: true),
          _SidebarItem(title: 'Payments', route: '/payments'),
          _SidebarItem(title: 'Feedback', route: '/feedback'),
          _SidebarItem(title: 'Settings', route: '/settings'),
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
        Navigator.pushNamed(context, route);
      },
    );
  }
}

/// Tabla de reportes con diseño moderno y lista para conectar
class _ReportsTable extends StatelessWidget {
  const _ReportsTable({super.key});

  final List<List<String>> reports = const [
    ['1', 'user@example.com', 'Bug', 'Video no carga en mobile.', '2025-06-28'],
    ['2', 'another@user.com', 'Report Abuse', 'Contenido ofensivo en comentario', '2025-06-27'],
  ];

  final List<String> headers = const ['ID', 'User', 'Type', 'Message', 'Date', 'Action'];

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: headers
              .map((header) => DataColumn(
                    label: Text(
                      header,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ))
              .toList(),
          rows: reports.map((report) {
            return DataRow(cells: [
              ...report.map((value) => DataCell(Text(value))),
              DataCell(
                ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Report marked as resolved')),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    textStyle: const TextStyle(fontSize: 12),
                  ),
                  child: const Text('Resolve'),
                ),
              ),
            ]);
          }).toList(),
        ),
      ),
    );
  }
}
