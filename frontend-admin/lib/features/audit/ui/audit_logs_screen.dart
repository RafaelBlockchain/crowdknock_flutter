import 'package:flutter/material.dart';
import 'package:frontend_admin/core/constants/app_colors.dart';
import 'package:frontend_admin/core/layouts/admin_layout.dart';
import 'package:frontend_admin/core/services/audit_service.dart';

class AuditLogsScreen extends StatefulWidget {
  const AuditLogsScreen({super.key});

  @override
  State<AuditLogsScreen> createState() => _AuditLogsScreenState();
}

class _AuditLogsScreenState extends State<AuditLogsScreen> {
  final AuditService _auditService = AuditService();
  List<Map<String, dynamic>> _logs = [];
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _fetchLogs();
  }

  Future<void> _fetchLogs() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final data = await _auditService.fetchAuditLogs();
      setState(() {
        _logs = data;
      });
    } catch (e) {
      setState(() {
        _error = 'Error al cargar los registros de auditoría.';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Widget _buildLogTile(Map<String, dynamic> log) {
    return ListTile(
      leading: const Icon(Icons.history, color: AppColors.primary),
      title: Text(log['action'] ?? 'Acción desconocida'),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Usuario: ${log['user'] ?? 'Desconocido'}'),
          Text('Fecha: ${log['timestamp'] ?? 'N/A'}'),
        ],
      ),
      trailing: const Icon(Icons.arrow_forward_ios, size: 14),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AdminLayout(
      title: 'Registro de Auditoría',
      child: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
              ? Center(child: Text(_error!, style: const TextStyle(color: Colors.red)))
              : _logs.isEmpty
                  ? const Center(child: Text('No hay registros aún.'))
                  : ListView.separated(
                      itemCount: _logs.length,
                      separatorBuilder: (_, __) => const Divider(height: 1),
                      itemBuilder: (_, index) => _buildLogTile(_logs[index]),
                    ),
    );
  }
}
