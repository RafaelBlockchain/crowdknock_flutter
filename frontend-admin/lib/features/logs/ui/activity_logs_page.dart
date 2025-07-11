import 'package:flutter/material.dart';
import 'package:frontend_admin/core/constants/app_colors.dart';
import 'package:frontend_admin/core/layouts/admin_layout.dart';
import 'package:frontend_admin/core/services/log_service.dart';

class ActivityLogsPage extends StatefulWidget {
  const ActivityLogsPage({super.key});

  @override
  State<ActivityLogsPage> createState() => _ActivityLogsPageState();
}

class _ActivityLogsPageState extends State<ActivityLogsPage> {
  final LogService _logService = LogService();
  List<Map<String, dynamic>> _logs = [];
  bool _isLoading = true;
  String? _error;
  String _searchTerm = '';

  @override
  void initState() {
    super.initState();
    _loadLogs();
  }

  Future<void> _loadLogs() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final data = await _logService.fetchActivityLogs();
      setState(() {
        _logs = data;
      });
    } catch (e) {
      setState(() {
        _error = 'Error al cargar los registros de actividad.';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  List<Map<String, dynamic>> get _filteredLogs {
    if (_searchTerm.isEmpty) return _logs;
    return _logs
        .where((log) =>
            log['description']?.toLowerCase().contains(_searchTerm.toLowerCase()) == true ||
            log['user']?.toLowerCase().contains(_searchTerm.toLowerCase()) == true)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return AdminLayout(
      title: 'Activity Logs',
      child: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
              ? Center(child: Text(_error!, style: const TextStyle(color: Colors.red)))
              : _logs.isEmpty
                  ? const Center(child: Text('No hay registros de actividad.'))
                  : SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Historial del sistema',
                            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 16),
                          _SearchBar(
                            onChanged: (value) => setState(() => _searchTerm = value),
                          ),
                          const SizedBox(height: 24),
                          _LogsTable(logs: _filteredLogs),
                        ],
                      ),
                    ),
    );
  }
}

class _SearchBar extends StatelessWidget {
  final void Function(String) onChanged;

  const _SearchBar({required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: 'Buscar por usuario o acción...',
        prefixIcon: const Icon(Icons.search),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      ),
    );
  }
}

class _LogsTable extends StatelessWidget {
  final List<Map<String, dynamic>> logs;

  const _LogsTable({required this.logs});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4)],
      ),
      padding: const EdgeInsets.all(24),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columnSpacing: 24,
          columns: const [
            DataColumn(label: Text('Fecha')),
            DataColumn(label: Text('Usuario')),
            DataColumn(label: Text('Acción')),
            DataColumn(label: Text('IP')),
          ],
          rows: logs.map((log) {
            return DataRow(
              cells: [
                DataCell(Text(log['timestamp'] ?? 'N/A')),
                DataCell(Text(log['user'] ?? 'Anónimo')),
                DataCell(Text(log['description'] ?? 'Sin acción')),
                DataCell(Text(log['ip'] ?? '-')),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}
