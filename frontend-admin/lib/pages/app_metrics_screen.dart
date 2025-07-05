import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../widgets/admin_scaffold.dart';

class AppMetricsScreen extends StatelessWidget {
  const AppMetricsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
      title: '📊 App Metrics',
      currentRoute: '/app-metrics',
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Métricas de Aplicación',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 24),
          Wrap(
            spacing: 16,
            runSpacing: 16,
            children: const [
              _MetricCard(
                title: 'Usuarios Activos',
                value: '1,240',
                icon: Icons.people,
                color: Colors.blue,
              ),
              _MetricCard(
                title: 'Duración Media de Sesión',
                value: '12:34 min',
                icon: Icons.timer,
                color: Colors.teal,
              ),
              _MetricCard(
                title: 'Fallos Reportados',
                value: '4',
                icon: Icons.error_outline,
                color: Colors.red,
              ),
            ],
          ),
          const SizedBox(height: 32),
          const Text(
            'Sesiones Semanales',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          AspectRatio(
            aspectRatio: 1.6,
            child: Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: LineChart(
                  LineChartData(
                    titlesData: FlTitlesData(
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (value, _) {
                            const days = ['Lun', 'Mar', 'Mié', 'Jue', 'Vie', 'Sáb', 'Dom'];
                            return Text(days[value.toInt() % days.length]);
                          },
                        ),
                      ),
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (value, _) => Text('${value.toInt()}'),
                        ),
                      ),
                      rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                      topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    ),
                    gridData: FlGridData(show: true),
                    borderData: FlBorderData(show: true),
                    lineBarsData: [
                      LineChartBarData(
                        spots: [
                          const FlSpot(0, 150),
                          const FlSpot(1, 180),
                          const FlSpot(2, 130),
                          const FlSpot(3, 200),
                          const FlSpot(4, 170),
                          const FlSpot(5, 220),
                          const FlSpot(6, 190),
                        ],
                        isCurved: true,
                        barWidth: 3,
                        color: Colors.indigo,
                        dotData: FlDotData(show: true),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MetricCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const _MetricCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 220,
      child: Card(
        color: color.withOpacity(0.1),
        child: ListTile(
          leading: Icon(icon, color: color),
          title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text(value, style: TextStyle(fontSize: 18, color: color)),
        ),
      ),
    );
  }
}

