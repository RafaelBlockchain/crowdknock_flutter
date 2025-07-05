import 'package:flutter/material.dart';
import 'package:frontend_app/core/services/session_service.dart';
import 'package:frontend_app/core/widgets/primary_button.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = SessionService.currentUser;

    if (user == null) {
      return const Center(child: Text('No hay sesión activa'));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Nombre: ${user.name}', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            Text('Email: ${user.email}', style: Theme.of(context).textTheme.bodyLarge),
            const SizedBox(height: 8),
            Text('Rol: ${user.role}', style: Theme.of(context).textTheme.bodyLarge),
            const SizedBox(height: 16),
            PrimaryButton(
              label: 'Editar Perfil (futuro)',
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Funcionalidad próximamente')),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
