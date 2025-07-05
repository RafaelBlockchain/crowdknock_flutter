import 'package:flutter/material.dart';
import '../../models/user_model.dart';
import '../../services/user_service.dart';
import 'edit_user_dialog.dart';
import 'delete_user_dialog.dart';

class UserTable extends StatefulWidget {
  final String searchQuery;
  final String selectedRole;

  const UserTable({
    super.key,
    required this.searchQuery,
    required this.selectedRole,
  });

  @override
  State<UserTable> createState() => _UserTableState();
}

class _UserTableState extends State<UserTable> {
  late final UserService userService;
  List<UserModel> users = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    userService = UserService(baseUrl: 'http://localhost:3000'); // Reemplaza según entorno
    _fetchUsers();
  }

  Future<void> _fetchUsers() async {
    try {
      final data = await userService.getAllUsers();
      setState(() {
        users = data;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print('Error fetching users: $e');
    }
  }

  void _showEditDialog(UserModel user) {
    showDialog(
      context: context,
      builder: (_) => EditUserDialog(
        user: user,
        onUserUpdated: _fetchUsers,
      ),
    );
  }

  void _showDeleteDialog(UserModel user) {
    showDialog(
      context: context,
      builder: (_) => DeleteUserDialog(
        user: user,
        onUserDeleted: _fetchUsers,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final filteredUsers = users.where((user) {
      final matchesSearch = user.name.toLowerCase().contains(widget.searchQuery.toLowerCase()) ||
          user.email.toLowerCase().contains(widget.searchQuery.toLowerCase());
      final matchesRole = widget.selectedRole == 'all' || user.role == widget.selectedRole;
      return matchesSearch && matchesRole;
    }).toList();

    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return Card(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: const [
            DataColumn(label: Text('ID')),
            DataColumn(label: Text('Nombre')),
            DataColumn(label: Text('Email')),
            DataColumn(label: Text('Rol')),
            DataColumn(label: Text('Acciones')),
          ],
          rows: filteredUsers.map((user) {
            return DataRow(cells: [
              DataCell(Text(user.id)),
              DataCell(Text(user.name)),
              DataCell(Text(user.email)),
              DataCell(Text(user.role)),
              DataCell(Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () => _showEditDialog(user),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete),
                    color: Colors.red,
                    onPressed: () => _showDeleteDialog(user),
                  ),
                ],
              )),
            ]);
          }).toList(),
        ),
      ),
    );
  }
}
