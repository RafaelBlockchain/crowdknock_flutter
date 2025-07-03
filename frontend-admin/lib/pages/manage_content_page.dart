import 'package:flutter/material.dart';

class ManageContentPage extends StatefulWidget {
  const ManageContentPage({super.key});

  @override
  State<ManageContentPage> createState() => _ManageContentPageState();
}

class _ManageContentPageState extends State<ManageContentPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // Simulación de contenido moderado
  final List<Map<String, dynamic>> videoContent = [
    {
      'title': 'Protesta en Santiago',
      'uploader': 'Usuario123',
      'status': 'pendiente',
      'fecha': '2025-07-01'
    },
    {
      'title': 'Incendio en Valpo',
      'uploader': 'Ana89',
      'status': 'aprobado',
      'fecha': '2025-06-28'
    },
  ];

  final List<Map<String, dynamic>> audioContent = [
    {
      'title': 'Testimonio ciudadana',
      'uploader': 'Luis_R',
      'status': 'pendiente',
      'fecha': '2025-06-30'
    },
  ];

  final List<Map<String, dynamic>> storyContent = [
    {
      'title': 'Relato desde Antofagasta',
      'uploader': 'Carlos_T',
      'status': 'rechazado',
      'fecha': '2025-06-27'
    },
  ];

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Widget buildTable(List<Map<String, dynamic>> data) {
    return DataTable(
      columns: const [
        DataColumn(label: Text('Título')),
        DataColumn(label: Text('Usuario')),
        DataColumn(label: Text('Fecha')),
        DataColumn(label: Text('Estado')),
        DataColumn(label: Text('Acciones')),
      ],
      rows: data
          .map(
            (item) => DataRow(cells: [
              DataCell(Text(item['title'])),
              DataCell(Text(item['uploader'])),
              DataCell(Text(item['fecha'])),
              DataCell(_statusBadge(item['status'])),
              DataCell(Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.check_circle, color: Colors.green),
                    tooltip: 'Aprobar',
                    onPressed: () {
                      // Lógica para aprobar
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.cancel, color: Colors.red),
                    tooltip: 'Rechazar',
                    onPressed: () {
                      // Lógica para rechazar
                    },
                  ),
                ],
              )),
            ]),
          )
          .toList(),
    );
  }

  Widget _statusBadge(String status) {
    Color color;
    switch (status) {
      case 'pendiente':
        color = Colors.orange;
        break;
      case 'aprobado':
        color = Colors.green;
        break;
      case 'rechazado':
        color = Colors.red;
        break;
      default:
        color = Colors.grey;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        status.toUpperCase(),
        style: TextStyle(color: color, fontWeight: FontWeight.bold),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const _Sidebar(),
      appBar: AppBar(
        title: const Text('🎥 Gestión de Contenido'),
        backgroundColor: Colors.indigo,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text(
              'Moderación de Videos, Audios y Relatos',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            TabBar(
              controller: _tabController,
              labelColor: Colors.indigo,
              indicatorColor: Colors.indigo,
              tabs: const [
                Tab(text: '📹 Videos'),
                Tab(text: '🎧 Audios'),
                Tab(text: '📖 Relatos'),
              ],
            ),
            const SizedBox(height: 12),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  SingleChildScrollView(child: buildTable(videoContent)),
                  SingleChildScrollView(child: buildTable(audioContent)),
                  SingleChildScrollView(child: buildTable(storyContent)),
                ],
              ),
            ),
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
          _SidebarItem(title: 'Manage Content', route: '/manage-content', isActive: true),
          _SidebarItem(title: 'Users', route: '/manage-users'),
          _SidebarItem(title: 'Payments', route: '/payments'),
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

