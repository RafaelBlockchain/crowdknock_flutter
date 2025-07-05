import 'package:flutter/material.dart';
import 'package:crowdknock_admin/widgets/admin_scaffold.dart';
import 'widgets/user_table.dart';
import 'widgets/user_search_bar.dart';

class ManageUsersScreen extends StatefulWidget {
  const ManageUsersScreen({super.key});

  @override
  State<ManageUsersScreen> createState() => _ManageUsersScreenState();
}

class _ManageUsersScreenState extends State<ManageUsersScreen> {
  String _searchQuery = '';

  void _onSearchChanged(String value) {
    setState(() {
      _searchQuery = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
      title: '👥 Gestión de Usuarios',
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Panel de Administración de Usuarios',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            UserSearchBar(onChanged: _onSearchChanged), // 🔍 Search bar
            const SizedBox(height: 16),
            Expanded(
              child: UserTable(searchQuery: _searchQuery), // 🧾 Tabla de usuarios
            ),
          ],
        ),
      ),
    );
  }
}
