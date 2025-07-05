import 'package:flutter/material.dart';

class ReportsOverviewCard extends StatelessWidget {
  final int totalReports;
  final int resolvedReports;

  const ReportsOverviewCard({
    super.key,
    required this.totalReports,
    required this.resolvedReports,
  });

  @override
  Widget build(BuildContext context) {
    final unresolved = totalReports - resolvedReports;
    final resolvedPercentage = totalReports == 0
        ? 0
        : ((resolvedReports / totalReports) * 100).round();

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '🛡️ Reportes',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildMetric('Totales', totalReports, Colors.orange),
                _buildMetric('Resueltos', resolvedReports, Colors.green),
                _buildMetric('Pendientes', unresolved, Colors.red),
              ],
            ),
            const SizedBox(height: 12),
            LinearProgressIndicator(
              value: resolvedReports / (totalReports == 0 ? 1 : totalReports),
              color: Colors.green,
              backgroundColor: Colors.grey[300],
              minHeight: 8,
              borderRadius: BorderRadius.circular(4),
            ),
            const SizedBox(height: 8),
            Text('Resueltos: $resolvedPercentage%'),
          ],
        ),
      ),
    );
  }

  Widget _buildMetric(String label, int value, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$value',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: color),
        ),
        Text(label),
      ],
    );
  }
}
