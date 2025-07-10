import 'package:flutter/material.dart';
import 'package:frontend_app/core/widgets/admin_app_bar.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Row(
        children: [
          // 📚 Sidebar
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
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.indigo,
                  ),
                ),
                const SizedBox(height: 24),
                _NavLink(label: '📊 Mi Panel', selected: true),
                _NavLink(label: '📹 Subir Video', route: '/upload-video'),
                _NavLink(label: '🗳️ Encuestas', route: '/create-poll'),
                _NavLink(label: '🎧 Audios', route: '/upload-audio'),
                _NavLink(label: '📚 Historias', route: '/story-detail'),
                _NavLink(label: '📈 Estadísticas', route: '/metrics'),
              ],
            ),
          ),

          // 🧱 Main Content
          Expanded(
            child: Column(
              children: [
                const AdminAppBar(title: '📊 Mi Panel'),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(32),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Este es tu panel donde puedes gestionar tus contenidos y ver estadísticas.',
                          style: TextStyle(color: Colors.grey),
                        ),
                        const SizedBox(height: 32),

                        // 🧩 Cards grid
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
                                  title: '📹 Mis Videos',
                                  description: 'Sube, edita o elimina tus videos.',
                                  routeName: '/upload-video',
                                  linkText: 'Administrar videos →',
                                ),
                                _buildCard(
                                  context,
                                  title: '🗳️ Mis Encuestas',
                                  description: 'Revisa resultados y crea nuevas votaciones.',
                                  routeName: '/create-poll',
                                  linkText: 'Administrar encuestas →',
                                ),
                                _buildCard(
                                  context,
                                  title: '📚 Mis Historias',
                                  description: 'Gestiona tus historias y episodios publicados.',
                                  routeName: '/story-detail',
                                  linkText: 'Ver historias →',
                                ),
                                _buildCard(
                                  context,
                                  title: '🎧 Mis Audios',
                                  description: 'Sube audios virales y efectos.',
                                  routeName: '/upload-audio',
                                  linkText: 'Subir audio →',
                                ),
                                _buildCard(
                                  context,
                                  title: '📈 Estadísticas',
                                  description: 'Visualiza el alcance de tus publicaciones.',
                                  routeName: '/metrics',
                                  linkText: 'Ver métricas →',
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
