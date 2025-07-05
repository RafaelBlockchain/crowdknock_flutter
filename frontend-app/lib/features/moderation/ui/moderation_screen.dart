import 'package:flutter/material.dart';
import 'package:frontend_app/core/widgets/admin_scaffold.dart';
import 'package:frontend_app/features/moderation/widgets/moderation_table.dart';
import 'package:frontend_app/features/moderation/widgets/moderation_filters.dart';

class ModerationScreen extends StatelessWidget {
  const ModerationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
      title: 'Moderación',
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Reportes pendientes',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const ModerationFilters(),
            const SizedBox(height: 16),
            const Expanded(child: ModerationTable()),
          ],
        ),
      ),
    );
  }
}
