import 'package:flutter/material.dart';
import '../layout/admin_scaffold.dart';
import '../widgets/moderation_table.dart';

class ModerationQueueScreen extends StatelessWidget {
  const ModerationQueueScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
      title: '🛡️ Cola de Moderación',
      currentRoute: '/moderation',
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Contenidos reportados por usuarios',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 24),
            ModerationTable(), // 🔁 Tabla modular con acciones para aprobar o eliminar
          ],
        ),
      ),
    );
  }
}

