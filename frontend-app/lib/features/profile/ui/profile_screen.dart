import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:frontend_app/core/providers/auth_provider.dart';
import 'package:frontend_app/core/services/version_service.dart';
import 'package:frontend_app/core/widgets/primary_button.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late Future<VersionInfo> _versionFuture;

  @override
  void initState() {
    super.initState();
    _versionFuture = VersionService.loadVersionInfo();
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(width: 8),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final user = authProvider.currentUser;

    if (user == null) {
      return const Scaffold(
        body: Center(child: Text('No hay usuario autenticado')),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Mi Perfil')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🧑 Info del usuario
            Card(
              elevation: 3,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('👤 Información del Usuario', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 24),
                    _buildInfoRow('Nombre:', user.name),
                    _buildInfoRow('Email:', user.email),
                    _buildInfoRow('Rol:', user.role),
                    if (user.createdAt != null)
                      _buildInfoRow('Desde:', user.createdAt!.toLocal().toString()),
                    const SizedBox(height: 16),
                    PrimaryButton(
                      label: 'Cambiar contraseña',
                      icon: Icons.lock_reset,
                      onPressed: () {
                        Navigator.pushNamed(context, '/change-password');
                      },
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 32),

            // 🧾 Info de la app
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: FutureBuilder<VersionInfo>(
                  future: _versionFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (snapshot.hasError) {
                      return Text('Error al cargar versión: ${snapshot.error}');
                    }

                    final version = snapshot.data!;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('🧾 Información de la Aplicación', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 16),
                        _buildInfoRow('Versión:', version.version),
                        _buildInfoRow('Build:', version.build),
                        _buildInfoRow('Entorno:', version.environment),
                        _buildInfoRow('Flutter:', version.flutterVersion),
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
