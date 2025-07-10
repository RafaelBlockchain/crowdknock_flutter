import 'package:flutter/material.dart';

class RoleManagementPage extends StatelessWidget {
  const RoleManagementPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Row(
        children: [
          const _AdminSidebar(activeItem: 'Gestión de Roles'),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  _SectionHeader(title: '👥 Gestión de Roles'),
                  SizedBox(height: 24),
                  _RoleListTable(),
                  SizedBox(height: 32),
                  _CreateRoleForm(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

