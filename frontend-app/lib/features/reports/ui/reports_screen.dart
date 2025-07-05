import 'package:flutter/material.dart';
import 'package:frontend_app/features/reports/widgets/report_table.dart';

class ReportsScreen extends StatelessWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Reportes del Sistema')),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: ReportTable(),
      ),
    );
  }
}

