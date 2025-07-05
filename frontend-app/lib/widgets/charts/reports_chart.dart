import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ReportsChart extends StatelessWidget {
  const ReportsChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: PieChart(
          PieChartData(
            sections: [
              PieChartSectionData(
                value: 40,
                title: 'Pendientes',
                color: Colors.orange,
                radius: 60,
              ),
              PieChartSectionData(
                value: 30,
                title: 'Revisados',
                color: Colors.blue,
                radius: 60,
              ),
              PieChartSectionData(
                value: 30,
                title: 'Resueltos',
                color: Colors.green,
                radius: 60,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

