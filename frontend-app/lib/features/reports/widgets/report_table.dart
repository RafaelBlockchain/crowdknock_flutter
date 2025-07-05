import 'package:flutter/material.dart';
import 'package:frontend_app/data/models/report.dart';
import 'package:frontend_app/features/reports/data/report_repository.dart';

class ReportTable extends StatefulWidget {
  const ReportTable({super.key});

  @override
  State<ReportTable> createState() => _ReportTableState();
}

class _ReportTableState extends State<ReportTable> {
  List<Report> reports = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchReports();
  }

  Future<void> _fetchReports() async {
    try {
      final fetched = await ReportRepository().getReports();
      setState(() {
        reports = fetched;
        isLoading = false;
      });
    } catch (e) {
      debugPrint('Error: $e');
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) return const Center(child: CircularProgressIndicator());

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columns: const [
          DataColumn(label: Text('ID')),
          DataColumn(label: Text('Usuario')),
          DataColumn(label: Text('Tipo')),
          DataColumn(label: Text('Fecha')),
          DataColumn(label: Text('Estado')),
        ],
        rows: reports.map((r) {
          return DataRow(cells: [
            DataCell(Text(r.id.toString())),
            DataCell(Text(r.userName)),
            DataCell(Text(r.type)),
            DataCell(Text(r.createdAt.toString())),
            DataCell(Text(r.status)),
          ]);
        }).toList(),
      ),
    );
  }
}

