import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:frontend_app/core/providers/auth_provider.dart';
import 'package:frontend_app/core/services/version_service.dart';

class ProfileScreen extends StatelessWidget {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mi perfil')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('👤 Información del usuario'),
            const SizedBox(height: 16),

            // ... otros datos del usuario

            const Divider(height: 32),
            const Text('🧾 Información de la aplicación', style: TextStyle(fontWeight: FontWeight.bold)),

            FutureBuilder<VersionInfo>(
              future: _versionFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }

                if (snapshot.hasError) {
                  return Text('Error cargando versión: ${snapshot.error}');
                }

                final version = snapshot.data!;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Versión: ${version.version}'),
                    Text('Build: ${version.build}'),
                    Text('Entorno: ${version.environment}'),
                    Text('Flutter: ${version.flutterVersion}'),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
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

    ListTile(
  leading: const Icon(Icons.lock_outline),
  title: const Text('Cambiar Contraseña'),
  onTap: () {
    Navigator.pushNamed(context, '/change-password');
  },
),


    return Scaffold(
      appBar: AppBar(
        title: const Text('Mi Perfil'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Información del Usuario',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 24),
                _buildInfoRow('👤 Nombre:', user.name),
                _buildInfoRow('📧 Email:', user.email),
                _buildInfoRow('🧩 Rol:', user.role),
                if (user.createdAt != null)
                  _buildInfoRow('📅 Desde:', user.createdAt!.toLocal().toString()),
              ],
            ),
          ),
        ),
      ),
    );
  }

PrimaryButton(
  label: 'Cambiar contraseña',
  icon: Icons.lock_reset,
  onPressed: () {
    Navigator.pushNamed(context, '/change-password');
  },
),
  
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
}
