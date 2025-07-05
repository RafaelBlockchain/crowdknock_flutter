import 'package:flutter/material.dart';
import 'package:frontend_admin/models/user_model.dart';
import 'package:frontend_admin/services/user_service.dart';
import 'package:frontend_admin/core/widgets/primary_button.dart';

class EditUserDialog extends StatefulWidget {
  final UserModel user;
  final VoidCallback onUserUpdated;

  const EditUserDialog({super.key, required this.user, required this.onUserUpdated});

  @override
  State<EditUserDialog> createState() => _EditUserDialogState();
}

class _EditUserDialogState extends State<EditUserDialog> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController nameController;
  late TextEditingController emailController;
  String role = 'user';

  bool isSubmitting = false;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.user.name);
    emailController = TextEditingController(text: widget.user.email);
    role = widget.user.role;
  }

  static Future<void> updateUser(UserModel user) async {
  final response = await http.put(
    Uri.parse('$_baseUrl/${user.id}'),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode(user.toJson()),
  );

  if (response.statusCode != 200) {
    throw Exception('Error al actualizar el usuario');
  }
}

  Future<void> _submitUpdate() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => isSubmitting = true);

    final updatedUser = widget.user.copyWith(
      name: nameController.text.trim(),
      email: emailController.text.trim(),
      role: role,
    );

    try {
      await UserService.updateUser(updatedUser);
      widget.onUserUpdated();
      Navigator.of(context).pop();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al actualizar usuario: $e')),
      );
    } finally {
      setState(() => isSubmitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Editar Usuario'),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Nombre'),
                validator: (value) => value == null || value.isEmpty ? 'Campo requerido' : null,
              ),
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                validator: (value) => value == null || !value.contains('@') ? 'Email inválido' : null,
              ),
              const SizedBox(height: 10),
              DropdownButtonFormField<String>(
                value: role,
                decoration: const InputDecoration(labelText: 'Rol'),
                items: const [
                  DropdownMenuItem(value: 'user', child: Text('Usuario')),
                  DropdownMenuItem(value: 'admin', child: Text('Administrador')),
                  DropdownMenuItem(value: 'moderator', child: Text('Moderador')),
                ],
                onChanged: (value) => setState(() => role = value ?? 'user'),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Cancelar')),
        PrimaryButton(
          text: 'Guardar Cambios',
          onPressed: isSubmitting ? null : _submitUpdate,
        ),
      ],
    );
  }
}
