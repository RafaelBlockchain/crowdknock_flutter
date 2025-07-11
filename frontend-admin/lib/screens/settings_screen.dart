import 'package:flutter/material.dart';
import '../layout/admin_scaffold.dart';
import 'package:provider/provider.dart';
import 'package:frontend_app/core/providers/locale_provider.dart';

class SettingsScreen extends StatefulWidget {
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

    return DropdownButton<Locale>(
      value: currentLocale,
      icon: const Icon(Icons.language),
      onChanged: (Locale? newLocale) {
        if (newLocale != null) {
          provider.setLocale(newLocale);
        }
      },
      items: L10n.all.map((locale) {
        final flag = L10n.getFlag(locale.languageCode);
        return DropdownMenuItem(
          value: locale,
          child: Text(flag),
        );
      }).toList(),
    );
  }
}

  
  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool darkMode = false;
  String environment = 'production';
  final TextEditingController apiKeyController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Carga inicial desde almacenamiento local o backend si es necesario
    apiKeyController.text = 'API_KEY_OCULTA';
  }

  void _saveSettings() {
    // TODO: Guardar configuración en backend o almacenamiento local
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('✅ Configuración guardada'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
      title: '⚙️ Configuración',
      currentRoute: '/settings',
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: ListView(
          children: [
            const Text(
              'Preferencias Generales',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),

            /// Modo Oscuro
            SwitchListTile(
              title: const Text('Modo Oscuro'),
              value: darkMode,
              onChanged: (value) {
                setState(() => darkMode = value);
              },
            ),

            /// Entorno actual
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: environment,
              decoration: const InputDecoration(labelText: 'Entorno'),
              items: const [
                DropdownMenuItem(value: 'development', child: Text('Development')),
                DropdownMenuItem(value: 'staging', child: Text('Staging')),
                DropdownMenuItem(value: 'production', child: Text('Production')),
              ],
              onChanged: (value) {
                if (value != null) setState(() => environment = value);
              },
            ),

            /// API Key
            const SizedBox(height: 24),
            TextFormField(
              controller: apiKeyController,
              decoration: const InputDecoration(
                labelText: 'Clave API',
                border: OutlineInputBorder(),
              ),
            ),

            /// Guardar
            const SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: _saveSettings,
              icon: const Icon(Icons.save),
              label: const Text('Guardar Cambios'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

