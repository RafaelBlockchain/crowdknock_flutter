import 'package:flutter/material.dart';
import '../../../core/widgets/admin_scaffold.dart';
import '../models/system_status_model.dart';
import '../services/system_status_service.dart';

class SystemStatusScreen extends StatefulWidget {
  const SystemStatusScreen({super.key});

  @override
  State<SystemStatusScreen> createState() => _SystemStatusScreenState();
}

class _SystemStatusScreenState extends State<SystemStatusScreen> {
  final _service = SystemStatusService();
  late Future<SystemStatus> _statusFuture;

  @override
  void initState() {
    super.initState();
    _statusFuture = _service.fetchSystemStatus();
  }

  String formatBytes(int bytes) {
    const suffixes = ['B', 'KB', 'MB', 'GB', 'TB'];
    int i = 0;
    double size = bytes.toDouble();
    while (size >= 1024 && i < suffixes.length - 1) {
      size /= 1024;
      i++;
    }
    return '${size.toStringAsFixed(2)} ${suffixes[i]}';
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

          return ListView(
            padding: const EdgeInsets.all(24.0),
            children: [
              ListTile(
                title: const Text('⏱ Uptime del Servidor'),
                subtitle: Text('${status.serverUptime.toStringAsFixed(2)} segundos'),
              ),
              ListTile(
                title: const Text('👥 Usuarios Activos'),
                subtitle: Text('${status.activeUsers}'),
              ),
              ListTile(
                title: const Text('💾 Uso de Memoria'),
                subtitle: Text(formatBytes(status.memoryUsage)),
              ),
              ListTile(
                title: const Text('📉 Carga del Sistema'),
                subtitle: Text(
                  '1m: ${status.systemLoad[0]}, 5m: ${status.systemLoad[1]}, 15m: ${status.systemLoad[2]}',
                ),
              ),
              ListTile(
                title: const Text('⚠️ Última Caída'),
                subtitle: Text(status.lastDowntime),
              ),
            ],
          );
        },
      ),
    );
  }
}
