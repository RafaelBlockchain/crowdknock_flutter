import 'package:flutter/material.dart';
import 'package:crowdknock_admin/widgets/admin_scaffold.dart';
import '../widgets/users/user_filters.dart';
import '../widgets/users/user_table.dart';
import '../widgets/users/user_search_bar.dart';

class ManageUsersScreen extends StatefulWidget {
  const ManageUsersScreen({super.key});

  @override
  State<ManageUsersScreen> createState() => _ManageUsersScreenState();
}

class _ManageUsersScreenState extends State<ManageUsersScreen> {
  String _searchQuery = '';
  String _selectedRole = 'all';

  void _onSearchChanged(String value) {
    setState(() {
      _searchQuery = value;
    });
  }

  void _onClearSearch() {
    setState(() {
      _searchQuery = '';
    });
  }

  void _onRoleChanged(String? role) {
    setState(() {
      _selectedRole = role ?? 'all';
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
            Row(
              children: [
                Expanded(
                  child: UserSearchBar(
                    searchQuery: _searchQuery,
                    onChanged: _onSearchChanged,
                    onClear: _onClearSearch,
                  ),
                ),
                const SizedBox(width: 16),
                UserFilters(
                  selectedRole: _selectedRole,
                  onRoleChanged: _onRoleChanged,
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: UserTable(
                searchQuery: _searchQuery,
                selectedRole: _selectedRole,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
