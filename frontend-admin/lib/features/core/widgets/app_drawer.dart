import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:frontend_app/core/utils/locale_helper.dart';
import 'package:frontend_app/features/settings/widgets/language_picker.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            child: Center(
              child: Text(
                L.of(context).appTitle,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.dashboard),
            title: Text(L.of(context).dashboard),
            onTap: () => context.go('/'),
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: Text(L.of(context).settings),
            onTap: () => context.go('/settings'),
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: Text(L.of(context).settings),
            onTap: () => context.go('/settings'),
          ),
          ListTile(
            leading: const Icon(Icons.translate),
            title: const Text('Test Idiomas'),
            onTap: () => context.go('/test-localization'),
          ),
          const Spacer(),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: LanguagePicker(), // 👈 Cambio de idioma en Drawer
          ),
        ],
      ),
    );
  }
}
