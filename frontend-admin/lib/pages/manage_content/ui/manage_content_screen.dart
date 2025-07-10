import 'package:flutter/material.dart';
import '../../widgets/admin_scaffold.dart';
import '../../widgets/content_filters.dart';
import '../../widgets/content_table.dart';
import '../../widgets/upload_content_dialog.dart';
import '../../widgets/edit_content_dialog.dart';

class ManageContentScreen extends StatefulWidget {
  const ManageContentScreen({super.key});

  @override
  State<ManageContentScreen> createState() => _ManageContentScreenState();
}

class _ManageContentScreenState extends State<ManageContentScreen> {
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
        'status': 'Publicado',
        'date': '2025-07-01',
      },
      {
        'id': '2',
        'title': 'Historia de Usuario',
        'type': 'Story',
        'status': 'Borrador',
        'date': '2025-07-02',
      },
    ];
  }

  void _addContent(Map<String, dynamic> newContent) {
    setState(() => _contents.add(newContent));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('📤 Contenido subido')),
    );
  }

  void _editContent(Map<String, dynamic> updatedContent) {
    final index = _contents.indexWhere((c) => c['id'] == updatedContent['id']);
    if (index != -1) {
      setState(() => _contents[index] = updatedContent);
    }
  }

  void _deleteContent(String id) {
    setState(() => _contents.removeWhere((c) => c['id'] == id));
  }

  @override
  Widget build(BuildContext context) {
    final filteredContents = _contents.where((c) {
      final matchType = _filterType == null || c['type'] == _filterType;
      final matchStatus = _filterStatus == null || c['status'] == _filterStatus;
      return matchType && matchStatus;
    }).toList();

    return AdminScaffold(
      title: '🎛️ Gestión de Contenido',
      currentRoute: '/manage-content',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Filtra y administra tus contenidos multimedia.',
                style: TextStyle(color: Colors.grey),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (_) => UploadContentDialog(onUpload: _addContent),
                  );
                },
                icon: const Icon(Icons.add),
                label: const Text('Subir contenido'),
              ),
            ],
          ),
          const SizedBox(height: 20),
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
                  builder: (_) => EditContentDialog(
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
    );
  }
}
