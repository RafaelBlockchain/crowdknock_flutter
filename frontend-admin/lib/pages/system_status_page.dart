import 'package:flutter/material.dart';

class SystemStatusPage extends StatefulWidget {
  const SystemStatusPage({super.key});

  @override
  State<SystemStatusPage> createState() => _SystemStatusPageState();
}

class _SystemStatusPageState extends State<SystemStatusPage> {
  // Simulación de estados del sistema
  final List<Map<String, dynamic>> systemComponents = [
    {
      'name': 'Servidor Principal',
      'status': true,
      'lastChecked': '2025-07-03 11:45',
    },
    {
      'name': 'Base de Datos PostgreSQL',
      'status': true,
      'lastChecked': '2025-07-03 11:45',
    },
    {
      'name': 'API REST',
      'status': false,
      'lastChecked': '2025-07-03 11:40',
    },
    {
      'name': 'Sistema de Colas (Redis)',
      'status': true,
      'lastChecked': '2025-07-03 11:45',
    },
    {
      'name': 'Notificaciones WebSocket',
      'status': false,
      'lastChecked': '2025-07-03 11:43',
    },
  ];

  Widget buildStatusIcon(bool status) {
    return Icon(
      status ? Icons.check_circle : Icons.error,
      color: status ? Colors.green : Colors.red,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const _Sidebar(),
      appBar: AppBar(
        title: const Text('⚙️ Estado del Sistema'),
        backgroundColor: Colors.indigo,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text(
              'Monitor de Componentes del Sistema',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.separated(
                itemCount: systemComponents.length,
                separatorBuilder: (_, __) => const Divider(),
                itemBuilder: (context, index) {
                  final component = systemComponents[index];
                  return ListTile(
                    leading: buildStatusIcon(component['status']),
                    title: Text(component['name']),
                    subtitle: Text('Última verificación: ${component['lastChecked']}'),
                    trailing: Text(
                      component['status'] ? 'Activo' : 'Inactivo',
                      style: TextStyle(
                        color: component['status'] ? Colors.green : Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {
                // Simulación: podrías implementar aquí la lógica real para actualizar estados
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Estado del sistema actualizado')),
                );
              },
              icon: const Icon(Icons.refresh),
              label: const Text('Actualizar Estado'),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.indigo),
            )
          ],
        ),
      ),
    );
  }
}

// 🧭 Sidebar reutilizable
class _Sidebar extends StatelessWidget {
  const _Sidebar();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          Text(
            'CrowdKnock Admin',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.indigo,
            ),
          ),
          SizedBox(height: 20),
          _SidebarItem(title: 'Dashboard', route: '/dashboard'),
          _SidebarItem(title: 'Manage Content', route: '/manage-content'),
          _SidebarItem(title: 'Moderación', route: '/moderation'),
          _SidebarItem(title: 'Payments', route: '/payments'),
          _SidebarItem(title: 'Estado del Sistema', route: '/system-status', isActive: true),
        ],
      ),
    );
  }
}

class _SidebarItem extends StatelessWidget {
  final String title;
  final String route;
  final bool isActive;

  const _SidebarItem({
    required this.title,
    required this.route,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      tileColor: isActive ? Colors.indigo[500] : null,
      textColor: isActive ? Colors.white : null,
      onTap: () {
        if (!isActive) {
          Navigator.pushNamed(context, route);
        } else {
          Navigator.pop(context);
        }
      },
    );
  }
}

