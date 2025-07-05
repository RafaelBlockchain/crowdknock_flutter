// frontend-admin/lib/widgets/users/user_table.dart

import 'package:flutter/material.dart';

class UserTable extends StatelessWidget {
  const UserTable({super.key});

  @override
  Widget build(BuildContext context) {
    final users = [
      {'id': '1', 'name': 'Juan Pérez', 'email': 'juan@example.com', 'role': 'admin'},
      {'id': '2', 'name': 'Ana López', 'email': 'ana@example.com', 'role': 'user'},
    ];

    return Card(
      child: DataTable(
        columns: const [
          DataColumn(label: Text('ID')),
          DataColumn(label: Text('Nombre')),
          DataColumn(label: Text('Email')),
          DataColumn(label: Text('Rol')),
        ],
        rows: users.map((u) {
          return DataRow(cells: [
            DataCell(Text(u['id']!)),
            DataCell(Text(u['name']!)),
            DataCell(Text(u['email']!)),
            DataCell(Text(u['role']!)),
          ]);
        }).toList(),
      ),
    );
  }
}

