import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// Importar páginas
import '../../features/auth/login_page.dart';
import '../../features/dashboard/dashboard_page.dart';
import '../../features/manage_content/pages/content_list.dart';
import '../../features/access/access_denied_page.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();

final GoRouter appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/login',
  routes: [
    GoRoute(
      path: '/login',
      name: 'login',
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: '/dashboard',
      name: 'dashboard',
      builder: (context, state) => const DashboardPage(),
    ),
    GoRoute(
      path: '/manage-content',
      name: 'manage_content',
      builder: (context, state) => const ContentListPage(),
    ),
    GoRoute(
      path: '/access-denied',
      name: 'access_denied',
      builder: (context, state) => const AccessDeniedPage(),
    ),
  ],

  // Puedes agregar esta lógica de redirección para proteger rutas
  redirect: (context, state) {
    final loggedIn = false; // TODO: reemplazar con lógica real
    final goingToLogin = state.subloc == '/login';

    if (!loggedIn && !goingToLogin) {
      return '/login';
    }

    if (loggedIn && goingToLogin) {
      return '/dashboard';
    }

    return null;
  },

  errorBuilder: (context, state) => Scaffold(
    body: Center(
      child: Text('Página no encontrada: ${state.error}'),
    ),
  ),
);

