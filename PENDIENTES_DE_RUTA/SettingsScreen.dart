import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final _fullNameController = TextEditingController(text: 'Admin User');
  final _emailController = TextEditingController(text: 'admin@crowdknock.com');
  final _passwordController = TextEditingController();

  String _theme = 'Light';
  bool _emailNotifications = true;

  void _updateAccount() {
    // TODO: Enviar datos al backend usando JWT (nombre, email, password)
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('✅ Account updated')),
    );
  }

  void _savePreferences() {
    // TODO: Guardar preferencias en backend (tema y notificaciones)
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('✅ Preferences saved')),
    );
  }

  void _logout() {
    // TODO: Implementar cierre de sesión y redirección a login
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      drawer: const _Sidebar(),
      appBar: AppBar(
        title: const Text('⚙️ Settings'),
        backgroundColor: Colors.indigo,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Log Out',
            onPressed: _logout,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            const Text(
              '👤 Account Settings',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    TextField(
                      controller: _fullNameController,
                      decoration: const InputDecoration(
                        labelText: 'Full Name',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        labelText: 'Email Address',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _passwordController,
                      decoration: const InputDecoration(
                        labelText: 'New Password',
                        border: OutlineInputBorder(),
                      ),
                      obscureText: true,
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton.icon(
                      onPressed: _updateAccount,
                      icon: const Icon(Icons.save),
                      label: const Text('Update Account'),
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
              '🖥️ System Preferences',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    DropdownButtonFormField<String>(
                      value: _theme,
                      items: const [
                        DropdownMenuItem(value: 'Light', child: Text('🌞 Light')),
                        DropdownMenuItem(value: 'Dark', child: Text('🌚 Dark')),
                        DropdownMenuItem(value: 'System Default', child: Text('🖥 System Default')),
                      ],
                      onChanged: (value) {
                        if (value != null) {
                          setState(() {
                            _theme = value;
                          });
                        }
                      },
                      decoration: const InputDecoration(
                        labelText: 'Theme',
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
                      title: const Text('📩 Enable email notifications'),
                      activeColor: Colors.indigo,
                    ),
                    const SizedBox(height: 8),
                    ElevatedButton.icon(
                      onPressed: _savePreferences,
                      icon: const Icon(Icons.check),
                      label: const Text('Save Preferences'),
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

// Sidebar para navegación
class _Sidebar extends StatelessWidget {
  const _Sidebar();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          Text(
            'CrowdKnock Admin',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.indigo,
            ),
          ),
          SizedBox(height: 20),
          _SidebarItem(title: 'Dashboard', route: '/dashboard'),
          _SidebarItem(title: 'Analytics', route: '/analytics'),
          _SidebarItem(title: 'App Metrics', route: '/app-metrics'),
          _SidebarItem(title: 'User Feedback', route: '/user-feedback'),
          _SidebarItem(title: 'Settings', route: '/settings', isActive: true),
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
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      tileColor: isActive ? Colors.indigo[500] : null,
      textColor: isActive ? Colors.white : null,
      onTap: () {
        if (!isActive) {
          Navigator.pushNamed(context, route);
        } else {
          Navigator.pop(context); // Cierra el drawer si ya estás en la ruta
        }
      },
    );
  }
}
