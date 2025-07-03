import 'package:flutter/material.dart';

class UsersManagementPage extends StatefulWidget {
  const UsersManagementPage({super.key});

  @override
  State<UsersManagementPage> createState() => _UsersManagementPageState();
}

class _UsersManagementPageState extends State<UsersManagementPage> {
  final TextEditingController _searchController = TextEditingController();

  // 🔧 Datos simulados. Reemplazar por llamada al backend protegido por JWT (GET /users).
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
    final nameController = TextEditingController(text: user['name']);
    final roleController = TextEditingController(text: user['role']);

    showDialog(
      context: context,
      builder: (context) {
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
                // TODO: PUT /users/:id con JWT para actualizar nombre y rol.
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
        title: const Text('Confirm Ban'),
        content: Text('Are you sure you want to ban ${user['name']}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                user['status'] = 'Banned';
              });
              // TODO: PATCH /users/:id/ban con JWT.
              Navigator.pop(context);
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
    return Scaffold(
      backgroundColor: Colors.grey[100],
      drawer: const _Sidebar(),
      appBar: AppBar(
        title: const Text('👥 User Management'),
        backgroundColor: Colors.indigo,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'User Management Panel',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
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
                elevation: 2,
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
                          DataCell(Text(user['id']!)),
                          DataCell(Text(user['name']!)),
                          DataCell(Text(user['email']!)),
                          DataCell(Text(user['role']!)),
                          DataCell(
                            Text(
                              user['status']!,
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
      ),
    );
  }
}

// 🔽 Sidebar persistente reutilizable
class _Sidebar extends StatelessWidget {
  const _Sidebar();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          Text(
            'CrowdKnock Admin',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.indigo,
            ),
          ),
          SizedBox(height: 20),
          _SidebarItem(title: 'Dashboard', route: '/dashboard'),
          _SidebarItem(title: 'Users', route: '/manage-users', isActive: true),
          _SidebarItem(title: 'Settings', route: '/settings'),
        ],
      ),
    );
  }
}

class _SidebarItem extends StatelessWidget {
  final String title;
  final String route;
  final bool isActive;

  const _SidebarItem({
    required this.title,
    required this.route,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      tileColor: isActive ? Colors.indigo[500] : null,
      textColor: isActive ? Colors.white : null,
      onTap: () {
        if (!isActive) {
          Navigator.pushNamed(context, route);
        } else {
          Navigator.pop(context);
        }
      },
    );
  }
}
