import 'package:flutter/material.dart';
import 'package:frontend_app/features/moderation/widgets/moderation_filters.dart';
import 'package:frontend_app/features/moderation/widgets/moderation_table.dart';
import 'package:frontend_app/data/models/moderation_report.dart';
import 'package:frontend_app/data/repositories/moderation_repository.dart';
import 'package:frontend_app/core/widgets/loading_indicator.dart';

class ModerationScreen extends StatefulWidget {
  const ModerationScreen({super.key});

  @override
  State<ModerationScreen> createState() => _ModerationScreenState();
}

class _ModerationScreenState extends State<ModerationScreen> {
  List<ModerationReport> _reports = [];
  bool _isLoading = false;
  String _selectedType = 'Todos';
  String _selectedStatus = 'Todos';

  @override
  void initState() {
    super.initState();
    _fetchReports();
  }

  Future<void> _fetchReports() async {
    setState(() => _isLoading = true);
    try {
      final reports = await ModerationRepository().getReports(
        type: _selectedType == 'Todos' ? null : _selectedType.toLowerCase(),
        status: _selectedStatus == 'Todos' ? null : _selectedStatus.toLowerCase(),
      );
      setState(() => _reports = reports);
    } catch (e) {
      // manejar errores si es necesario
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _onFilterChanged(String type, String status) {
    setState(() {
      _selectedType = type;
      _selectedStatus = status;
    });
    _fetchReports();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        ModerationFilters(onFilterChanged: _onFilterChanged),
        const SizedBox(height: 16),
        _isLoading
            ? const Center(child: LoadingIndicator())
            : Expanded(
                child: ModerationTable(reports: _reports),
              ),
      ],
    );
  }
}
