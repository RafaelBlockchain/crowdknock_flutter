import 'package:flutter/material.dart';

class UploadContentDialog extends StatefulWidget {
  final Function(Map<String, dynamic>) onSubmit;

  const UploadContentDialog({super.key, required this.onSubmit});

  @override
  State<UploadContentDialog> createState() => _UploadContentDialogState();
}

class _UploadContentDialogState extends State<UploadContentDialog> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  String _selectedType = 'Video';

  void _submit() {
    if (_formKey.currentState!.validate()) {
      widget.onSubmit({
        'title': _titleController.text.trim(),
        'description': _descriptionController.text.trim(),
        'type': _selectedType,
        'status': 'Draft',
        'created_at': DateTime.now().toIso8601String(),
      });
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('⬆️ Subir nuevo contenido'),
      content: Form(
        key: _formKey,
        child: SizedBox(
          width: 400,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Título'),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Campo requerido' : null,
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Descripción'),
                maxLines: 2,
              ),
              DropdownButtonFormField<String>(
                value: _selectedType,
                items: const [
                  DropdownMenuItem(value: 'Video', child: Text('🎥 Video')),
                  DropdownMenuItem(value: 'Audio', child: Text('🎧 Audio')),
                  DropdownMenuItem(value: 'Story', child: Text('📖 Historia')),
                ],
                onChanged: (value) => setState(() => _selectedType = value!),
                decoration: const InputDecoration(labelText: 'Tipo de contenido'),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
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
