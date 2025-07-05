import 'package:flutter/material.dart';
import 'package:frontend_app/features/manage_content/widgets/content_table.dart';
import 'package:frontend_app/features/manage_content/widgets/content_filters.dart';
import 'package:frontend_app/features/manage_content/widgets/upload_content_dialog.dart';

class ManageContentScreen extends StatefulWidget {
  const ManageContentScreen({Key? key}) : super(key: key);

  @override
  State<ManageContentScreen> createState() => _ManageContentScreenState();
}

class _ManageContentScreenState extends State<ManageContentScreen> {
  String filterType = 'Todos';
  String filterStatus = 'Todos';

  void _openUploadDialog() {
    showDialog(
      context: context,
      builder: (_) => const UploadContentDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gestión de Contenido'),
        actions: [
          TextButton.icon(
            onPressed: _openUploadDialog,
            icon: const Icon(Icons.add),
            label: const Text('Nuevo Contenido'),
          ),
        ],
      ),
      body: Column(
        children: [
          ContentFilters(
            selectedType: filterType,
            selectedStatus: filterStatus,
            onFilterChanged: (type, status) {
              setState(() {
                filterType = type;
                filterStatus = status;
              });
            },
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ContentTable(
              filterType: filterType,
              filterStatus: filterStatus,
            ),
          ),
        ],
      ),
    );
  }
}
