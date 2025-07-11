import 'package:flutter/material.dart';

class EditContentDialog extends StatefulWidget {
  final Map<String, dynamic> content;
  final Function(Map<String, dynamic>) onUpdate;

  const EditContentDialog({
    super.key,
    required this.content,
    required this.onUpdate,
  });

  @override
  State<EditContentDialog> createState() => _EditContentDialogState();
}

class _EditContentDialogState extends State<EditContentDialog> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late String _selectedType;
  late String _selectedStatus;

  final List<String> _types = ['video', 'audio', 'historia'];
  final List<String> _statuses = ['pendiente', 'publicado', 'rechazado'];

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.content['title']);
    _selectedType = widget.content['type'];
    _selectedStatus = widget.content['status'];
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      final updatedContent = {
        ...widget.content,
        'title': _titleController.text.trim(),
        'type': _selectedType,
        'status': _selectedStatus,
      };
      widget.onUpdate(updatedContent);
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
      title: const Text('Editar contenido'),
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
          child: const Text('Guardar cambios'),
        ),
      ],
    );
  }
}

