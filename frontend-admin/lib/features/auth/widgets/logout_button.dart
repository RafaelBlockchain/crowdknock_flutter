import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:frontend_app/core/utils/locale_helper.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({super.key});

  Future<void> _logout(BuildContext context) async {
    const storage = FlutterSecureStorage();
    await storage.delete(key: 'jwt'); // 🧹 Borra el token
    if (!context.mounted) return;
    context.go('/login'); // Redirige a login
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.logout),
      title: Text(L.of(context).logout),
      onTap: () => _logout(context),
    );
  }
}
