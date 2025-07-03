import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final _fullNameController = TextEditingController(text: 'Admin User');
  final _emailController = TextEditingController(text: 'admin@crowdknock.com');
  final _passwordController = TextEditingController();

  String _theme = 'Light';
  bool _emailNotifications = true;

  void _updateAccount() {
    // TODO: Conectar con backend usando JWT para actualizar nombre, email, password
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('✅ Cuenta actualizada')),
    );
  }

  void _savePreferences() {
    // TODO: Enviar preferencias (tema, notificaciones) al backend
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('✅ Preferencias guardadas')),
    );
  }

  void _logout() {
    // TODO: Limpiar token JWT y redirigir al login
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const _AdminSidebar(activeRoute: '/settings'),
      appBar: AppBar(
        title: const Text('⚙️ Configuración'),
        backgroundColor: Colors.indigo,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Cerrar sesión',
            onPressed: _logout,
          ),
        ],
      ),
      backgroundColor: Colors.grey[100],
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: ListView(
          children: [
            const Text(
              '👤 Configuración de la Cuenta',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    TextField(
                      controller: _fullNameController,
                      decoration: const InputDecoration(
                        labelText: 'Nombre completo',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        labelText: 'Correo electrónico',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _passwordController,
                      decoration: const InputDecoration(
                        labelText: 'Nueva contraseña',
                        border: OutlineInputBorder(),
                      ),
                      obscureText: true,
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton.icon(
                      onPressed: _updateAccount,
                      icon: const Icon(Icons.save),
                      label: const Text('Actualizar Cuenta'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.indigo,
                        minimumSize: const Size.fromHeight(48),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),
            const Text(
              '🖥️ Preferencias del Sistema',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    DropdownButtonFormField<String>(
                      value: _theme,
                      items: const [
                        DropdownMenuItem(value: 'Light', child: Text('🌞 Claro')),
                        DropdownMenuItem(value: 'Dark', child: Text('🌚 Oscuro')),
                        DropdownMenuItem(value: 'System Default', child: Text('🖥 Sistema')),
                      ],
                      onChanged: (value) {
                        if (value != null) {
                          setState(() {
                            _theme = value;
                          });
                        }
                      },
                      decoration: const InputDecoration(
                        labelText: 'Tema de la interfaz',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 16),
                    SwitchListTile(
                      value: _emailNotifications,
                      onChanged: (value) {
                        setState(() {
                          _emailNotifications = value;
                        });
                      },
                      title: const Text('📩 Notificaciones por correo'),
                      activeColor: Colors.indigo,
                    ),
                    const SizedBox(height: 8),
                    ElevatedButton.icon(
                      onPressed: _savePreferences,
                      icon: const Icon(Icons.check),
                      label: const Text('Guardar Preferencias'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.indigo,
                        minimumSize: const Size.fromHeight(48),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Sidebar modular reutilizable
class _AdminSidebar extends StatelessWidget {
  final String activeRoute;

  const _AdminSidebar({required this.activeRoute, super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
        children: [
          const Text(
            'CrowdKnock Admin',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.indigo,
            ),
          ),
          const SizedBox(height: 32),
          _SidebarItem(title: 'Dashboard', route: '/dashboard', isActive: activeRoute == '/dashboard'),
          _SidebarItem(title: 'Manage Users', route: '/users', isActive: activeRoute == '/users'),
          _SidebarItem(title: 'Manage Content', route: '/content', isActive: activeRoute == '/content'),
          _SidebarItem(title: 'Moderation', route: '/moderation', isActive: activeRoute == '/moderation'),
          _SidebarItem(title: 'Analytics', route: '/analytics', isActive: activeRoute == '/analytics'),
          _SidebarItem(title: 'Reports', route: '/reports', isActive: activeRoute == '/reports'),
          _SidebarItem(title: 'Payments', route: '/payments', isActive: activeRoute == '/payments'),
          _SidebarItem(title: 'Feedback', route: '/feedback', isActive: activeRoute == '/feedback'),
          _SidebarItem(title: 'Settings', route: '/settings', isActive: activeRoute == '/settings'),
        ],
      ),
    );
  }
}

class _SidebarItem extends StatelessWidget {
  final String title;
  final String route;
  final bool isActive;

  const _SidebarItem({
    required this.title,
    required this.route,
    required this.isActive,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      tileColor: isActive ? Colors.indigo[100] : null,
      textColor: isActive ? Colors.indigo : null,
      onTap: () {
        if (!isActive) {
          Navigator.pushReplacementNamed(context, route);
        } else {
          Navigator.pop(context);
        }
      },
    );
  }
}

