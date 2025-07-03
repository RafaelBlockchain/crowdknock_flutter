import 'package:flutter/material.dart';

class ManageUsersScreen extends StatefulWidget {
  const ManageUsersScreen({super.key});

  @override
  State<ManageUsersScreen> createState() => _ManageUsersScreenState();
}

class _ManageUsersScreenState extends State<ManageUsersScreen> {
  final TextEditingController _searchController = TextEditingController();

  // Usuarios simulados. Luego será reemplazado por datos del backend.
  final List<Map<String, String>> _allUsers = [
    {
      'id': '1',
      'name': 'Jane Doe',
      'email': 'jane@example.com',
      'role': 'User',
      'status': 'Active',
    },
    {
      'id': '2',
      'name': 'Carlos Pérez',
      'email': 'carlos@admin.com',
      'role': 'Admin',
      'status': 'Active',
    },
  ];

  List<Map<String, String>> _filteredUsers = [];

  @override
  void initState() {
    super.initState();
    _filteredUsers = List.from(_allUsers);

    _searchController.addListener(() {
      final query = _searchController.text.toLowerCase();
      setState(() {
        _filteredUsers = _allUsers.where((user) {
          return user['name']!.toLowerCase().contains(query) ||
              user['email']!.toLowerCase().contains(query);
        }).toList();
      });
    });
  }

  void _editUser(Map<String, String> user) {
    showDialog(
      context: context,
      builder: (context) {
        final nameController = TextEditingController(text: user['name']);
        final roleController = TextEditingController(text: user['role']);
        return AlertDialog(
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
              onPressed: () {
                setState(() {
                  user['name'] = nameController.text;
                  user['role'] = roleController.text;
                });
                // TODO: Actualizar en backend (PUT /users/:id con JWT)
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('✅ User updated')),
                );
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void _banUser(Map<String, String> user) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
