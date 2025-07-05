import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class UsersChart extends StatelessWidget {
  const UsersChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BarChart(
          BarChartData(
            titlesData: FlTitlesData(
              leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: true)),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: (value, meta) {
                    const days = ['L', 'M', 'X', 'J', 'V', 'S', 'D'];
                    return Text(days[value.toInt() % 7]);
                  },
                ),
              ),
            ),
            barGroups: List.generate(7, (i) {
              return BarChartGroupData(
                x: i,
                barRods: [
                  BarChartRodData(toY: (i + 1) * 10.0, color: Colors.blueAccent),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}

