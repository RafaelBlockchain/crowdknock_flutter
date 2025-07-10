import 'package:flutter/material.dart';

class AdminDashboardScreen extends StatelessWidget {
  const AdminDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Row(
        children: [
          const _Sidebar(),

          // Main content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const _DashboardHeader(),
                  const SizedBox(height: 32),
                  LayoutBuilder(
                    builder: (context, constraints) {
                      final width = constraints.maxWidth;
                      int crossAxisCount = 1;
                      if (width > 1024) {
                        crossAxisCount = 3;
                      } else if (width > 768) {
                        crossAxisCount = 2;
                      }

                      return GridView.count(
                        crossAxisCount: crossAxisCount,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 20,
                        children: const [
                          _DashboardCard(
                            title: '🎥 Videos',
                            description: 'Sube, edita o elimina tus videos.',
                            routeName: '/upload-video',
                            linkText: 'Administrar videos →',
                          ),
                          _DashboardCard(
                            title: '🗳️ Encuestas',
                            description: 'Revisa resultados y crea nuevas votaciones.',
                            routeName: '/create-poll',
                            linkText: 'Administrar encuestas →',
                          ),
                          _DashboardCard(
                            title: '📚 Historias',
                            description: 'Gestiona tus historias y episodios.',
                            routeName: '/story-detail',
                            linkText: 'Ver historias →',
                          ),
                          _DashboardCard(
                            title: '🎧 Audios y Efectos',
                            description: 'Sube audios virales y efectos.',
                            routeName: '/upload-audio',
                            linkText: 'Subir audio →',
                          ),
                          _DashboardCard(
                            title: '📈 Métricas',
                            description: 'Visualiza el alcance de tus publicaciones.',
                            routeName: '/metrics',
                            linkText: 'Ver métricas →',
                          ),
                          _DashboardCard(
                            title: '📋 Auditoría',
                            description: 'Consulta registros de acciones administrativas.',
                            routeName: '/audit-logs',
                            linkText: 'Ver logs →',
                          ),
                        ],
                      );
                    },
                  ),
                  const SizedBox(height: 40),
                  const Center(
                    child: Text(
                      '© 2025 CrowdKnock. Todos los derechos reservados.',
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DashboardHeader extends StatelessWidget {
  const _DashboardHeader();

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '📊 Panel de Control',
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Text(
          'Gestiona contenidos, audita actividad y visualiza estadísticas clave.',
          style: TextStyle(color: Colors.grey),
        ),
      ],
    );
  }
}

class _Sidebar extends StatelessWidget {
  const _Sidebar();

  @override
  Widget build(BuildContext context) {
    final items = [
      ('📊 Dashboard', '/dashboard', true),
      ('🎥 Videos', '/upload-video', false),
      ('🗳️ Encuestas', '/create-poll', false),
      ('🎧 Audios y Efectos', '/upload-audio', false),
      ('📚 Historias', '/story-detail', false),
      ('📈 Métricas', '/metrics', false),
      ('🚨 Reportes', '/reports', false),
      ('💰 Pagos', '/payments', false),
      ('🛠️ Moderación', '/moderation', false),
      ('⚙️ Configuración', '/settings', false),
      ('📋 Auditoría', '/audit-logs', false),
    ];

    return Container(
      width: 240,
      color: Colors.white,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'CrowdKnock Admin',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.indigo),
          ),
          const SizedBox(height: 24),
          for (final item in items)
            _NavLink(label: item.$1, route: item.$2, selected: item.$3),
        ],
      ),
    );
  }
}

class _NavLink extends StatelessWidget {
  final String label;
  final String route;
  final bool selected;

  const _NavLink({
    required this.label,
    required this.route,
    this.selected = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, route),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: selected ? Colors.indigo : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: selected ? Colors.white : Colors.black87,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

class _DashboardCard extends StatelessWidget {
  final String title;
  final String description;
  final String routeName;
  final String linkText;

  const _DashboardCard({
    required this.title,
    required this.description,
    required this.routeName,
    required this.linkText,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      elevation: 2,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: () => Navigator.pushNamed(context, routeName),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
              const SizedBox(height: 8),
              Text(description, style: TextStyle(color: Colors.grey[600])),
              const Spacer(),
              Text(
                linkText,
                style: const TextStyle(
                  color: Color(0xFF4F46E5),
                  fontWeight: FontWeight.w600,
                  decoration: TextDecoration.underline,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

