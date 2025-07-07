import 'package:flutter/material.dart';

// Pantallas principales del admin panel
import 'package:frontend_app/features/dashboard/ui/dashboard_screen.dart';
import 'package:frontend_app/features/manage_content/ui/manage_content_screen.dart';
import 'package:frontend_app/features/moderation/ui/moderation_screen.dart';
import 'package:frontend_app/features/payments/ui/payments_screen.dart';
import 'package:frontend_app/features/reports/ui/reports_screen.dart';
import 'package:frontend_app/features/system_status/ui/system_status_screen.dart';
import 'package:frontend_app/features/app_metrics/ui/app_metrics_screen.dart';
import 'package:frontend_app/features/users/ui/manage_users_screen.dart';
import 'package:frontend_app/features/profile/ui/change_password_screen.dart';


final Map<String, WidgetBuilder> appRoutes = {
  '/dashboard': (context) => const DashboardScreen(),
  '/manage-content': (context) => const ManageContentScreen(),
  '/moderation': (context) => const ModerationScreen(),
  '/payments': (context) => const PaymentsScreen(),
  '/reports': (context) => const ReportsScreen(),
  '/system-status': (context) => const SystemStatusScreen(),
  '/app-metrics': (context) => const AppMetricsScreen(),
  '/manage-users': (context) => const ManageUsersScreen(),
   '/login': (context) => const LoginScreen(),
  '/register': (context) => const RegisterScreen(),
  '/dashboard': (_) => const AuthGuard(child: DashboardScreen()),
  '/content': (_) => const AuthGuard(child: ManageContentScreen()),
  '/moderation': (_) => const AuthGuard(child: ModerationScreen()),
  '/reports': (_) => const AuthGuard(child: ReportsScreen()),
  '/metrics': (_) => const AuthGuard(child: AppMetricsScreen()),
  '/payments': (_) => const AuthGuard(child: PaymentsScreen()),
  '/users': (_) => const AuthGuard(child: ManageUsersScreen()),
  '/profile': (_) => const AuthGuard(child: ProfileScreen()),

  // ✅ Nueva ruta
  '/change-password': (_) => const AuthGuard(child: ChangePasswordScreen()),
};
