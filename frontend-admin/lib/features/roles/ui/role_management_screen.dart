import 'package:flutter/material.dart';
import 'package:frontend_admin/core/constants/app_colors.dart';
import 'package:frontend_admin/core/constants/roles.dart';

class RoleManagementScreen extends StatefulWidget {
  const RoleManagementScreen({super.key});

  @override
  State<RoleManagementScreen> createState() => _RoleManagementScreenState();
}

class _RoleManagementScreenState extends State<RoleManagementScreen> {
  final _roleController = TextEditingController();
  final List<String> _customRoles = [];

  void _addRole() {
    final newRole = _roleController.text.trim().toUpperCase();

    if (newRole.isEmpty || _allRoles.contains(newRole)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Rol inválido o duplicado')),
      );
      return;
    }

    setState(() {
      _customRoles.add(newRole);
      _roleController.clear();
    });
  }

  void _deleteRole(String role) {
    setState(() {
      _customRoles.remove(role);
    });
  }

  List<String> get _allRoles => [...UserRoles.allRoles, ..._customRoles];

  @override
  void dispose() {
    _roleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gestión de Roles'),
        backgroundColor: AppColors.primary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Formulario para agregar rol
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _roleController,
                    decoration: const InputDecoration(
                      labelText: 'Nuevo rol',
                      prefixIcon: Icon(Icons.admin_panel_settings_outlined),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                ElevatedButton.icon(
                  onPressed: _addRole,
                  icon: const Icon(Icons.add),
                  label: const Text('Agregar'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Lista de roles
            Expanded(
              child: ListView.builder(
                itemCount: _allRoles.length,
                itemBuilder: (context, index) {
                  final role = _allRoles[index];
                  final isStatic = UserRoles.allRoles.contains(role);

                  return Card(
                    child: ListTile(
                      leading: const Icon(Icons.security),
                      title: Text(role),
                      subtitle: Text(
                        UserRoles.roleDescriptions[role] ?? 'Rol personalizado',
                      ),
                      trailing: isStatic
                          ? const Icon(Icons.lock, color: Colors.grey)
                          : IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () => _deleteRole(role),
                            ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

