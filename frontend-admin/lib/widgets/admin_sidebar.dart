import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AdminSidebar extends StatelessWidget {
  final String currentRoute;

  const AdminSidebar({super.key, required this.currentRoute});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.indigo),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'CrowdKnock Admin',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              children: const [
                _SidebarItem(label: '📊 Dashboard', route: '/dashboard'),
                _SidebarItem(label: '🎞️ Manage Content', route: '/manage-content'),
                _SidebarItem(label: '🛡️ Moderation', route: '/moderation'),
                _SidebarItem(label: '👥 Manage Users', route: '/manage-users'),
                _SidebarItem(label: '💳 Payments', route: '/payments'),
                _SidebarItem(label: '📈 App Metrics', route: '/app-metrics'),
                _SidebarItem(label: '⚙️ System Status', route: '/system-status'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SidebarItem extends StatelessWidget {
  final String label;
  final String route;

  const _SidebarItem({
    required this.label,
    required this.route,
  });

  @override
  Widget build(BuildContext context) {
    final String currentRoute = GoRouter.of(context).location;
    final bool isActive = currentRoute == route;

    return ListTile(
      title: Text(label),
      tileColor: isActive ? Colors.indigo[400] : null,
      textColor: isActive ? Colors.white : null,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      onTap: () {
        if (!isActive) context.go(route);
        Navigator.pop(context); // Cierra el Drawer si está en pantalla pequeña
      },
    );
  }
}
