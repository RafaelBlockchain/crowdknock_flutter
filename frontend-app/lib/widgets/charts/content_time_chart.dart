import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ContentTimeChart extends StatelessWidget {
  const ContentTimeChart({super.key});

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
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: (value, _) {
                    final contents = ['Video', 'Audio', 'Artículo', 'Encuesta'];
                    return Text(contents[value.toInt() % contents.length]);
                  },
                ),
              ),
            ),
            barGroups: [
              BarChartGroupData(x: 0, barRods: [BarChartRodData(toY: 5.3, color: Colors.teal)]),
              BarChartGroupData(x: 1, barRods: [BarChartRodData(toY: 3.2, color: Colors.teal)]),
              BarChartGroupData(x: 2, barRods: [BarChartRodData(toY: 6.1, color: Colors.teal)]),
              BarChartGroupData(x: 3, barRods: [BarChartRodData(toY: 2.8, color: Colors.teal)]),
            ],
          ),
        ),
      ),
    );
  }
}

