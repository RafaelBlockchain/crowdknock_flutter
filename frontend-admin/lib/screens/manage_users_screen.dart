import 'package:flutter/material.dart';
import '../layout/admin_scaffold.dart';
import '../widgets/user_table.dart';

class ManageUsersScreen extends StatelessWidget {
  const ManageUsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
      title: '👥 Gestión de Usuarios',
      currentRoute: '/manage-users',
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Usuarios registrados en la plataforma',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 24),
            UserTable(), // 🔁 Widget reutilizable con lógica de tabla
          ],
        ),
      ),
    );
  }
}

