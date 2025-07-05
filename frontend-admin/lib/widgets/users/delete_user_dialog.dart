import 'package:flutter/material.dart';
import 'package:frontend_admin/models/user_model.dart';
import 'package:frontend_admin/services/user_service.dart';
import 'package:frontend_admin/core/widgets/primary_button.dart';

class DeleteUserDialog extends StatefulWidget {
  final UserModel user;
  final VoidCallback onUserDeleted;

  const DeleteUserDialog({
    super.key,
    required this.user,
    required this.onUserDeleted,
  });

  @override
  State<DeleteUserDialog> createState() => _DeleteUserDialogState();
}

class _DeleteUserDialogState extends State<DeleteUserDialog> {
  bool isDeleting = false;

  Future<void> _deleteUser() async {
    setState(() => isDeleting = true);

    try {
      await UserService.deleteUser(widget.user.id);
      widget.onUserDeleted();
      Navigator.of(context).pop();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al eliminar usuario: $e')),
      );
      setState(() => isDeleting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Eliminar Usuario'),
      content: Text('¿Estás seguro de que deseas eliminar a "${widget.user.name}"? Esta acción no se puede deshacer.'),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancelar'),
        ),
        PrimaryButton(
          text: 'Eliminar',
          onPressed: isDeleting ? null : _deleteUser,
          color: Colors.red,
        ),
      ],
    );
  }
}
