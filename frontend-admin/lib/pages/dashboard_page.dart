import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../layout/admin_scaffold.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  // 🔧 Datos simulados. Reemplazar con datos reales del backend.
  final int totalUsers = 1287;
  final int totalReports = 145;
  final int totalChallenges = 312;
  final int contentModerated = 58;

  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
      title: '📊 Dashboard',
      currentRoute: '/dashboard',
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            const Text(
              'Welcome to the Admin Dashboard',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            const Text(
              'From here you can manage users, content, moderation tasks, system metrics, and more.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 24),

            // 🧩 Summary Cards
            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: [
                _DashboardCard(
                  icon: Icons.people,
                  title: 'Total Users',
                  value: '$totalUsers',
                  color: Colors.indigo,
                ),
                _DashboardCard(
                  icon: Icons.flag,
                  title: 'Total Reports',
                  value: '$totalReports',
                  color: Colors.red,
                ),
                _DashboardCard(
                  icon: Icons.lightbulb,
                  title: 'Challenges',
                  value: '$totalChallenges',
                  color: Colors.orange,
                ),
                _DashboardCard(
                  icon: Icons.verified,
                  title: 'Moderated Content',
                  value: '$contentModerated',
                  color: Colors.green,
                ),
              ],
            ),

            const SizedBox(height: 32),

            const Text(
              '📈 User Activity (Monthly)',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 16),

            SizedBox(
              height: 250,
              child: LineChart(
                LineChartData(
                  titlesData: FlTitlesData(show: true),
                  gridData: FlGridData(show: true),
                  borderData: FlBorderData(show: true),
                  lineBarsData: [
                    LineChartBarData(
                      isCurved: true,
                      spots: const [
                        FlSpot(0, 120),
                        FlSpot(1, 140),
                        FlSpot(2, 110),
                        FlSpot(3, 180),
                        FlSpot(4, 220),
                        FlSpot(5, 190),
                        FlSpot(6, 240),
                      ],
                      colors: [Colors.indigo],
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

// 🔢 Widget de tarjeta resumen
class _DashboardCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final Color color;

  const _DashboardCard({
    required this.icon,
    required this.title,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 240,
      height: 120,
      child: Card(
        color: color.withOpacity(0.1),
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: color,
                child: Icon(icon, color: Colors.white),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    value,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                  Text(title, style: const TextStyle(fontSize: 14)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
