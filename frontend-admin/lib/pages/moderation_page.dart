import 'package:flutter/material.dart';

class ModerationPage extends StatefulWidget {
  const ModerationPage({super.key});

  @override
  State<ModerationPage> createState() => _ModerationPageState();
}

class _ModerationPageState extends State<ModerationPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // Datos simulados de moderación
  final List<Map<String, dynamic>> reportedVideos = [
    {
      'title': 'Video sospechoso',
      'author': 'CarlosYTube',
      'reports': 5,
      'reason': 'Contenido violento',
      'date': '2025-07-02'
    },
    {
      'title': 'Protesta estudiantil',
      'author': 'LuisaRebel',
      'reports': 2,
      'reason': 'Lenguaje ofensivo',
      'date': '2025-07-01'
    },
  ];

  final List<Map<String, dynamic>> reportedComments = [
    {
      'comment': 'Este tipo merece que lo golpeen',
      'author': 'Anon123',
      'reports': 7,
      'reason': 'Incitación a la violencia',
      'date': '2025-06-30'
    },
  ];

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Widget buildTable(List<Map<String, dynamic>> data, bool isVideo) {
    return DataTable(
      columns: [
        DataColumn(label: Text(isVideo ? 'Título del Video' : 'Comentario')),
        const DataColumn(label: Text('Autor')),
        const DataColumn(label: Text('Motivo')),
        const DataColumn(label: Text('Reportes')),
        const DataColumn(label: Text('Fecha')),
        const DataColumn(label: Text('Acciones')),
      ],
      rows: data
          .map(
            (item) => DataRow(cells: [
              DataCell(Text(isVideo ? item['title'] : item['comment'])),
              DataCell(Text(item['author'])),
              DataCell(Text(item['reason'])),
              DataCell(Text(item['reports'].toString())),
              DataCell(Text(item['date'])),
              DataCell(Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.check_circle, color: Colors.green),
                    tooltip: 'Aprobar',
                    onPressed: () {
                      // Lógica para aprobar contenido
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.visibility_off, color: Colors.orange),
                    tooltip: 'Ocultar',
                    onPressed: () {
                      // Lógica para ocultar contenido
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    tooltip: 'Eliminar',
                    onPressed: () {
                      // Lógica para eliminar contenido
                    },
                  ),
                ],
              )),
            ]),
          )
          .toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const _Sidebar(),
      appBar: AppBar(
        title: const Text('🛡️ Moderación de Contenido Reportado'),
        backgroundColor: Colors.indigo,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text(
              'Cola de Contenido Reportado',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            TabBar(
              controller: _tabController,
              labelColor: Colors.indigo,
              indicatorColor: Colors.indigo,
              tabs: const [
                Tab(text: '🎥 Videos Reportados'),
                Tab(text: '💬 Comentarios Reportados'),
              ],
            ),
            const SizedBox(height: 12),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  SingleChildScrollView(
                    child: buildTable(reportedVideos, true),
                  ),
                  SingleChildScrollView(
                    child: buildTable(reportedComments, false),
                  ),
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
          _SidebarItem(title: 'Manage Content', route: '/manage-content'),
          _SidebarItem(title: 'Moderación', route: '/moderation', isActive: true),
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
import 'package:flutter/material.dart';
import '../layout/admin_scaffold.dart';

class ModerationPage extends StatelessWidget {
  const ModerationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
      title: '🛡️ Moderation',
      currentRoute: '/moderation',
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Moderation Center',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12),
            Text(
              'Review and take action on reported content or users.',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}

