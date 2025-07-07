import 'package:flutter/material.dart';
import 'package:frontend_app/core/widgets/admin_scaffold.dart';
import 'package:frontend_app/features/system_status/models/system_status_model.dart';
import 'package:frontend_app/features/system_status/services/system_status_service.dart';

class SystemStatusScreen extends StatefulWidget {
  const SystemStatusScreen({super.key});

  @override
  State<SystemStatusScreen> createState() => _SystemStatusScreenState();
}

class _SystemStatusScreenState extends State<SystemStatusScreen> {
  final SystemStatusService _statusService = SystemStatusService();
  late Future<SystemStatus> _statusFuture;

  @override
  void initState() {
    super.initState();
    _statusFuture = _statusService.fetchStatus();
  }

  Future<void> _refreshStatus() async {
    setState(() {
      _statusFuture = _statusService.fetchStatus();
    });
  }

  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
      title: 'Estado del Sistema',
      child: FutureBuilder<SystemStatus>(
        future: _statusFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          final status = snapshot.data!;
          return RefreshIndicator(
            onRefresh: _refreshStatus,
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                _buildStatusTile('API Backend', status.apiStatus),
                _buildStatusTile('Base de Datos', status.dbStatus),
                _buildStatusTile('Versión del Sistema', status.version),
                _buildStatusTile('Última Actualización',
                    status.lastUpdated.toLocal().toString()),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildStatusTile(String title, String value) {
    final isOk = value.toLowerCase().contains('ok') ||
        value.toLowerCase().contains('activo');

    return Card(
      child: ListTile(
        leading: Icon(
          isOk ? Icons.check_circle : Icons.warning,
          color: isOk ? Colors.green : Colors.red,
        ),
        title: Text(title),
        subtitle: Text(value),
      ),
    );
  }
}
