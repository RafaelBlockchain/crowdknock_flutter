import 'package:flutter/material.dart';

class ManageContentScreen extends StatefulWidget {
  const ManageContentScreen({super.key});

  @override
  State<ManageContentScreen> createState() => _ManageContentScreenState();
}

class _ManageContentScreenState extends State<ManageContentScreen> {
  List<Map<String, String>> _videos = [
    {
      'id': '1',
      'title': 'Summer Festival',
      'uploader': 'john@example.com',
    },
  ];

  List<Map<String, String>> _audios = [
    {
      'id': '3',
      'title': 'Reggaeton Beat',
      'uploader': 'linda@example.com',
    },
  ];

  List<Map<String, String>> _stories = [
    {
      'id': '12',
      'title': 'My Adventure',
      'uploader': 'mark@example.com',
    },
  ];

  void _confirmDelete(String id, String type) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Content'),
        content: const Text('Are you sure you want to delete this content?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                switch (type) {
                  case 'video':
                    _videos.removeWhere((item) => item['id'] == id);
                    break;
                  case 'audio':
                    _audios.removeWhere((item) => item['id'] == id);
                    break;
                  case 'story':
                    _stories.removeWhere((item) => item['id'] == id);
                    break;
                }
              });
              // TODO: DELETE /content/:id desde backend con JWT
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('🗑️ Content deleted')),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  void _handleAction(String id, String actionType) {
    // TODO: Mostrar detalles, vista previa o review desde backend
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('📂 $actionType content #$id')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const _Sidebar(),
      appBar: AppBar(
        title: const Text('🎛️ Manage Content'),
        backgroundColor: Colors.indigo,
      ),
      backgroundColor: Colors.grey[100],
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            const Text(
              'Content Moderation Panel',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),

            /// Videos Section
            const Text(
              '🎥 Videos',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            _ContentTable(
              rows: _videos,
              onDelete: (id) => _confirmDelete(id, 'video'),
              onAction: (id) => _handleAction(id, 'View'),
              actionLabel: 'View',
            ),

            const SizedBox(height: 32),

            /// Audios Section
            const Text(
              '🎧 Audios',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            _ContentTable(
              rows: _audios,
              onDelete: (id) => _confirmDelete(id, 'audio'),
              onAction: (id) => _handleAction(id, 'Preview'),
              actionLabel: 'Preview',
            ),

            const SizedBox(height: 32),

            /// Stories Section
            const Text(
              '📖 Stories',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            _ContentTable(
              rows: _stories,
              onDelete: (id) => _confirmDelete(id, 'story'),
              onAction: (id) => _handleAction(id, 'Review'),
              actionLabel: 'Review',
            ),
          ],
        ),
      ),
    );
  }
}

// Tabla de contenido modular
class _ContentTable extends StatelessWidget {
  final List<Map<String, String>> rows;
  final void Function(String id) onDelete;
  final void Function(String id) onAction;
  final String actionLabel;

  const _ContentTable({
    required this.rows,
    required this.onDelete,
    required this.onAction,
    required this.actionLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: DataTable(
        columns: const [
          DataColumn(label: Text('ID')),
          DataColumn(label: Text('Title')),
          DataColumn(label: Text('Uploader')),
          DataColumn(label: Text('Actions')),
        ],
        rows: rows.map((row) {
          return DataRow(
            cells: [
              DataCell(Text(row['id']!)),
              DataCell(Text(row['title']!)),
              DataCell(Text(row['uploader']!)),
              DataCell(Row(
                children: [
                  ElevatedButton(
                    onPressed: () => onDelete(row['id']!),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      textStyle: const TextStyle(fontSize: 12),
                    ),
                    child: const Text('Delete'),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () => onAction(row['id']!),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      textStyle: const TextStyle(fontSize: 12),
                    ),
                    child: Text(actionLabel),
                  ),
                ],
              )),
            ],
          );
        }).toList(),
      ),
    );
  }
}

// Sidebar persistente
class _Sidebar extends StatelessWidget {
  const _Sidebar();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          Text(
            'CrowdKnock Admin',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.indigo),
          ),
          SizedBox(height: 20),
          _SidebarItem(title: 'Dashboard', route: '/dashboard'),
          _SidebarItem(title: 'Manage Users', route: '/manage-users'),
          _SidebarItem(title: 'Manage Content', route: '/manage-content', isActive: true),
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
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      tileColor: isActive ? Colors.indigo[500] : null,
      textColor: isActive ? Colors.white : null,
      onTap: () {
        if (!isActive) {
          Navigator.pushNamed(context, route);
        } else {
          Navigator.pop(context); // Cierra el drawer
        }
      },
    );
  }
}
