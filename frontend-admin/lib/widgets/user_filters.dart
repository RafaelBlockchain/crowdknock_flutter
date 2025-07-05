import 'package:flutter/material.dart';

class UserFilters extends StatelessWidget {
  final ValueChanged<String?> onRoleChanged;

  const UserFilters({super.key, required this.onRoleChanged});

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: 'all',
      onChanged: onRoleChanged,
      decoration: const InputDecoration(
        labelText: 'Filtrar por Rol',
        border: OutlineInputBorder(),
      ),
      items: const [
        DropdownMenuItem(value: 'all', child: Text('Todos')),
        DropdownMenuItem(value: 'admin', child: Text('Administrador')),
        DropdownMenuItem(value: 'moderator', child: Text('Moderador')),
        DropdownMenuItem(value: 'user', child: Text('Usuario')),
      ],
    );
  }
}

