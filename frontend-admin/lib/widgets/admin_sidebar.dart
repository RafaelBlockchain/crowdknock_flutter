// lib/widgets/sidebar.dart
import 'package:flutter/material.dart';

class Sidebar extends StatelessWidget {
  final String currentRoute;
  final Function(String route) onRouteSelected;

  const Sidebar({
    required this.currentRoute,
    required this.onRouteSelected,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: const EdgeInsets.symmetric(vertical: 32.0),
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'CrowdKnock Admin',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 24),
          SidebarItem(
            title: 'Dashboard',
            icon: Icons.dashboard,
            selected: currentRoute == '/dashboard',
            onTap: () => onRouteSelected('/dashboard'),
          ),
          SidebarItem(
            title: 'Gestión de Contenido',
            icon: Icons.folder,
            selected: currentRoute == '/manage-content',
            onTap: () => onRouteSelected('/manage-content'),
          ),
          SidebarItem(
            title: 'Moderación',
            icon: Icons.report,
            selected: currentRoute == '/moderation',
            onTap: () => onRouteSelected('/moderation'),
          ),
          SidebarItem(
            title: 'Usuarios',
            icon: Icons.people,
            selected: currentRoute == '/manage-users',
            onTap: () => onRouteSelected('/manage-users'),
          ),
          SidebarItem(
            title: 'Métricas',
            icon: Icons.bar_chart,
            selected: currentRoute == '/metrics',
            onTap: () => onRouteSelected('/metrics'),
          ),
          SidebarItem(
            title: 'Sistema',
            icon: Icons.settings,
            selected: currentRoute == '/system-status',
            onTap: () => onRouteSelected('/system-status'),
          ),
        ],
      ),
    );
  }
}

class SidebarItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  const SidebarItem({
    required this.title,
    required this.icon,
    required this.selected,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: selected ? Colors.blue : Colors.grey[600]),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: selected ? FontWeight.bold : FontWeight.normal,
          color: selected ? Colors.blue : Colors.black,
        ),
      ),
      selected: selected,
      onTap: onTap,
    );
  }
}

// lib/widgets/top_app_bar.dart
import 'package:flutter/material.dart';

class TopAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback onLogout;

  const TopAppBar({
    required this.title,
    required this.onLogout,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      actions: [
        IconButton(
          icon: const Icon(Icons.logout),
          onPressed: onLogout,
          tooltip: 'Cerrar sesión',
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

// lib/widgets/page_wrapper.dart
import 'package:flutter/material.dart';

class PageWrapper extends StatelessWidget {
  final Widget child;

  const PageWrapper({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: child,
      ),
    );
  }
}
