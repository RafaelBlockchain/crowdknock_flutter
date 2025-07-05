import 'package:flutter/material.dart';
import 'package:frontend_app/core/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class AdminScaffold extends StatelessWidget {
  final String title;
  final Widget body;

  const AdminScaffold({
    super.key,
    required this.title,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    final user = auth.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: [
          if (user != null)
            PopupMenuButton<String>(
              onSelected: (value) async {
                if (value == 'logout') {
                  await auth.logout();
                  if (context.mounted) {
                    Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => false);
                  }
                } else if (value == 'profile') {
                  // Opcional: navegar a pantalla de perfil
                }
              },
              itemBuilder: (context) => [
                PopupMenuItem<String>(
                  value: 'profile',
                  child: Text('👤 ${user.name} (${user.role})'),
                ),
                const PopupMenuDivider(),
                const PopupMenuItem<String>(
                  value: 'logout',
                  child: Text('Cerrar sesión 🔓'),
                ),
              ],
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    const Icon(Icons.account_circle),
                    const SizedBox(width: 8),
                    Text(user.name, style: const TextStyle(fontSize: 14)),
                    const Icon(Icons.arrow_drop_down),
                  ],
                ),
              ),
            )
        ],
      ),
      body: body,
    );
  }
}
