import 'package:flutter/material.dart';
import '../layout/admin_scaffold.dart';
import '../widgets/content_table.dart';

class ManageContentScreen extends StatelessWidget {
  const ManageContentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
      title: '📂 Gestión de Contenidos',
      currentRoute: '/manage-content',
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Contenidos subidos por usuarios',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 24),
            ContentTable(), // Widget reutilizable para mostrar los contenidos
          ],
        ),
      ),
    );
  }
}

