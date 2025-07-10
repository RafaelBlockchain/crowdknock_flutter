import 'package:flutter/material.dart';
import '../widgets/content_table.dart';
import '../widgets/content_filters.dart';
import '../widgets/upload_content_dialog.dart';
import '../widgets/edit_content_dialog.dart';
import '../widgets/admin_scaffold.dart';

class ManageContentPage extends StatefulWidget {
  const ManageContentPage({super.key});

  @override
  State<ManageContentPage> createState() => _ManageContentPageState();
}

class _ManageContentPageState extends State<ManageContentPage> {
  List<Map<String, dynamic>> _contents = [];
  String? _filterType;
  String? _filterStatus;

  @override
  void initState() {
    super.initState();
    _loadDummyData();
  }

  void _loadDummyData() {
    _contents = [
      {
        'id': '1',
        'title': '🎬 Video de Bienvenida',
        'type': 'Video',
        'status': 'Published',
        'date': '2025-07-01',
      },
      {
        'id': '2',
        'title': '📖 Historia de Usuario',
        'type': 'Story',
        'status': 'Draft',
        'date': '2025-07-02',
      },
    ];
  }

  void _addContent(Map<String, dynamic> newContent) {
    setState(() {
      _contents.add(newContent);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('📤 Contenido subido exitosamente')),
    );
  }

  void _editContent(Map<String, dynamic> updatedContent) {
    setState(() {
      final index = _contents.indexWhere((c) => c['id'] == updatedContent['id']);
      if (index != -1) {
        _contents[index] = updatedContent;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('✅ Contenido actualizado')),
        );
      }
    });
  }

  void _deleteContent(String id) {
    setState(() {
      _contents.removeWhere((c) => c['id'] == id);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('🗑️ Contenido eliminado')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final filteredContents = _contents.where((c) {
      final matchType = _filterType == null || _filterType == 'Todos' || c['type'] == _filterType;
      final matchStatus = _filterStatus == null || _filterStatus == 'Todos' || c['status'] == _filterStatus;
      return matchType && matchStatus;
    }).toList();

    return AdminScaffold(
      title: '🎛️ Gestión de Contenido',
      currentRoute: '/manage-content',
      actions: [
        ElevatedButton.icon(
          icon: const Icon(Icons.add),
          label: const Text('Nuevo Contenido'),
          style: ElevatedButton.styleFrom(backgroundColor: Colors.indigo),
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => UploadContentDialog(onUpload: _addContent),
            );
          },
        ),
      ],
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ContentFilters(
              onTypeChanged: (value) => setState(() => _filterType = value),
              onStatusChanged: (value) => setState(() => _filterStatus = value),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: ContentTable(
                contents: filteredContents,
                onEdit: (content) {
                  showDialog(
                    context: context,
                    builder: (context) => EditContentDialog(
                      content: content,
                      onSave: _editContent,
                    ),
                  );
                },
                onDelete: _deleteContent,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
