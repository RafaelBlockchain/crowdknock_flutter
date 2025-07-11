import 'package:flutter/material.dart';
import 'package:frontend_app/core/utils/locale_helper.dart';
import 'package:frontend_app/features/settings/widgets/language_picker.dart';
import 'package:frontend_app/core/providers/locale_provider.dart';
import 'package:provider/provider.dart';

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
    final provider = Provider.of<LocaleProvider>(context);
    final currentLocale = provider.locale;
    final flag = LocaleProvider.L10n.getFlag(currentLocale.languageCode);

    return Scaffold(
      appBar: AppBar(
        title: Text(L.of(context).settings),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            L.of(context).language,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 12),

          // Sección visual de idioma actual
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceVariant,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Text(
                  flag,
                  style: const TextStyle(fontSize: 20),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    currentLocale.languageCode == 'es' ? 'Español' : 'English',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
                const LanguagePicker(),
              ],
            ),
          ),

          const SizedBox(height: 24),
          const Divider(),

          // Aquí podrías agregar más secciones de ajustes…
        ],
      ),
    );
  }
}

