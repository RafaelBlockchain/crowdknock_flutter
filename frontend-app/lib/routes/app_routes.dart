import 'package:flutter/material.dart';
import 'package:frontend_app/features/dashboard/ui/dashboard_screen.dart';
import 'package:frontend_app/features/manage_content/ui/manage_content_screen.dart';
import 'package:frontend_app/features/moderation/ui/moderation_screen.dart';
import 'package:frontend_app/features/payments/ui/payments_screen.dart';
import 'package:frontend_app/features/reports/ui/reports_screen.dart';
import 'package:frontend_app/features/system_status/ui/system_status_screen.dart';
import 'package:frontend_app/features/app_metrics/ui/app_metrics_screen.dart';
import 'package:frontend_app/features/users/ui/manage_users_screen.dart';

final Map<String, WidgetBuilder> appRoutes = {
  '/dashboard': (context) => const DashboardScreen(),
  '/manage-content': (context) => const ManageContentScreen(),
  '/moderation': (context) => const ModerationScreen(),
  '/payments': (context) => const PaymentsScreen(),
  '/reports': (context) => const ReportsScreen(),
  '/system-status': (context) => const SystemStatusScreen(),
  '/app-metrics': (context) => const AppMetricsScreen(),
  '/manage-users': (context) => const ManageUsersScreen(),
};
