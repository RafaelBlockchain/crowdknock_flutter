import 'package:flutter/material.dart';
import 'package:frontend_app/data/models/report.dart';
import 'package:frontend_app/features/reports/data/report_repository.dart';
import 'package:frontend_app/features/reports/widgets/report_filters.dart';

class ReportTable extends StatefulWidget {
  const ReportTable({super.key});

  @override
  State<ReportTable> createState() => _ReportTableState();
}

class _ReportTableState extends State<ReportTable> {
  List<Report> allReports = [];
  List<Report> filteredReports = [];
  bool isLoading = true;

  String? selectedType;
  String? selectedStatus;

  @override
  void initState() {
    super.initState();
    _fetchReports();
  }

  Future<void> _fetchReports() async {
    try {
      final reports = await ReportRepository().getReports();
      setState(() {
        allReports = reports;
        filteredReports = reports;
        isLoading = false;
      });
    } catch (e) {
      debugPrint('Error fetching reports: $e');
      setState(() => isLoading = false);
    }
  }

  void _applyFilters() {
    setState(() {
      filteredReports = allReports.where((r) {
        final typeMatch = selectedType == null || r.type == selectedType;
        final statusMatch = selectedStatus == null || r.status == selectedStatus;
        return typeMatch && statusMatch;
      }).toList();
    });
  }

  void _onTypeChanged(String? type) {
    setState(() => selectedType = type);
    _applyFilters();
  }

  void _onStatusChanged(String? status) {
    setState(() => selectedStatus = status);
    _applyFilters();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) return const Center(child: CircularProgressIndicator());

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ReportFilters(
          selectedType: selectedType,
          selectedStatus: selectedStatus,
          onTypeChanged: _onTypeChanged,
          onStatusChanged: _onStatusChanged,
        ),
        const SizedBox(height: 20),
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columns: const [
                DataColumn(label: Text('ID')),
                DataColumn(label: Text('Usuario')),
                DataColumn(label: Text('Tipo')),
                DataColumn(label: Text('Fecha')),
                DataColumn(label: Text('Estado')),
              ],
              rows: filteredReports.map((r) {
                return DataRow(cells: [
                  DataCell(Text(r.id.toString())),
                  DataCell(Text(r.userName)),
                  DataCell(Text(r.type)),
                  DataCell(Text(r.createdAt.toLocal().toString())),
                  DataCell(Text(r.status)),
                ]);
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}

