import 'package:flutter/material.dart';

class AccessDeniedPage extends StatelessWidget {
  const AccessDeniedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Acceso Denegado'),
        automaticallyImplyLeading: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.lock_outline, size: 80, color: Colors.redAccent),
              const SizedBox(height: 24),
              const Text(
                'No tienes permisos para acceder a esta sección.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                icon: const Icon(Icons.arrow_back),
                label: const Text('Volver al inicio'),
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(context, '/home', (_) => false);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
