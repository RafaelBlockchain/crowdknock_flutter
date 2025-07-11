import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

// Pantallas principales
import 'package:frontend_app/features/dashboard/ui/dashboard_screen.dart';
import 'package:frontend_app/features/settings/ui/settings_screen.dart';
import 'package:frontend_app/features/test/ui/test_localization_screen.dart';

// Pantalla pública de login (ejemplo)
import 'package:frontend_app/features/auth/ui/login_screen.dart';

// Utilidad para token seguro
const _secureStorage = FlutterSecureStorage();

Future<bool> isAuthenticated() async {
  final token = await _secureStorage.read(key: 'jwt');
  return token != null && !JwtDecoder.isExpired(token);
}

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  redirect: (context, state) async {
    final loggedIn = await isAuthenticated();

    final isLoggingIn = state.subloc == '/login';

    if (!loggedIn && !isLoggingIn) return '/login';
    if (loggedIn && isLoggingIn) return '/'; // Redirigir si ya está logueado

    return null; // Permitir acceso
  },
  routes: [
    // Ruta pública
    GoRoute(
      path: '/login',
      name: 'login',
      builder: (context, state) => const LoginScreen(),
    ),

    // Rutas protegidas
    GoRoute(
      path: '/',
      name: 'dashboard',
      builder: (context, state) => const DashboardScreen(),
    ),
    GoRoute(
      path: '/settings',
      name: 'settings',
      builder: (context, state) => const SettingsScreen(),
    ),
    GoRoute(
      path: '/test-localization',
      name: 'test-localization',
      builder: (context, state) => const TestLocalizationScreen(),
    ),
  ],
);

