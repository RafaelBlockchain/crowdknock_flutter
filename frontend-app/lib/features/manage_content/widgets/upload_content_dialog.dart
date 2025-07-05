import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class UploadContentDialog extends StatefulWidget {
  final Function(Map<String, dynamic>) onUpload;

  const UploadContentDialog({super.key, required this.onUpload});

  @override
  State<UploadContentDialog> createState() => _UploadContentDialogState();
}

class _UploadContentDialogState extends State<UploadContentDialog> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  String _selectedType = 'video';
  String _selectedStatus = 'pendiente';

  final List<String> _types = ['video', 'audio', 'historia'];
  final List<String> _statuses = ['pendiente', 'publicado', 'rechazado'];

  void _submit() {
    if (_formKey.currentState!.validate()) {
      final content = {
        'id': const Uuid().v4(),
        'title': _titleController.text.trim(),
        'type': _selectedType,
        'status': _selectedStatus,
        'createdAt': DateTime.now().toIso8601String(),
      };
      widget.onUpload(content);
      Navigator.of(context).pop();
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Subir nuevo contenido'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Título'),
              validator: (value) =>
                  value == null || value.isEmpty ? 'Ingrese un título' : null,
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              value: _selectedType,
              decoration: const InputDecoration(labelText: 'Tipo'),
              items: _types.map((type) {
                return DropdownMenuItem(value: type, child: Text(type));
              }).toList(),
              onChanged: (value) => setState(() => _selectedType = value!),
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              value: _selectedStatus,
              decoration: const InputDecoration(labelText: 'Estado'),
              items: _statuses.map((status) {
                return DropdownMenuItem(value: status, child: Text(status));
              }).toList(),
              onChanged: (value) => setState(() => _selectedStatus = value!),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancelar'),
        ),
        ElevatedButton(
          onPressed: _submit,
          child: const Text('Subir'),
        ),
      ],
    );
  }
}

