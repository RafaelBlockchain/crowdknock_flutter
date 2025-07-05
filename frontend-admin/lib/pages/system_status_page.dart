import 'package:flutter/material.dart';
import '../services/system_status_service.dart';

class SystemStatusPage extends StatefulWidget {
  const SystemStatusPage({super.key});

  @override
  State<SystemStatusPage> createState() => _SystemStatusPageState();
}

class _SystemStatusPageState extends State<SystemStatusPage> {
  // Servicio para consultar el estado del sistema
  final systemService = SystemStatusService(baseUrl: 'https://tu-servidor.com');

  late Future<List<SystemComponentStatus>> futureStatus;

  @override
  void initState() {
    super.initState();
    futureStatus = systemService.fetchSystemStatus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🛠️ System Status'),
        backgroundColor: Colors.indigo,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: FutureBuilder<List<SystemComponentStatus>>(
          future: futureStatus,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(
                child: Text('❌ Error: \${snapshot.error}'),
              );
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No system status data available.'));
            }

            final components = snapshot.data!;
            return ListView.builder(
              itemCount: components.length,
              itemBuilder: (context, index) {
                final component = components[index];
                return Card(
                  child: ListTile(
                    leading: Icon(
                      component.status ? Icons.check_circle : Icons.error,
                      color: component.status ? Colors.green : Colors.red,
                    ),
                    title: Text(component.name),
                    subtitle: Text('Last checked: \${component.lastChecked}'),
                    trailing: Text(
                      component.status ? 'Operational' : 'Down',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: component.status ? Colors.green : Colors.red,
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import '../layout/admin_scaffold.dart';
import '../services/system_status_service.dart';

class SystemStatusPage extends StatefulWidget {
  const SystemStatusPage({super.key});

  @override
  State<SystemStatusPage> createState() => _SystemStatusPageState();
}

class _SystemStatusPageState extends State<SystemStatusPage> {
  late Future<Map<String, dynamic>> _statusFuture;

  @override
  void initState() {
    super.initState();
    _statusFuture = SystemStatusService.getSystemStatus();
  }

  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
      title: '💻 System Status',
      currentRoute: '/system-status',
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: FutureBuilder<Map<String, dynamic>>(
          future: _statusFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(child: Text('❌ Error: ${snapshot.error}'));
            }

            final status = snapshot.data!;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Current System Status',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                Card(
                  child: ListTile(
                    title: const Text('Database'),
                    trailing: Text(
                      status['database'] ?? 'Unknown',
                      style: TextStyle(
                        color: status['database'] == 'Online' ? Colors.green : Colors.red,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Card(
                  child: ListTile(
                    title: const Text('API Server'),
                    trailing: Text(
                      status['api'] ?? 'Unknown',
                      style: TextStyle(
                        color: status['api'] == 'Online' ? Colors.green : Colors.red,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Card(
                  child: ListTile(
                    title: const Text('Storage Service'),
                    trailing: Text(
                      status['storage'] ?? 'Unknown',
                      style: TextStyle(
                        color: status['storage'] == 'Online' ? Colors.green : Colors.red,
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
