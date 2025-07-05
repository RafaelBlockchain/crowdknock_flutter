// frontend-admin/lib/widgets/users/user_filters.dart

import 'package:flutter/material.dart';

class UserFilters extends StatelessWidget {
  const UserFilters({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 12,
      runSpacing: 8,
      children: [
        DropdownButtonFormField<String>(
          decoration: const InputDecoration(labelText: 'Rol'),
          items: const [
            DropdownMenuItem(value: 'all', child: Text('Todos')),
            DropdownMenuItem(value: 'admin', child: Text('Administrador')),
            DropdownMenuItem(value: 'moderator', child: Text('Moderador')),
            DropdownMenuItem(value: 'user', child: Text('Usuario')),
          ],
          onChanged: (value) {},
        ),
        ElevatedButton.icon(
          onPressed: () {
            // Acción de filtro
          },
          icon: const Icon(Icons.search),
          label: const Text('Filtrar'),
        ),
      ],
    );
  }
}

