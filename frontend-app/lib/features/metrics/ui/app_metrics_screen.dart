import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:frontend_app/core/widgets/admin_scaffold.dart';

class AppMetricsScreen extends StatelessWidget {
  const AppMetricsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const AdminScaffold(
      title: 'Métricas de la Aplicación',
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: MetricsGrid(),
      ),
    );
  }
}

class MetricsGrid extends StatelessWidget {
  const MetricsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth > 800;
        return GridView.count(
          crossAxisCount: isWide ? 3 : 1,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 1.2,
          children: const [
            MetricsCard(
              title: 'Usuarios Activos',
              chart: UsersChart(),
            ),
            MetricsCard(
              title: 'Tiempo Medio de Sesión',
              chart: SessionChart(),
            ),
            MetricsCard(
              title: 'Reportes por Día',
              chart: ReportsChart(),
            ),
          ],
        );
      },
    );
  }
}

class MetricsCard extends StatelessWidget {
  final String title;
  final Widget chart;

  const MetricsCard({super.key, required this.title, required this.chart});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shadowColor: Colors.black12,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 12),
            Expanded(child: chart),
          ],
        ),
      ),
    );
  }
}
