import 'package:flutter/material.dart';
import '../layout/admin_scaffold.dart';
import '../widgets/moderation_table.dart';

class ModerationPage extends StatelessWidget {
  const ModerationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
      title: '🛡️ Moderation Panel',
      currentRoute: '/moderation',
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Content Moderation Queue',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12),
            Text(
              'Review and take action on reported content from the platform.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 24),
            Expanded(child: ModerationTable()),
          ],
        ),
      ),
    );
  }
}
