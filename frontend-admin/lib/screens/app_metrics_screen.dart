import 'package:flutter/material.dart';
import '../layout/admin_scaffold.dart';

class AppMetricsScreen extends StatelessWidget {
  const AppMetricsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
      title: '📊 Métricas de la App',
      currentRoute: '/app-metrics',
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Resumen de actividad',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            const _MetricsRow(),
            const SizedBox(height: 32),
            const Text(
              'Actividad reciente',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),
            const _ActivityLog(),
          ],
        ),
      ),
    );
  }
}

class _MetricsRow extends StatelessWidget {
  const _MetricsRow();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children: const [
        MetricCard(label: 'Usuarios activos', value: '1,420', color: Colors.indigo),
        MetricCard(label: 'Publicaciones', value: '3,875', color: Colors.green),
        MetricCard(label: 'Comentarios', value: '9,210', color: Colors.orange),
        MetricCard(label: 'Reportes', value: '152', color: Colors.redAccent),
      ],
    );
  }
}

class MetricCard extends StatelessWidget {
  final String label;
  final String value;
  final Color color;

  const MetricCard({
    required this.label,
    required this.value,
    required this.color,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontSize: 14, color: Colors.black54)),
          const SizedBox(height: 6),
          Text(value, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: color)),
        ],
      ),
    );
  }
}

class _ActivityLog extends StatelessWidget {
  const _ActivityLog();

  final List<Map<String, String>> logs = const [
    {'timestamp': '2025-07-09 14:22', 'event': 'Nuevo comentario publicado'},
    {'timestamp': '2025-07-09 13:10', 'event': 'Usuario reportó contenido'},
    {'timestamp': '2025-07-09 11:44', 'event': 'Nuevo usuario registrado'},
    {'timestamp': '2025-07-09 09:30', 'event': 'Moderador eliminó comentario ofensivo'},
  ];

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: ListView.separated(
        shrinkWrap: true,
        itemCount: logs.length,
        separatorBuilder: (_, __) => const Divider(height: 1),
        itemBuilder: (context, index) {
          final log = logs[index];
          return ListTile(
            leading: const Icon(Icons.timeline, color: Colors.indigo),
            title: Text(log['event'] ?? ''),
            subtitle: Text(log['timestamp'] ?? ''),
          );
        },
      ),
    );
  }
}

