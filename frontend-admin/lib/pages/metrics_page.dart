import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class MetricsPage extends StatelessWidget {
  const MetricsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      drawer: const _AdminSidebar(activeRoute: '/metrics'),
      appBar: AppBar(
        title: const Text('📊 Métricas de la App'),
        backgroundColor: Colors.indigo,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
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

// Sidebar adaptado
class _AdminSidebar extends StatelessWidget {
  final String activeRoute;
  const _AdminSidebar({required this.activeRoute, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'CrowdKnock Admin',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.indigo),
          ),
          const SizedBox(height: 20),
          _SidebarItem(title: 'Dashboard', route: '/dashboard', isActive: activeRoute == '/dashboard'),
          _SidebarItem(title: 'Analytics', route: '/analytics', isActive: activeRoute == '/analytics'),
          _SidebarItem(title: 'Métricas App', route: '/metrics', isActive: activeRoute == '/metrics'),
          _SidebarItem(title: 'Configuración', route: '/settings', isActive: activeRoute == '/settings'),
        ],
      ),
    );
  }
}

class _SidebarItem extends StatelessWidget {
  final String title;
  final String route;
  final bool isActive;

  const _SidebarItem({required this.title, required this.route, this.isActive = false});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      tileColor: isActive ? Colors.indigo[500] : null,
      textColor: isActive ? Colors.white : null,
      onTap: () {
        if (!isActive) Navigator.pushReplacementNamed(context, route);
        else Navigator.pop(context);
      },
    );
  }
}

// Card individual de métrica
class _MetricCard extends StatelessWidget {
  final String title;
  final String value;
  final Color? valueColor;

  const _MetricCard({required this.title, required this.value, this.valueColor});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Text(title, style: const TextStyle(fontSize: 12, color: Colors.grey, fontWeight: FontWeight.w500)),
              const SizedBox(height: 8),
              Text(
                value,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: valueColor ?? Colors.black),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Gráfico de usuarios activos
class _ActiveUsersChartCard extends StatelessWidget {
  const _ActiveUsersChartCard({super.key});

  @override
  Widget build(BuildContext context) {
    final spots = [
      FlSpot(0, 1000),
      FlSpot(1, 2400),
      FlSpot(2, 3600),
      FlSpot(3, 4000),
      FlSpot(4, 3800),
      FlSpot(5, 4700),
      FlSpot(6, 5200),
    ];

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Usuarios Activos por Día', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Expanded(
              child: LineChart(
                LineChartData(
                  gridData: FlGridData(show: true),
                  borderData: FlBorderData(show: true),
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: true, reservedSize: 40),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, _) {
                          const days = ['Lun', 'Mar', 'Mié', 'Jue', 'Vie', 'Sáb', 'Dom'];
                          return Text(value.toInt() < days.length ? days[value.toInt()] : '');
                        },
                      ),
                    ),
                    rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  ),
                  lineBarsData: [
                    LineChartBarData(
                      spots: spots,
                      isCurved: true,
                      color: Colors.indigo,
                      barWidth: 3,
                      dotData: FlDotData(show: true),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Reportes de fallos
class _CrashReportsCard extends StatelessWidget {
  const _CrashReportsCard();

  @override
  Widget build(BuildContext context) {
    final crashReports = [
      {'package': 'com.crowdknock.home', 'count': 1},
      {'package': 'com.crowdknock.feed', 'count': 1},
      {'package': 'com.crowdknock.video', 'count': 1},
    ];

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Reportes de Fallos', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Expanded(
              child: ListView.separated(
                itemCount: crashReports.length,
                separatorBuilder: (_, __) => const Divider(height: 1),
                itemBuilder: (context, index) {
                  final report = crashReports[index];
                  return ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(report['package']!),
                    trailing: Text('${report['count']} crash', style: const TextStyle(color: Colors.red)),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
