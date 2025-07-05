import 'package:flutter/material.dart';
import 'package:frontend_admin/layout/admin_scaffold.dart';
import 'package:frontend_admin/services/metrics_service.dart';
import 'package:fl_chart/fl_chart.dart';

class AppMetricsScreen extends StatefulWidget {
  const AppMetricsScreen({super.key});

  @override
  State<AppMetricsScreen> createState() => _AppMetricsScreenState();
}

class _AppMetricsScreenState extends State<AppMetricsScreen> {
  Map<String, dynamic>? usageMetrics;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadMetrics();
  }

  Future<void> _loadMetrics() async {
    try {
      final metrics = await MetricsService.getAppUsageMetrics();
      setState(() {
        usageMetrics = metrics;
        isLoading = false;
      });
    } catch (e) {
      debugPrint('Error loading metrics: $e');
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
      title: 'Métricas de Uso',
      child: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _buildMetricCard('Usuarios Activos Diarios', usageMetrics?['daily_active_users']),
                  const SizedBox(height: 20),
                  _buildLineChart('Sesiones por Día', usageMetrics?['sessions_per_day']),
                  const SizedBox(height: 20),
                  _buildBarChart('Reportes por Día', usageMetrics?['reports_per_day']),
                ],
              ),
            ),
    );
  }

  Widget _buildMetricCard(String title, dynamic value) {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.analytics),
        title: Text(title),
        subtitle: Text(value?.toString() ?? '--'),
      ),
    );
  }

  Widget _buildLineChart(String title, List<dynamic>? data) {
    if (data == null || data.isEmpty) return const Text('Sin datos');

    final spots = data.asMap().entries.map((entry) {
      return FlSpot(entry.key.toDouble(), (entry.value as num).toDouble());
    }).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        SizedBox(
          height: 200,
          child: LineChart(LineChartData(
            lineBarsData: [
              LineChartBarData(
                spots: spots,
                isCurved: true,
                color: Colors.blue,
                barWidth: 2,
                dotData: FlDotData(show: false),
              ),
            ],
            titlesData: FlTitlesData(show: false),
            gridData: FlGridData(show: false),
            borderData: FlBorderData(show: false),
          )),
        ),
      ],
    );
  }

  Widget _buildBarChart(String title, List<dynamic>? data) {
    if (data == null || data.isEmpty) return const Text('Sin datos');

    final barGroups = data.asMap().entries.map((entry) {
      final index = entry.key;
      final value = (entry.value as num).toDouble();
      return BarChartGroupData(x: index, barRods: [
        BarChartRodData(toY: value, color: Colors.orange),
      ]);
    }).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        SizedBox(
          height: 200,
          child: BarChart(BarChartData(
            barGroups: barGroups,
            titlesData: FlTitlesData(show: false),
            gridData: FlGridData(show: false),
            borderData: FlBorderData(show: false),
          )),
        ),
      ],
    );
  }
}
