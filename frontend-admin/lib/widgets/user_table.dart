import 'package:flutter/material.dart';

class UserTable extends StatelessWidget {
  final String searchQuery;
  final String selectedRole;

  const UserTable({
    super.key,
    required this.searchQuery,
    required this.selectedRole,
  });

showDialog(
  context: context,
  builder: (_) => DeleteUserDialog(
    userName: userData['name'],
    onConfirm: () async {
      // Aquí llamas a tu UserService.deleteUser(userData['id'])
      await UserService.deleteUser(userData['id']);
      // Luego actualizas la UI o recargas los usuarios
    },
  ),
);


  
  @override
  Widget build(BuildContext context) {
    final users = [
      {'id': '1', 'name': 'Juan Pérez', 'email': 'juan@example.com', 'role': 'admin'},
      {'id': '2', 'name': 'Ana López', 'email': 'ana@example.com', 'role': 'user'},
      {'id': '3', 'name': 'Carlos Díaz', 'email': 'carlos@example.com', 'role': 'moderator'},
    ];

    final filteredUsers = users.where((user) {
      final matchesSearch = user['name']!.toLowerCase().contains(searchQuery.toLowerCase()) ||
          user['email']!.toLowerCase().contains(searchQuery.toLowerCase());
      final matchesRole = selectedRole == 'all' || user['role'] == selectedRole;
      return matchesSearch && matchesRole;
    }).toList();

    return Card(
      child: SingleChildScrollView(
        child: DataTable(
          columns: const [
            DataColumn(label: Text('ID')),
            DataColumn(label: Text('Nombre')),
            DataColumn(label: Text('Email')),
            DataColumn(label: Text('Rol')),
          ],
          rows: filteredUsers.map((u) {
            return DataRow(cells: [
              DataCell(Text(u['id']!)),
              DataCell(Text(u['name']!)),
              DataCell(Text(u['email']!)),
              DataCell(Text(u['role']!)),
            ]);
          }).toList(),
        ),
      ),
    );
  }
}

