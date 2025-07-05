import 'package:flutter/material.dart';

class EditContentDialog extends StatefulWidget {
  final Map<String, dynamic> content;
  final Function(Map<String, dynamic>) onSave;

  const EditContentDialog({
    super.key,
    required this.content,
    required this.onSave,
  });

  @override
  State<EditContentDialog> createState() => _EditContentDialogState();
}

class _EditContentDialogState extends State<EditContentDialog> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late String _type;
  late String _status;

  @override
  void initState() {
    super.initState();
    _titleController =
        TextEditingController(text: widget.content['title'] ?? '');
    _descriptionController =
        TextEditingController(text: widget.content['description'] ?? '');
    _type = widget.content['type'] ?? 'Video';
    _status = widget.content['status'] ?? 'Draft';
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      final updatedContent = {
        ...widget.content,
        'title': _titleController.text.trim(),
        'description': _descriptionController.text.trim(),
        'type': _type,
        'status': _status,
      };
      widget.onSave(updatedContent);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('✏️ Editar contenido'),
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
                value: _type,
                decoration: const InputDecoration(labelText: 'Tipo'),
                items: const [
                  DropdownMenuItem(value: 'Video', child: Text('🎥 Video')),
                  DropdownMenuItem(value: 'Audio', child: Text('🎧 Audio')),
                  DropdownMenuItem(value: 'Story', child: Text('📖 Historia')),
                ],
                onChanged: (value) => setState(() => _type = value!),
              ),
              DropdownButtonFormField<String>(
                value: _status,
                decoration: const InputDecoration(labelText: 'Estado'),
                items: const [
                  DropdownMenuItem(value: 'Draft', child: Text('📝 Borrador')),
                  DropdownMenuItem(value: 'Published', child: Text('✅ Publicado')),
                  DropdownMenuItem(value: 'Archived', child: Text('📦 Archivado')),
                ],
                onChanged: (value) => setState(() => _status = value!),
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
          child: const Text('Guardar'),
        ),
      ],
    );
  }
}
