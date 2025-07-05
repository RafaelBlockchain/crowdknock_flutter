import 'package:flutter/material.dart';
import '../widgets/content_table.dart';
import '../widgets/content_filters.dart';
import '../widgets/upload_content_dialog.dart';
import '../widgets/edit_content_dialog.dart';

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
        'title': 'Video de Bienvenida',
        'type': 'Video',
        'status': 'Published',
        'date': '2025-07-01',
      },
      {
        'id': '2',
        'title': 'Historia de Usuario',
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
      const SnackBar(content: Text('📤 Contenido subido')),
    );
  }

  void _editContent(Map<String, dynamic> updatedContent) {
    setState(() {
      final index =
          _contents.indexWhere((c) => c['id'] == updatedContent['id']);
      if (index != -1) {
        _contents[index] = updatedContent;
      }
    });
  }

  void _deleteContent(String id) {
    setState(() {
      _contents.removeWhere((c) => c['id'] == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final filteredContents = _contents.where((c) {
      final matchType = _filterType == null || c['type'] == _filterType;
      final matchStatus = _filterStatus == null || c['status'] == _filterStatus;
      return matchType && matchStatus;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('🎛️ Gestión de Contenido'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            tooltip: 'Subir contenido',
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => UploadContentDialog(
                  onUpload: _addContent,
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ContentFilters(
              onTypeChanged: (value) => setState(() => _filterType = value),
              onStatusChanged: (value) => setState(() => _filterStatus = value),
            ),
            const SizedBox(height: 16),
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
