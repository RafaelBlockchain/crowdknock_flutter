// frontend-admin/lib/widgets/users/user_table.dart

import 'package:flutter/material.dart';
import '../../models/user_model.dart';
import '../../services/user_service.dart';

class UserTable extends StatelessWidget {
  final String searchQuery;
  final String selectedRole;

  const UserTable({
    super.key,
    required this.searchQuery,
    required this.selectedRole,
  });

  DataRow(
  cells: [
    DataCell(Text(user.name)),
    DataCell(Text(user.email)),
    DataCell(Row(
      children: [
        IconButton(
          icon: Icon(Icons.edit),
          onPressed: () => _showEditDialog(user),
        ),
        IconButton(
          icon: Icon(Icons.delete),
          color: Colors.red,
          onPressed: () {
            showDialog(
              context: context,
              builder: (_) => DeleteUserDialog(
                user: user,
                onUserDeleted: _fetchUsers, // <-- refresca la tabla después
              ),
            );
          },
        ),
      ],
    )),
  ],
)


  
  @override
  Widget build(BuildContext context) {
    final userService = UserService(baseUrl: 'http://localhost:3000'); // reemplaza por tu base real

    return FutureBuilder<List<UserModel>>(
      future: userService.getAllUsers(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        final filteredUsers = snapshot.data!.where((user) {
          final matchesSearch = user.name.toLowerCase().contains(searchQuery.toLowerCase()) ||
              user.email.toLowerCase().contains(searchQuery.toLowerCase());
          final matchesRole = selectedRole == 'all' || user.role == selectedRole;
          return matchesSearch && matchesRole;
        }).toList();

        return Card(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columns: const [
                DataColumn(label: Text('ID')),
                DataColumn(label: Text('Nombre')),
                DataColumn(label: Text('Email')),
                DataColumn(label: Text('Rol')),
              ],
              rows: filteredUsers.map((user) {
                return DataRow(cells: [
                  DataCell(Text(user.id)),
                  DataCell(Text(user.name)),
                  DataCell(Text(user.email)),
                  DataCell(Text(user.role)),
                ]);
              }).toList(),
            ),
          ),
        );
      },
    );
  }
}
