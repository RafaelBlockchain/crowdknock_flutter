import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:frontend_app/app.dart';
import 'package:frontend_app/core/providers/auth_provider.dart';

initialRoute: '/login',
routes: appRoutes,

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");

  runApp(
    ChangeNotifierProvider(
      create: (_) => AuthProvider()..loadToken(),
      child: const MyApp(),
    ),
  );
}
ListTile(
  leading: const Icon(Icons.lock_outline),
  title: const Text('Cambiar Contraseña'),
  onTap: () {
    Navigator.pushNamed(context, '/change-password');
  },
),
