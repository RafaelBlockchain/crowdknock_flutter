import 'package:flutter/material.dart';
import 'package:frontend_admin/core/constants/app_colors.dart';

class AdminLayout extends StatelessWidget {
  final String title;
  final Widget child;

  const AdminLayout({
    super.key,
    required this.title,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: AppColors.primary,
      ),
      drawer: Drawer(
        backgroundColor: Colors.white,
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 24),
          children: [
            const ListTile(
              leading: Icon(Icons.admin_panel_settings),
              title: Text(
                'CrowdKnock Admin',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            const Divider(),

            _DrawerItem(
              icon: Icons.dashboard,
              label: 'Dashboard',
              route: '/dashboard',
            ),
            _DrawerItem(
              icon: Icons.people,
              label: 'Usuarios',
              route: '/users',
            ),
            _DrawerItem(
              icon: Icons.article,
              label: 'Contenido',
              route: '/content',
            ),
            _DrawerItem(
              icon: Icons.rule,
              label: 'Roles',
              route: '/roles',
            ),
            _DrawerItem(
              icon: Icons.feedback,
              label: 'Feedback',
              route: '/feedback',
            ),
            const Divider(),
            _DrawerItem(
              icon: Icons.logout,
              label: 'Cerrar sesión',
              route: '/login',
              logout: true,
            ),
          ],
        ),
      ),
      body: Container(
        color: AppColors.background,
        padding: const EdgeInsets.all(24),
        child: child,
      ),
    );
  }
}

class _DrawerItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String route;
  final bool logout;

  const _DrawerItem({
    required this.icon,
    required this.label,
    required this.route,
    this.logout = false,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(label),
      onTap: () async {
        Navigator.pop(context); // Cierra el Drawer

        if (logout) {
          // TODO: Aquí puedes limpiar sesión desde AuthController o AuthService
          // await AuthService().logout();
          Navigator.pushReplacementNamed(context, route);
        } else {
          Navigator.pushReplacementNamed(context, route);
        }
      },
    );
  }
}

