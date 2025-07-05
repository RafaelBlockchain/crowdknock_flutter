import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../layout/admin_scaffold.dart';
import '../services/metrics_service.dart';

class AppMetricsScreen extends StatefulWidget {
  const AppMetricsScreen({super.key});

  @override
  State<AppMetricsScreen> createState() => _AppMetricsScreenState();
}

class _AppMetricsScreenState extends State<AppMetricsScreen> {
  late Future<Map<String, dynamic>> _metricsFuture;

  @override
  void initState() {
    super.initState();
    _metricsFuture = MetricsService.getAppMetrics();
  }

  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
      title: '📊 Métricas de la App',
      currentRoute: '/app-metrics',
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: FutureBuilder<Map<String, dynamic>>(
          future: _metricsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(child: Text('❌ Error: ${snapshot.error}'));
            }

            final metrics = snapshot.data!;
            final activeUsers = (metrics['activeUsers'] ?? 0).toDouble();
            final avgSessionTime = (metrics['avgSessionTime'] ?? 0).toDouble();
            final crashReports = (metrics['crashReports'] ?? 0).toDouble();

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Resumen de Métricas',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  height: 300,
                  child: BarChart(
                    BarChartData(
                      alignment: BarChartAlignment.spaceAround,
                      barTouchData: BarTouchData(enabled: false),
                      titlesData: FlTitlesData(
                        leftTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: true),
                        ),
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            getTitlesWidget: (value, meta) {
                              const labels = ['Usuarios', 'Sesión', 'Errores'];
                              if (value.toInt() < 0 || value.toInt() >= labels.length) {
                                return const SizedBox.shrink();
                              }
                              return Text(labels[value.toInt()]);
                            },
                          ),
                        ),
                      ),
                      borderData: FlBorderData(show: false),
                      barGroups: [
                        BarChartGroupData(x: 0, barRods: [
                          BarChartRodData(toY: activeUsers, color: Colors.blue),
                        ]),
                        BarChartGroupData(x: 1, barRods: [
                          BarChartRodData(toY: avgSessionTime, color: Colors.green),
                        ]),
                        BarChartGroupData(x: 2, barRods: [
                          BarChartRodData(toY: crashReports, color: Colors.red),
                        ]),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
