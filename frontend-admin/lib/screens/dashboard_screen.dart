import 'package:flutter/material.dart';
import '../layout/admin_scaffold.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
      title: '📋 Panel Principal',
      currentRoute: '/dashboard',
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Bienvenido al panel de administración',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            const _OverviewRow(),
            const SizedBox(height: 32),
            const _QuickActions(),
          ],
        ),
      ),
    );
  }
}

class _OverviewRow extends StatelessWidget {
  const _OverviewRow();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children: const [
        DashboardCard(label: 'Usuarios registrados', value: '12,345', color: Colors.indigo),
        DashboardCard(label: 'Retos activos', value: '67', color: Colors.orange),
        DashboardCard(label: 'Contenido publicado', value: '8,900', color: Colors.green),
        DashboardCard(label: 'Reportes pendientes', value: '12', color: Colors.redAccent),
      ],
    );
  }
}

class DashboardCard extends StatelessWidget {
  final String label;
  final String value;
  final Color color;

  const DashboardCard({
    super.key,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.2)),
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

class _QuickActions extends StatelessWidget {
  const _QuickActions();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Accesos rápidos',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 16,
          runSpacing: 12,
          children: [
            ElevatedButton.icon(
              onPressed: () => Navigator.pushNamed(context, '/manage-content'),
              icon: const Icon(Icons.folder),
              label: const Text('Gestionar Contenido'),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.indigo),
            ),
            ElevatedButton.icon(
              onPressed: () => Navigator.pushNamed(context, '/moderation'),
              icon: const Icon(Icons.report),
              label: const Text('Moderación'),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
            ),
            ElevatedButton.icon(
              onPressed: () => Navigator.pushNamed(context, '/reports'),
              icon: const Icon(Icons.bug_report),
              label: const Text('Reportes de usuarios'),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            ),
          ],
        ),
      ],
    );
  }
}

