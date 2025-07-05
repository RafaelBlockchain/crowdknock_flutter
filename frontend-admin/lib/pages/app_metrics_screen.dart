import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class AppMetricsScreen extends StatelessWidget {
  const AppMetricsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Row(
        children: [
          // Sidebar
          Container(
            width: 260,
            padding: const EdgeInsets.all(16),
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'CrowdKnock Admin',
                  style: TextStyle(
                    color: Color(0xFF4F46E5),
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 24),
                _NavLink(label: 'Dashboard', route: '/dashboard'),
                _NavLink(label: 'Manage Users', route: '/manage-users'),
                _NavLink(label: 'Manage Content', route: '/manage-content'),
                _NavLink(label: 'Moderation', route: '/moderation'),
                _NavLink(label: 'Métricas', route: '/app-metrics', selected: true),
                _NavLink(label: 'Settings', route: '/settings'),
              ],
            ),
          ),

          // Main content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '📊 Métricas de la App',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Visualización general del rendimiento y uso reciente de la plataforma.',
                    style: TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 32),

                  // Métricas principales
                  LayoutBuilder(
                    builder: (context, constraints) {
                      int crossAxisCount = 1;
                      if (screenWidth > 1024) {
                        crossAxisCount = 3;
                      } else if (screenWidth > 768) {
                        crossAxisCount = 2;
                      }

                      return GridView.count(
                        crossAxisCount: crossAxisCount,
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 20,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        children: const [
                          _MetricCard(title: '👥 Total de Usuarios', value: '12,340'),
                          _MetricCard(title: '📹 Videos Subidos', value: '842'),
                          _MetricCard(title: '🔥 Desafíos Activos', value: '29'),
                        ],
                      );
                    },
                  ),

                  const SizedBox(height: 32),

                  // Gráficos
                  LayoutBuilder(
                    builder: (context, constraints) {
                      final isWide = constraints.maxWidth > 1000;
                      return Flex(
                        direction: isWide ? Axis.horizontal : Axis.vertical,
                        children: [
                          Expanded(
                            child: _ChartCard(
                              title: '📈 Nuevos Usuarios (últimos 7 días)',
                              chart: _buildLineChart(),
                            ),
                          ),
                          const SizedBox(width: 16, height: 16),
                          Expanded(
                            child: _ChartCard(
                              title: '👁️‍🗨️ Visitas a Videos por Día',
                              chart: _buildBarChart(),
                            ),
                          ),
                        ],
                      );
                    },
                  ),

                  const SizedBox(height: 40),
                  const Center(
                    child: Text(
                      '© 2025 CrowdKnock. Todos los derechos reservados.',
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- CHARTS ---

  static Widget _buildLineChart() {
    return LineChart(
      LineChartData(
        titlesData: FlTitlesData(
          leftTitles: const AxisTitles(),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              interval: 1,
              getTitlesWidget: (value, meta) {
                const labels = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
                return Text(labels[value.toInt() % 7]);
              },
            ),
          ),
        ),
        gridData: FlGridData(show: false),
        lineBarsData: [
          LineChartBarData(
            isCurved: true,
            color: const Color(0xFF6366F1),
            belowBarData: BarAreaData(
              show: true,
              color: const Color(0xFF6366F1).withOpacity(0.2),
            ),
            dotData: FlDotData(show: false),
            spots: const [
              FlSpot(0, 30),
              FlSpot(1, 50),
              FlSpot(2, 45),
              FlSpot(3, 70),
              FlSpot(4, 60),
              FlSpot(5, 90),
              FlSpot(6, 100),
            ],
          ),
        ],
      ),
    );
  }

  static Widget _buildBarChart() {
    return BarChart(
      BarChartData(
        titlesData: FlTitlesData(
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                const labels = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
                return Text(labels[value.toInt() % 7]);
              },
            ),
          ),
        ),
        gridData: FlGridData(show: false),
        barGroups: const [
          BarChartGroupData(x: 0, barRods: [BarChartRodData(toY: 400, color: Color(0xFF10B981))]),
          BarChartGroupData(x: 1, barRods: [BarChartRodData(toY: 520, color: Color(0xFF10B981))]),
          BarChartGroupData(x: 2, barRods: [BarChartRodData(toY: 600, color: Color(0xFF10B981))]),
          BarChartGroupData(x: 3, barRods: [BarChartRodData(toY: 710, color: Color(0xFF10B981))]),
          BarChartGroupData(x: 4, barRods: [BarChartRodData(toY: 800, color: Color(0xFF10B981))]),
          BarChartGroupData(x: 5, barRods: [BarChartRodData(toY: 950, color: Color(0xFF10B981))]),
          BarChartGroupData(x: 6, barRods: [BarChartRodData(toY: 1200, color: Color(0xFF10B981))]),
        ],
      ),
    );
  }
}

// --- WIDGETS ---

class _NavLink extends StatelessWidget {
  final String label;
  final String route;
  final bool selected;

  const _NavLink({
    required this.label,
    required this.route,
    this.selected = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, route),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: selected ? Colors.indigo : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: selected ? Colors.white : Colors.black87,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

class _MetricCard extends StatelessWidget {
  final String title;
  final String value;

  const _MetricCard({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shadowColor: Colors.black12,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: TextStyle(color: Colors.grey[600], fontSize: 14)),
            const SizedBox(height: 8),
            Text(value,
                style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}

class _ChartCard extends StatelessWidget {
  final String title;
  final Widget chart;

  const _ChartCard({required this.title, required this.chart});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shadowColor: Colors.black12,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
            const SizedBox(height: 16),
            SizedBox(height: 200, child: chart),
          ],
        ),
      ),
    );
  }
}
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
      title: '📊 App Metrics',
      currentRoute: '/metrics',
      child: Padding(
        padding: const EdgeInsets.all(16.0),
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
            final avgSession = (metrics['avgSessionTime'] ?? 0).toDouble();
            final crashReports = (metrics['crashReports'] ?? 0).toDouble();

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'App Metrics Overview',
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
                        leftTitles: SideTitles(showTitles: true),
                        bottomTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (value, meta) {
                            const labels = ['Users', 'Session', 'Crashes'];
                            return Text(labels[value.toInt()]);
                          },
                        ),
                      ),
                      borderData: FlBorderData(show: false),
                      barGroups: [
                        BarChartGroupData(x: 0, barRods: [
                          BarChartRodData(toY: activeUsers, color: Colors.blue)
                        ]),
                        BarChartGroupData(x: 1, barRods: [
                          BarChartRodData(toY: avgSession, color: Colors.green)
                        ]),
                        BarChartGroupData(x: 2, barRods: [
                          BarChartRodData(toY: crashReports, color: Colors.red)
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
