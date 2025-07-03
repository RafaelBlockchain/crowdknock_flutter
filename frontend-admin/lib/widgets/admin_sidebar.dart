import 'package:flutter/material.dart';

class AdminSidebar extends StatelessWidget {
  final String selected;

  const AdminSidebar({super.key, required this.selected});

  @override
  Widget build(BuildContext context) {
    final sidebarItems = <_SidebarItem>[
      _SidebarItem(label: 'Dashboard', route: '/dashboard'),
      _SidebarItem(label: 'Usuarios', route: '/manage-users'),
      _SidebarItem(label: 'Métricas', route: '/analytics'),
      _SidebarItem(label: 'Pagos', route: '/payments'),
      _SidebarItem(label: 'Moderación', route: '/moderation'),
      _SidebarItem(label: 'Estado del Sistema', route: '/system-status'),
      _SidebarItem(label: 'Notificaciones', route: '/notifications'),
      _SidebarItem(label: 'Configuración App', route: '/settings'),
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
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.indigo,
            ),
          ),
          const SizedBox(height: 24),
          ...sidebarItems.map((item) {
            final isSelected = item.label == selected;
            return InkWell(
              onTap: () {
                if (item.route != null && !isSelected) {
                  Navigator.pushNamed(context, item.route!);
                }
              },
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 4),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  color: isSelected ? Colors.indigo : Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  item.label,
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.black87,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            );
          }).toList(),
        ],
      ),
    );
  }
}

class _SidebarItem {
  final String label;
  final String? route;

  const _SidebarItem({required this.label, this.route});
}
