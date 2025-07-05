import 'package:flutter/material.dart';
import '../widgets/admin_scaffold.dart';

class SystemStatusPage extends StatelessWidget {
  const SystemStatusPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
      title: '🛠️ System Status',
      currentRoute: '/system-status',
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Server & System Status',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 24),
          _StatusCard(
            title: 'API Server',
            status: 'Online',
            color: Colors.green,
            description: 'All systems operational.',
          ),
          const SizedBox(height: 12),
          _StatusCard(
            title: 'Database',
            status: 'Online',
            color: Colors.green,
            description: 'PostgreSQL connected and running smoothly.',
          ),
          const SizedBox(height: 12),
          _StatusCard(
            title: 'Storage',
            status: '80% full',
            color: Colors.orange,
            description: 'Consider clearing old content or increasing capacity.',
          ),
          const SizedBox(height: 12),
          _StatusCard(
            title: 'Background Jobs',
            status: 'Delayed',
            color: Colors.red,
            description: 'Workers are taking too long to process queues.',
          ),
        ],
      ),
    );
  }
}

class _StatusCard extends StatelessWidget {
  final String title;
  final String status;
  final Color color;
  final String description;

  const _StatusCard({
    required this.title,
    required this.status,
    required this.color,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(Icons.circle, color: color),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(description),
        trailing: Text(
          status,
          style: TextStyle(fontWeight: FontWeight.bold, color: color),
        ),
      ),
    );
  }
}
