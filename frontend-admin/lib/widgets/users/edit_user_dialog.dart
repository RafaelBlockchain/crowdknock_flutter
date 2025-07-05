import 'package:flutter/material.dart';

class EditUserDialog extends StatefulWidget {
  final Map<String, dynamic> user;
  final void Function(Map<String, dynamic> updatedUser) onSave;

  const EditUserDialog({
    super.key,
    required this.user,
    required this.onSave,
  });

  @override
  State<EditUserDialog> createState() => _EditUserDialogState();
}

class _EditUserDialogState extends State<EditUserDialog> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  String _role = 'user';
  bool _active = true;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.user['name']);
    _emailController = TextEditingController(text: widget.user['email']);
    _role = widget.user['role'] ?? 'user';
    _active = widget.user['active'] ?? true;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _submit() {
    final updatedUser = {
      ...widget.user,
      'name': _nameController.text.trim(),
      'email': _emailController.text.trim(),
      'role': _role,
      'active': _active,
    };

    widget.onSave(updatedUser);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Editar Usuario'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Nombre'),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Correo'),
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              value: _role,
              decoration: const InputDecoration(labelText: 'Rol'),
              items: const [
                DropdownMenuItem(value: 'user', child: Text('Usuario')),
                DropdownMenuItem(value: 'moderator', child: Text('Moderador')),
                DropdownMenuItem(value: 'admin', child: Text('Administrador')),
              ],
              onChanged: (value) => setState(() => _role = value ?? 'user'),
            ),
            const SizedBox(height: 8),
            SwitchListTile(
              title: const Text('Activo'),
              value: _active,
              onChanged: (value) => setState(() => _active = value),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          child: const Text('Cancelar'),
          onPressed: () => Navigator.of(context).pop(),
        ),
        ElevatedButton(
          child: const Text('Guardar'),
          onPressed: _submit,
        ),
      ],
    );
  }
}
