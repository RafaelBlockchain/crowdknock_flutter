import 'package:flutter/material.dart';
import '../widgets/admin_scaffold.dart';

class ContentModerationPage extends StatefulWidget {
  const ContentModerationPage({super.key});

  @override
  State<ContentModerationPage> createState() => _ContentModerationPageState();
}

class _ContentModerationPageState extends State<ContentModerationPage> {
  final List<Map<String, String>> _videos = [
    {
      'id': '1',
      'title': 'Summer Festival',
      'uploader': 'john@example.com',
    },
  ];

  final List<Map<String, String>> _audios = [
    {
      'id': '3',
      'title': 'Reggaeton Beat',
      'uploader': 'linda@example.com',
    },
  ];

  final List<Map<String, String>> _stories = [
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
        title: const Text('Eliminar contenido'),
        content: const Text('¿Estás seguro de que deseas eliminar este contenido?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
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

              // TODO: DELETE /api/content/:id con autenticación JWT
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('🗑️ Contenido eliminado')),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Eliminar'),
          ),
        ],
      ),
    );
  }

  void _handleAction(String id, String actionType) {
    // TODO: Abrir detalles desde el backend
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('📂 $actionType del contenido #$id')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
      title: '🛠️ Moderación de Contenido',
      currentRoute: '/moderation',
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Revisa y modera videos, audios e historias compartidas por la comunidad.',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 32),

            _buildSection('🎥 Videos', _videos, 'video', 'Ver'),
            const SizedBox(height: 32),

            _buildSection('🎧 Audios', _audios, 'audio', 'Previsualizar'),
            const SizedBox(height: 32),

            _buildSection('📖 Historias', _stories, 'story', 'Revisar'),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, List<Map<String, String>> data, String type, String actionLabel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        Card(
          child: DataTable(
            headingRowColor: MaterialStateProperty.resolveWith((_) => Colors.grey[200]),
            columns: const [
              DataColumn(label: Text('ID')),
              DataColumn(label: Text('Título')),
              DataColumn(label: Text('Usuario')),
              DataColumn(label: Text('Acciones')),
            ],
            rows: data.map((row) {
              return DataRow(
                cells: [
                  DataCell(Text(row['id']!)),
                  DataCell(Text(row['title']!)),
                  DataCell(Text(row['uploader']!)),
                  DataCell(Row(
                    children: [
                      IconButton(
                        onPressed: () => _handleAction(row['id']!, actionLabel),
                        icon: const Icon(Icons.remove_red_eye, color: Colors.blue),
                        tooltip: actionLabel,
                      ),
                      IconButton(
                        onPressed: () => _confirmDelete(row['id']!, type),
                        icon: const Icon(Icons.delete, color: Colors.red),
                        tooltip: 'Eliminar',
                      ),
                    ],
                  )),
                ],
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
