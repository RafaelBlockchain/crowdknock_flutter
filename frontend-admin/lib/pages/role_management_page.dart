import 'package:flutter/material.dart';

class RoleManagementPage extends StatelessWidget {
  const RoleManagementPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Row(
        children: [
          const AdminSidebar(activeItem: 'Role Management'),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const AdminSectionHeader(title: 'Role Management'),
                  const SizedBox(height: 24),
                  const RoleListTable(),
                  const SizedBox(height: 24),
                  const CreateRoleForm(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Sidebar para navegación del admin
class AdminSidebar extends StatelessWidget {
  final String activeItem;
  const AdminSidebar({super.key, required this.activeItem});

  final List<String> menuItems = const [
    'Dashboard',
    'Manage Users',
    'Manage Content',
    'Moderation',
    'Analytics',
    'Reports',
    'Payments',
    'Settings',
    'Audit Logs',
    'System Status',
    'Admin Logins',
    'Role Management'
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 260,
      color: Colors.white,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'CrowdKnock Admin',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.indigo,
            ),
          ),
          const SizedBox(height: 24),
          ...menuItems.map((item) {
            final isActive = item == activeItem;
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor:
                      isActive ? Colors.indigo : Colors.transparent,
                  foregroundColor: isActive ? Colors.white : Colors.black,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
                onPressed: () {
                  // TODO: Navegación a la ruta correspondiente
                },
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(item),
                ),
              ),
            );
          })
        ],
      ),
    );
  }
}

// Encabezado reutilizable para secciones del admin
class AdminSectionHeader extends StatelessWidget {
  final String title;
  const AdminSectionHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
    );
  }
}

// Tabla de roles existentes
class RoleListTable extends StatelessWidget {
  const RoleListTable({super.key});

  @override
  Widget build(BuildContext context) {
    final roles = [
      ['Super Admin', 'All Access', '2'],
      ['Moderator', 'Content Review, Ban Users', '4'],
      ['Content Manager', 'Upload, Edit Media', '3'],
    ];

    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Existing Roles',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            DataTable(
              columns: const [
                DataColumn(label: Text('Role Name')),
                DataColumn(label: Text('Permissions')),
                DataColumn(label: Text('Users')),
                DataColumn(label: Text('Actions')),
              ],
              rows: roles.map((role) {
                return DataRow(cells: [
                  DataCell(Text(role[0])),
                  DataCell(Text(role[1])),
                  DataCell(Text(role[2])),
                  DataCell(Row(
                    children: [
                      TextButton(onPressed: () {}, child: const Text('Edit')),
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          'Delete',
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    ],
                  )),
                ]);
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

// Formulario para crear un nuevo rol
class CreateRoleForm extends StatelessWidget {
  const CreateRoleForm({super.key});

  @override
  Widget build(BuildContext context) {
    final permissions = [
      'Manage Users',
      'Edit Content',
      'View Analytics',
      'Moderate Comments',
      'Manage Roles',
      'System Settings',
    ];

    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Create New Role',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Role Name',
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Assign Permissions:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 12,
              runSpacing: 8,
              children: permissions.map((perm) {
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Checkbox(value: false, onChanged: (_) {}),
                    Text(perm),
                  ],
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.indigo),
              onPressed: () {},
              child: const Text('Create Role'),
            ),
          ],
        ),
      ),
    );
  }
}
