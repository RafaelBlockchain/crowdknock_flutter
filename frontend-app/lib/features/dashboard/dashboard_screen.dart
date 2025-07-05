import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/services/auth_service.dart';
import 'package:provider/provider.dart';
import 'package:frontend_app/core/providers/auth_provider.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  Future<void> _handleLogout(BuildContext context) async {
    await AuthService.logout();
    context.go('/login');
  }

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
      appBar: AppBar(
        title: const Text('Panel de Control'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Cerrar sesión',
            onPressed: () => _handleLogout(context),
          ),
        ],
      ),
      body: const Center(
        child: Text(
          '¡Bienvenido al Panel de Administración!',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}

