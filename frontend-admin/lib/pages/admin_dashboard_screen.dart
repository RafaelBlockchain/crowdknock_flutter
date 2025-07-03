import 'package:flutter/material.dart';

class AdminDashboardScreen extends StatelessWidget {
  const AdminDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Row(
        children: [
          // Sidebar
          Container(
            width: 240,
            color: Colors.white,
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'CrowdKnock Admin',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.indigo,
                  ),
                ),
                const SizedBox(height: 24),
                _NavLink(label: '📊 Dashboard', route: '/dashboard', selected: true),
                _NavLink(label: '🎥 Videos', route: '/upload-video'),
                _NavLink(label: '🗳️ Encuestas', route: '/create-poll'),
                _NavLink(label: '🎧 Audios y Efectos', route: '/upload-audio'),
                _NavLink(label: '📚 Historias', route: '/story-detail'),
                _NavLink(label: '📈 Métricas', route: '/metrics'),
                _NavLink(label: '🚨 Reportes', route: '/reports'),
                _NavLink(label: '💰 Pagos', route: '/payments'),
                _NavLink(label: '🛠️ Moderación', route: '/moderation'),
                _NavLink(label: '⚙️ Configuración', route: '/settings'),
                _NavLink(label: '📋 Auditoría', route: '/audit-logs'),
              ],
            ),
          ),

          // Main content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '📊 Panel de Control',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Gestiona contenidos, audita actividad y visualiza estadísticas clave.',
                    style: TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 32),

                  LayoutBuilder(
                    builder: (context, constraints) {
                      int crossAxisCount = 1;
                      if (screenWidth > 1024) {
                        crossAxisCount = 3;
                      } else if (screenWidth > 768) {
                        crossAxisCount = 2;
                      }

                      return GridView.count(
                        crossAxisCount: crossAxisCount,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 20,
                        children: [
                          _buildCard(
                            context,
                            title: '🎥 Videos',
                            description: 'Sube, edita o elimina tus videos.',
                            routeName: '/upload-video',
                            linkText: 'Administrar videos →',
                          ),
                          _buildCard(
                            context,
                            title: '🗳️ Encuestas',
                            description: 'Revisa resultados y crea nuevas votaciones.',
                            routeName: '/create-poll',
                            linkText: 'Administrar encuestas →',
                          ),
                          _buildCard(
                            context,
                            title: '📚 Historias',
                            description: 'Gestiona tus historias y episodios.',
                            routeName: '/story-detail',
                            linkText: 'Ver historias →',
                          ),
                          _buildCard(
                            context,
                            title: '🎧 Audios y Efectos',
                            description: 'Sube audios virales y efectos.',
                            routeName: '/upload-audio',
                            linkText: 'Subir audio →',
                          ),
                          _buildCard(
                            context,
                            title: '📈 Métricas',
                            description: 'Visualiza el alcance de tus publicaciones.',
                            routeName: '/metrics',
                            linkText: 'Ver métricas →',
                          ),
                          _buildCard(
                            context,
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

  Widget _buildCard(
    BuildContext context, {
    required String title,
    required String description,
    required String routeName,
    required String linkText,
  }) {
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
              Text(title,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w600)),
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
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _NavLink extends StatelessWidget {
  final String label;
  final String? route;
  final bool selected;

  const _NavLink({
    required this.label,
    this.route,
    this.selected = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: route != null ? () => Navigator.pushNamed(context, route!) : null,
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

