import 'package:flutter/material.dart';
import '../widgets/admin_scaffold.dart';

class ManageUsersPage extends StatefulWidget {
  const ManageUsersPage({super.key});

  @override
  State<ManageUsersPage> createState() => _ManageUsersPageState();
}

class _ManageUsersPageState extends State<ManageUsersPage> {
  String? _filterRole;
  String? _filterStatus;

  List<Map<String, dynamic>> _users = [];

  @override
  void initState() {
    super.initState();
    _loadMockUsers();
  }

  void _loadMockUsers() {
    _users = [
      {
        'id': 'u1',
        'name': 'Juan Pérez',
        'email': 'juan@example.com',
        'role': 'Usuario',
        'status': 'Activo',
      },
      {
        'id': 'u2',
        'name': 'Admin Ana',
        'email': 'ana@admin.com',
        'role': 'Administrador',
        'status': 'Suspendido',
      },
    ];
  }

  void _suspendUser(String userId) {
    setState(() {
      final index = _users.indexWhere((u) => u['id'] == userId);
      if (index != -1) {
        _users[index]['status'] = 'Suspendido';
      }
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('⛔ Usuario suspendido')),
    );
  }

  void _deleteUser(String userId) {
    setState(() => _users.removeWhere((u) => u['id'] == userId));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('🗑️ Usuario eliminado')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final filteredUsers = _users.where((user) {
      final matchesRole = _filterRole == null || user['role'] == _filterRole;
      final matchesStatus = _filterStatus == null || user['status'] == _filterStatus;
      return matchesRole && matchesStatus;
    }).toList();

    return AdminScaffold(
      title: '👥 Gestión de Usuarios',
      currentRoute: '/manage-users',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Filtra, edita y modera las cuentas de usuarios.'),
          const SizedBox(height: 24),

          /// Filtros
          Row(
            children: [
              DropdownButton<String>(
                hint: const Text('Rol'),
                value: _filterRole,
                items: const [
                  DropdownMenuItem(value: 'Usuario', child: Text('Usuario')),
                  DropdownMenuItem(value: 'Administrador', child: Text('Administrador')),
                ],
                onChanged: (value) => setState(() => _filterRole = value),
              ),
              const SizedBox(width: 20),
              DropdownButton<String>(
                hint: const Text('Estado'),
                value: _filterStatus,
                items: const [
                  DropdownMenuItem(value: 'Activo', child: Text('Activo')),
                  DropdownMenuItem(value: 'Suspendido', child: Text('Suspendido')),
                ],
                onChanged: (value) => setState(() => _filterStatus = value),
              ),
              const Spacer(),
              TextButton(
                onPressed: () => setState(() {
                  _filterRole = null;
                  _filterStatus = null;
                }),
                child: const Text('Limpiar filtros'),
              ),
            ],
          ),

          const SizedBox(height: 20),

          /// Tabla de usuarios
          Expanded(
            child: Card(
              elevation: 2,
              child: DataTable(
                headingRowColor: MaterialStateColor.resolveWith((_) => Colors.grey[200]!),
                columns: const [
                  DataColumn(label: Text('Nombre')),
                  DataColumn(label: Text('Email')),
                  DataColumn(label: Text('Rol')),
                  DataColumn(label: Text('Estado')),
                  DataColumn(label: Text('Acciones')),
                ],
                rows: filteredUsers.map((user) {
                  return DataRow(cells: [
                    DataCell(Text(user['name'])),
                    DataCell(Text(user['email'])),
                    DataCell(Text(user['role'])),
                    DataCell(Text(user['status'],
                        style: TextStyle(
                          color: user['status'] == 'Activo' ? Colors.green : Colors.red,
                        ))),
                    DataCell(Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.block, color: Colors.orange),
                          tooltip: 'Suspender',
                          onPressed: user['status'] == 'Activo'
                              ? () => _suspendUser(user['id'])
                              : null,
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          tooltip: 'Eliminar',
                          onPressed: () => _deleteUser(user['id']),
                        ),
                      ],
                    )),
                  ]);
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

