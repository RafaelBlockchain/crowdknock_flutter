import 'package:flutter/material.dart';
import 'package:frontend_app/core/widgets/admin_scaffold.dart';
import 'package:frontend_app/features/reports/models/report_model.dart';
import 'package:frontend_app/features/reports/services/reports_service.dart';
import 'package:frontend_app/features/reports/widgets/report_table.dart';

class ReportsScreen extends StatefulWidget {
  const ReportsScreen({super.key});

  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  final ReportsService _reportsService = ReportsService();
  late Future<List<Report>> _reportsFuture;

  @override
  void initState() {
    super.initState();
    _reportsFuture = _reportsService.getAllReports();
  }

  Future<void> _refreshReports() async {
    setState(() {
      _reportsFuture = _reportsService.getAllReports();
    });
  }

  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
      title: 'Reportes de Contenido',
      child: FutureBuilder<List<Report>>(
        future: _reportsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          final reports = snapshot.data!;
          return ReportTable(reports: reports, onRefresh: _refreshReports);
        },
      ),
    );
  }
}
