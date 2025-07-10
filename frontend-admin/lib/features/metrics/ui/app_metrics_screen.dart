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
      debugPrint('❌ Error loading metrics: $e');
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
      title: '📈 Métricas de Uso',
      child: isLoading
          ? const Center(child: CircularProgressIndicator())
          : usageMetrics == null
              ? const Center(child: Text('No se pudieron cargar las métricas.'))
              : SingleChildScrollView(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _MetricCard(
                        title: '👥 Usuarios Activos Diarios',
                        value: usageMetrics?['daily_active_users'],
                      ),
                      const SizedBox(height: 20),
                      _LineChartBlock(
                        title: '📅 Sesiones por Día',
                        data: usageMetrics?['sessions_per_day'],
                      ),
                      const SizedBox(height: 20),
                      _BarChartBlock(
                        title: '🚨 Reportes por Día',
                        data: usageMetrics?['reports_per_day'],
                      ),
                    ],
                  ),
                ),
    );
  }
}

class _MetricCard extends StatelessWidget {
  final String title;
  final dynamic value;

  const _MetricCard({required this.title, this.value});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: const Icon(Icons.analytics, color: Colors.indigo),
        title: Text(title),
        subtitle: Text(value?.toString() ?? '--'),
      ),
    );
  }
}

class _LineChartBlock extends StatelessWidget {
  final String title;
  final List<dynamic>? data;

  const _LineChartBlock({required this.title, this.data});

  @override
  Widget build(BuildContext context) {
    if (data == null || data!.isEmpty) {
      return const Text('Sin datos para mostrar.');
    }

    final spots = data!.asMap().entries.map((entry) {
      return FlSpot(entry.key.toDouble(), (entry.value as num).toDouble());
    }).toList();

    return _ChartWrapper(
      title: title,
      child: LineChart(
        LineChartData(
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
        ),
      ),
    );
  }
}

class _BarChartBlock extends StatelessWidget {
  final String title;
  final List<dynamic>? data;

  const _BarChartBlock({required this.title, this.data});

  @override
  Widget build(BuildContext context) {
    if (data == null || data!.isEmpty) {
      return const Text('Sin datos para mostrar.');
    }

    final barGroups = data!.asMap().entries.map((entry) {
      return BarChartGroupData(x: entry.key, barRods: [
        BarChartRodData(toY: (entry.value as num).toDouble(), color: Colors.orange),
      ]);
    }).toList();

    return _ChartWrapper(
      title: title,
      child: BarChart(
        BarChartData(
          barGroups: barGroups,
          titlesData: FlTitlesData(show: false),
          gridData: FlGridData(show: false),
          borderData: FlBorderData(show: false),
        ),
      ),
    );
  }
}

class _ChartWrapper extends StatelessWidget {
  final String title;
  final Widget child;

  const _ChartWrapper({required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        SizedBox(height: 200, child: child),
      ],
    );
  }
}
