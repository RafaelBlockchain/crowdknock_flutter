import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Ajustes")),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text("Cuenta", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text("Perfil"),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              // TODO: Navegar a pantalla de perfil
            },
          ),
          ListTile(
            leading: const Icon(Icons.lock),
            title: const Text("Cambiar contraseña"),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              // TODO: Navegar a cambio de contraseña
            },
          ),
          const Divider(height: 32),

          const Text("Preferencias", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          SwitchListTile(
            secondary: const Icon(Icons.notifications),
            title: const Text("Notificaciones"),
            value: true,
            onChanged: (val) {
              // TODO: Guardar preferencia
            },
          ),
          ListTile(
            leading: const Icon(Icons.language),
            title: const Text("Idioma"),
            trailing: const Text("Español"),
            onTap: () {
              // TODO: Cambiar idioma
            },
          ),
          const Divider(height: 32),

          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text("Cerrar sesión", style: TextStyle(color: Colors.red)),
            onTap: () {
              // TODO: Confirmar logout
            },
          ),
        ],
      ),
    );
  }
}

