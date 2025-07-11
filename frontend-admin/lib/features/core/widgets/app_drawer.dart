import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:frontend_app/core/utils/locale_helper.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: const EdgeInsets.symmetric(vertical: 24),
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
            ),
            child: Center(
              child: Text(
                L.of(context).appTitle,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
          ),

          // 🏠 Dashboard
          ListTile(
            leading: const Icon(Icons.dashboard),
            title: Text(L.of(context).dashboard),
            onTap: () => context.go('/'),
          ),

          // ⚙️ Configuración
          ListTile(
            leading: const Icon(Icons.settings),
            title: Text(L.of(context).settings),
            onTap: () => context.go('/settings'),
          ),

          // 🌐 Test Localización
          ListTile(
            leading: const Icon(Icons.translate),
            title: const Text('Test Idiomas'),
            onTap: () => context.go('/test-localization'),
          ),
        ],
      ),
    );
  }
}
