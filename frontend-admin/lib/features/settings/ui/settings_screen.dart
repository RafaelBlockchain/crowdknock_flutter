import 'package:flutter/material.dart';
import 'package:frontend_app/core/utils/locale_helper.dart';
import 'package:frontend_app/features/settings/widgets/language_picker.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  ElevatedButton.icon(
  icon: const Icon(Icons.logout),
  label: Text(L.of(context).logout),
  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
  onPressed: () async {
    const storage = FlutterSecureStorage();
    await storage.delete(key: 'jwt');
    if (!context.mounted) return;
    context.go('/login');
  },
),


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(L.of(context).settings),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ListTile(
            leading: const Icon(Icons.language),
            title: Text(L.of(context).language),
            trailing: const LanguagePicker(),
          ),
          const Divider(),
          // Puedes añadir más opciones de configuración aquí
        ],
      ),
    );
  }
}
