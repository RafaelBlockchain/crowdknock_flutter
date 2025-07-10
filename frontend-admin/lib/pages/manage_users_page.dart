import 'package:flutter/material.dart';

class ManageUsersPage extends StatefulWidget {
  const ManageUsersPage({super.key});

  @override
  State<ManageUsersPage> createState() => _ManageUsersPageState();
}

class _ManageUsersPageState extends State<ManageUsersPage> {
  // Datos simulados de usuarios (deberás conectar con tu backend real)
  final List<Map<String, dynamic>> users = [
    {
      'id': 1,
      'name': 'Laura Gómez',
      'email': 'laura@example.com',
      'role': 'Moderador',
      'status': 'Activo',
    },
    {
      'id': 2,
      'name': 'Carlos Ríos',
      'email': 'carlos@example.com',
      'role': 'Admin',
      'status': 'Suspendido',
    },
  ];

  void _editUser(int userId) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Editar usuario ID: $userId')),
    );
  }

  void _deleteUser(int userId) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Eliminar usuario ID: $userId')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gestión de Usuarios'),
        backgroundColor: Colors.deepPurple,
      ),
      body: users.isEmpty
          ? const Center(child: Text('No hay usuarios registrados.'))
          : ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                final user = users[index];
                return Card(
                  margin:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: ListTile(
                    title: Text(user['name']),
                    subtitle: Text('${user['email']} • Rol: ${user['role']}'),
                    trailing: PopupMenuButton<String>(
                      onSelected: (value) {
                        if (value == 'Editar') {
                          _editUser(user['id']);
                        } else if (value == 'Eliminar') {
                          _deleteUser(user['id']);
                        }
                      },
                      itemBuilder: (context) => [
                        const PopupMenuItem(
                          value: 'Editar',
                          child: Text('Editar'),
                        ),
                        const PopupMenuItem(
                          value: 'Eliminar',
                          child: Text('Eliminar'),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}

