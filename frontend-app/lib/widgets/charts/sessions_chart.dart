import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class SessionsChart extends StatelessWidget {
  const SessionsChart({super.key});

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
                  FlSpot(0, 5),
                  FlSpot(1, 6),
                  FlSpot(2, 7),
                  FlSpot(3, 5),
                  FlSpot(4, 8),
                  FlSpot(5, 6),
                  FlSpot(6, 9),
                ],
                isCurved: true,
                color: Colors.green,
                barWidth: 3,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

