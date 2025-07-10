import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../screens/dashboard_screen.dart';
import '../screens/manage_users_screen.dart';
import '../screens/manage_content_screen.dart';
import '../screens/moderation_queue_screen.dart';
import '../screens/user_reports_screen.dart';
import '../screens/payments_screen.dart';
import '../screens/app_metrics_screen.dart';
import '../screens/settings_screen.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/dashboard',
  routes: [
    GoRoute(
      path: '/dashboard',
      name: 'Dashboard',
      builder: (context, state) => const DashboardScreen(),
    ),
    GoRoute(
      path: '/manage-users',
      name: 'ManageUsers',
      builder: (context, state) => const ManageUsersScreen(),
    ),
    GoRoute(
      path: '/manage-content',
      name: 'ManageContent',
      builder: (context, state) => const ManageContentScreen(),
    ),
    GoRoute(
      path: '/moderation',
      name: 'ModerationQueue',
      builder: (context, state) => const ModerationQueueScreen(),
    ),
    GoRoute(
      path: '/reports',
      name: 'UserReports',
      builder: (context, state) => const UserReportsScreen(),
    ),
    GoRoute(
      path: '/payments',
      name: 'Payments',
      builder: (context, state) => const PaymentsPage(),
    ),
    GoRoute(
      path: '/app-metrics',
      name: 'AppMetrics',
      builder: (context, state) => const AppMetricsScreen(),
    ),
    GoRoute(
      path: '/settings',
      name: 'Settings',
      builder: (context, state) => const SettingsScreen(),
    ),
  ],
);
