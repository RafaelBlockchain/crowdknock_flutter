import 'package:flutter/material.dart';
import 'package:frontend_admin/widgets/sidebar.dart';
import 'package:frontend_admin/widgets/top_app_bar.dart';
import 'package:provider/provider.dart';
import 'package:frontend_app/core/providers/auth_provider.dart';

class AdminScaffold extends StatelessWidget {
  final String title;
  final Widget child;

  const AdminScaffold({
    super.key,
    required this.title,
    required this.child,
  });

AppBar(
  title: const Text('Panel de Administración'),
  actions: [
    IconButton(
      icon: const Icon(Icons.logout),
      tooltip: 'Cerrar sesión',
      onPressed: () async {
        final confirm = await showDialog<bool>(
          context: context,
          builder: (_) => AlertDialog(
            title: const Text('¿Cerrar sesión?'),
            content: const Text('Esta acción te desconectará del sistema.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text('Cancelar'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, true),
                child: const Text('Cerrar sesión'),
              ),
            ],
          ),
        );

        if (confirm == true) {
          await Provider.of<AuthProvider>(context, listen: false).logout();
          Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
        }
      },
    ),
  ],
)


  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Sidebar(),
      appBar: TopAppBar(title: title),
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: child,
        ),
      ),
    );
  }
}
