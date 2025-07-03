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
