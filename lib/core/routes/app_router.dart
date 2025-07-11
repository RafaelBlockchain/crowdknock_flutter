import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:frontend_app/features/dashboard/ui/dashboard_screen.dart';
import 'package:frontend_app/features/settings/ui/settings_screen.dart';
import 'package:frontend_app/features/settings/ui/localization_test_screen.dart';

final GoRouter appRouter = GoRouter(
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
      name: 'test_localization',
      builder: (context, state) => const LocalizationTestScreen(),
    ),
  ],
);
