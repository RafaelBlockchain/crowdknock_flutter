import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../widgets/admin_scaffold.dart';

class MetricsPage extends StatelessWidget {
  const MetricsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
      title: '📊 Métricas de la App',
      currentRoute: '/metrics',
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            /// Métricas resumen
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                _MetricCard(title: 'Usuarios Activos', value: '12,470'),
                _MetricCard(title: 'Tiempo Prom. Sesión', value: '5m 42s'),
                _MetricCard(
                  title: 'Crashes (24h)',
                  value: '3',
                  valueColor: Colors.red,
                ),
              ],
            ),
            const SizedBox(height: 30),

            /// Gráficos
            Expanded(
              child: Row(
                children: const [
                  Expanded(child: _ActiveUsersChartCard()),
                  SizedBox(width: 20),
                  Expanded(child: _CrashReportsCard()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

