import 'package:flutter/material.dart';
import '../layout/admin_scaffold.dart';

class SystemStatusPage extends StatelessWidget {
  const SystemStatusPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
      title: '🖥️ System Status',
      currentRoute: '/system-status',
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            const Text(
              'System Health Overview',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            const Text(
              'Monitor the current status of backend services, database, storage, and queue systems.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 24),

            // 🔧 Servicios simulados - reemplazar con datos reales del backend
            const _StatusCard(
              service: 'Backend API',
              status: 'Operational',
              color: Colors.green,
            ),
            const _StatusCard(
              service: 'PostgreSQL Database',
              status: 'Operational',
              color: Colors.green,
            ),
            const _StatusCard(
              service: 'Media Storage (S3)',
              status: 'Degraded Performance',
              color: Colors.orange,
            ),
            const _StatusCard(
              service: 'Notification Queue',
              status: 'Offline',
              color: Colors.red,
            ),
          ],
        ),
      ),
    );
  }
}

// 🧩 Widget de estado individual
class _StatusCard extends StatelessWidget {
  final String service;
  final String status;
  final Color color;

  const _StatusCard({
    required this.service,
    required this.status,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: CircleAvatar(backgroundColor: color, radius: 10),
        title: Text(service),
        subtitle: Text('Status: $status'),
        trailing: Icon(Icons.info_outline, color: Colors.grey[600]),
      ),
    );
  }
}
