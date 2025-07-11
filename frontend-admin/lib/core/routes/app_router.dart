import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// Pantallas principales
import 'package:frontend_app/features/dashboard/ui/dashboard_screen.dart';
import 'package:frontend_app/features/settings/ui/settings_screen.dart';
import 'package:frontend_app/features/test/ui/test_localization_screen.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
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

