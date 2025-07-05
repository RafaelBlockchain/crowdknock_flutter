import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class DevicesUsedChart extends StatelessWidget {
  const DevicesUsedChart({super.key});

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
                value: 50,
                title: '📱 Móvil',
                color: Colors.blueAccent,
                radius: 60,
              ),
              PieChartSectionData(
                value: 30,
                title: '💻 Web',
                color: Colors.orangeAccent,
                radius: 60,
              ),
              PieChartSectionData(
                value: 20,
                title: '🖥️ Escritorio',
                color: Colors.greenAccent,
                radius: 60,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

