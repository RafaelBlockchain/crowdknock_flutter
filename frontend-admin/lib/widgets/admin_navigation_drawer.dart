import 'package:flutter/material.dart';

class AdminNavigationDrawer extends StatelessWidget {
  const AdminNavigationDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final String? currentRoute = ModalRoute.of(context)?.settings.name;

    return Drawer(
      child: ListView(
        padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
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

          _SidebarItem(
            title: 'Dashboard',
            route: '/dashboard',
            isActive: currentRoute == '/dashboard',
          ),
          _SidebarItem(
            title: 'Manage Users',
            route: '/manage-users',
            isActive: currentRoute == '/manage-users',
          ),
          _SidebarItem(
            title: 'Manage Content',
            route: '/manage-content',
            isActive: currentRoute == '/manage-content',
          ),
          _SidebarItem(
            title: 'Moderation',
            route: '/moderation',
            isActive: currentRoute == '/moderation',
          ),
          _SidebarItem(
            title: 'Analytics',
            route: '/analytics',
            isActive: currentRoute == '/analytics',
          ),
          _SidebarItem(
            title: 'Reports',
            route: '/reports',
            isActive: currentRoute == '/reports',
          ),
          _SidebarItem(
            title: 'Payments',
            route: '/payments',
            isActive: currentRoute == '/payments',
          ),
          _SidebarItem(
            title: 'Activity Logs',
            route: '/activity-logs',
            isActive: currentRoute == '/activity-logs',
          ),
          _SidebarItem(
            title: 'System Status',
            route: '/system-status',
            isActive: currentRoute == '/system-status',
          ),
          _SidebarItem(
            title: 'Notifications',
            route: '/notifications',
            isActive: currentRoute == '/notifications',
          ),
          _SidebarItem(
            title: 'Settings',
            route: '/settings',
            isActive: currentRoute == '/settings',
          ),
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
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: ListTile(
        tileColor: isActive ? Colors.indigo : null,
        textColor: isActive ? Colors.white : null,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
        onTap: () {
          if (ModalRoute.of(context)?.settings.name != route) {
            Navigator.pushNamed(context, route);
          } else {
            Navigator.pop(context); // Cierra el drawer si ya estás en esa ruta
          }
        },
      ),
    );
  }
}
