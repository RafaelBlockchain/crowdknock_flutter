// lib/pages/app_metrics_screen.dart

import 'package:flutter/material.dart';
import 'package:frontend_admin/widgets/layout/admin_scaffold.dart';
import 'package:frontend_admin/widgets/charts/users_chart.dart';
import 'package:frontend_admin/widgets/charts/sessions_chart.dart';
import 'package:frontend_admin/widgets/charts/reports_chart.dart';
import 'package:frontend_admin/widgets/charts/user_retention_chart.dart';
import 'package:frontend_admin/widgets/charts/content_time_chart.dart';
import 'package:frontend_admin/widgets/charts/devices_used_chart.dart';

class AppMetricsScreen extends StatelessWidget {
  const AppMetricsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
      title: '📊 Métricas de la App',
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const Text(
              'Estadísticas Generales',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 24,
                mainAxisSpacing: 24,
                children: const [
                  UsersChart(),
                  SessionsChart(),
                  ReportsChart(),
                  UserRetentionChart(),
                  ContentTimeChart(),
                  DevicesUsedChart(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
