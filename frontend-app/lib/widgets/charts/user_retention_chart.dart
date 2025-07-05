import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class UserRetentionChart extends StatelessWidget {
  const UserRetentionChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: LineChart(
          LineChartData(
            titlesData: FlTitlesData(show: true),
            lineBarsData: [
              LineChartBarData(
                spots: [
                  FlSpot(0, 100),
                  FlSpot(1, 80),
                  FlSpot(2, 60),
                  FlSpot(3, 45),
                  FlSpot(4, 30),
                  FlSpot(5, 20),
                  FlSpot(6, 10),
                ],
                isCurved: true,
                color: Colors.purple,
                barWidth: 3,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

