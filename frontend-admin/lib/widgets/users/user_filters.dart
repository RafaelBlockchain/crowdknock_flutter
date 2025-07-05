// frontend-admin/lib/widgets/users/user_filters.dart

import 'package:flutter/material.dart';

class UserFilters extends StatelessWidget {
  final String selectedRole;
  final ValueChanged<String> onRoleChanged;

  const UserFilters({
    super.key,
    required this.selectedRole,
    required this.onRoleChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text(
          'Filtrar por rol:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(width: 10),
        DropdownButton<String>(
          value: selectedRole,
          items: const [
            DropdownMenuItem(value: 'all', child: Text('Todos')),
            DropdownMenuItem(value: 'admin', child: Text('Admin')),
            DropdownMenuItem(value: 'moderator', child: Text('Moderador')),
            DropdownMenuItem(value: 'user', child: Text('Usuario')),
          ],
          onChanged: (value) {
            if (value != null) {
              onRoleChanged(value);
            }
          },
        ),
      ],
    );
  }
}

