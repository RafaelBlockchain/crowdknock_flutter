import 'package:flutter/material.dart';

class ModerationPage extends StatelessWidget {
  const ModerationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const _Sidebar(), // Sidebar reutilizable
      appBar: AppBar(
        title: const Text('Moderation'),
        backgroundColor: Colors.indigo,
      ),
      backgroundColor: Colors.grey[100],
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: ListView(
          children: [
            const Text(
              'Moderation Queue',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 32),

            // Flagged Videos Section
            const Text(
              'Flagged Videos',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            _ModerationTable(
              columns: const ['ID', 'Title', 'Flags', 'Actions'],
              rows: const [
                ['101', 'Dance Battle', '3'],
              ],
            ),
            const SizedBox(height: 40),

            // Flagged Comments Section
            const Text(
              'Flagged Comments',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            _ModerationTable(
              columns: const ['ID', 'Comment', 'Flags', 'Actions'],
              rows: const [
                ['205', 'This is inappropriate!', '5'],
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// Sidebar común para navegación
class _Sidebar extends StatelessWidget {
  const _Sidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
        children: [
          const Text(
            'CrowdKnock Admin',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.indigo,
            ),
          ),
          const SizedBox(height: 32),
          _SidebarItem(title: 'Dashboard', route: '/dashboard'),
          _SidebarItem(title: 'Manage Users', route: '/users'),
          _SidebarItem(title: 'Manage Content', route: '/content'),
          _SidebarItem(title: 'Moderation', route: '/moderation', isActive: true),
          _SidebarItem(title: 'Analytics', route: '/analytics'),
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
        Navigator.pushNamed(context, route); // Requiere rutas definidas
      },
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
          columns: columns
              .map((col) => DataColumn(label: Text(col)))
              .toList(),
          rows: rows.map((row) {
            return DataRow(
              cells: [
                ...row.map((value) => DataCell(Text(value))),
                DataCell(Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Content approved')),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        textStyle: const TextStyle(fontSize: 12),
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                      ),
                      child: const Text('Approve'),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Content removed')),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        textStyle: const TextStyle(fontSize: 12),
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                      ),
                      child: const Text('Remove'),
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
