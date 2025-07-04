import 'package:flutter/material.dart';
import 'package:frontend_admin/widgets/admin_scaffold.dart';
import 'package:frontend_admin/services/user_service.dart';

class ManageUsersScreen extends StatefulWidget {
  const ManageUsersScreen({super.key});

  @override
  State<ManageUsersScreen> createState() => _ManageUsersScreenState();
}

class _ManageUsersScreenState extends State<ManageUsersScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _allUsers = [];
  List<Map<String, dynamic>> _filteredUsers = [];

  @override
  void initState() {
    super.initState();
    _loadUsers();
    _searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredUsers = _allUsers.where((user) {
        return user['name'].toLowerCase().contains(query) ||
            user['email'].toLowerCase().contains(query);
      }).toList();
    });
  }

  Future<void> _loadUsers() async {
    try {
      final users = await UserService.getAllUsers();
      setState(() {
        _allUsers = users;
        _filteredUsers = users;
      });
    } catch (e) {
      debugPrint('Error loading users: $e');
    }
  }

  void _editUser(Map<String, dynamic> user) {
    final nameController = TextEditingController(text: user['name']);
    final roleController = TextEditingController(text: user['role']);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit User'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: roleController,
              decoration: const InputDecoration(labelText: 'Role'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              await UserService.updateUser(user['id'], {
                'name': nameController.text,
                'role': roleController.text,
              });
              Navigator.pop(context);
              await _loadUsers();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('✅ User updated')),
              );
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _banUser(Map<String, dynamic> user) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirm Ban'),
        content: Text('Are you sure you want to ban ${user['name']}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              await UserService.banUser(user['id']);
              Navigator.pop(context);
              await _loadUsers();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('🚫 User banned')),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Ban'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
      title: '👥 Manage Users',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'User Management Panel',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _searchController,
            decoration: const InputDecoration(
              hintText: '🔍 Search by name or email...',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.search),
              filled: true,
              fillColor: Colors.white,
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: Card(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columns: const [
                    DataColumn(label: Text('ID')),
                    DataColumn(label: Text('Name')),
                    DataColumn(label: Text('Email')),
                    DataColumn(label: Text('Role')),
                    DataColumn(label: Text('Status')),
                    DataColumn(label: Text('Actions')),
                  ],
                  rows: _filteredUsers.map((user) {
                    return DataRow(
                      cells: [
                        DataCell(Text(user['id'].toString())),
                        DataCell(Text(user['name'])),
                        DataCell(Text(user['email'])),
                        DataCell(Text(user['role'])),
                        DataCell(
                          Text(
                            user['status'],
                            style: TextStyle(
                              color: user['status'] == 'Banned'
                                  ? Colors.red
                                  : Colors.green,
                            ),
                          ),
                        ),
                        DataCell(Row(
                          children: [
                            ElevatedButton(
                              onPressed: () => _banUser(user),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 6),
                                textStyle: const TextStyle(fontSize: 12),
                              ),
                              child: const Text('Ban'),
                            ),
                            const SizedBox(width: 8),
                            ElevatedButton(
                              onPressed: () => _editUser(user),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 6),
                                textStyle: const TextStyle(fontSize: 12),
                              ),
                              child: const Text('Edit'),
                            ),
                          ],
                        )),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
