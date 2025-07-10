import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Row(
        children: const [
          _SidebarNav(selected: 'Configuración'),
          Expanded(child: _SettingsForm()),
        ],
      ),
    );
  }
}

