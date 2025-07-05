import 'package:flutter/material.dart';
import 'package:frontend_admin/widgets/layout/admin_scaffold.dart';
import 'package:frontend_admin/widgets/charts/users_chart.dart';
import 'package:frontend_admin/widgets/charts/sessions_chart.dart';
import 'package:frontend_admin/widgets/charts/reports_chart.dart';

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
                  Placeholder(), // Puedes reemplazar con un nuevo gráfico
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
