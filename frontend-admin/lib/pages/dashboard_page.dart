import 'package:flutter/material.dart';
import '../widgets/dashboard/user_count_card.dart';
import '../widgets/dashboard/content_stats_card.dart';
import '../widgets/dashboard/challenge_stats_card.dart';
import '../widgets/dashboard/reports_overview_card.dart';
import '../widgets/dashboard/mini_chart_card.dart';
import '../widgets/dashboard/dashboard_grid.dart';
import '../widgets/admin_scaffold.dart';
import 'package:fl_chart/fl_chart.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
      title: '📊 Dashboard',
      currentRoute: '/dashboard',
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Welcome to the CrowdKnock Admin Dashboard',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            /// Dashboard grid
            DashboardGrid(children: [
              const UserCountCard(count: 2450),
              const ContentStatsCard(
                videos: 340,
                audios: 120,
                stories: 210,
              ),
              const ChallengeStatsCard(
                total: 120,
                active: 85,
                completed: 35,
              ),
              const ReportsOverviewCard(
                totalReports: 62,
                resolvedReports: 41,
              ),
              MiniChartCard(
                title: 'Nuevos usuarios',
                color: Colors.purple,
                dataPoints: [
                  FlSpot(0, 50),
                  FlSpot(1, 70),
                  FlSpot(2, 65),
                  FlSpot(3, 90),
                  FlSpot(4, 85),
                  FlSpot(5, 95),
                  FlSpot(6, 120),
                ],
              ),
              MiniChartCard(
                title: 'Publicaciones por día',
                color: Colors.orange,
                dataPoints: [
                  FlSpot(0, 30),
                  FlSpot(1, 45),
                  FlSpot(2, 40),
                  FlSpot(3, 55),
                  FlSpot(4, 60),
                  FlSpot(5, 65),
                  FlSpot(6, 75),
                ],
              ),
            ]),
          ],
        ),
      ),
    );
  }
}
