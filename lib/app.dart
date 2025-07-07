import 'package:flutter/material.dart';
import 'package:frontend_app/features/auth/ui/login_screen.dart';
import 'package:frontend_app/features/auth/ui/register_screen.dart';
import 'package:frontend_app/features/dashboard/ui/dashboard_screen.dart';
import 'package:frontend_app/features/manage_content/ui/manage_content_screen.dart';
import 'package:frontend_app/features/moderation/ui/moderation_screen.dart';
import 'package:frontend_app/features/reports/ui/reports_screen.dart';
import 'package:frontend_app/features/metrics/ui/app_metrics_screen.dart';
import 'package:frontend_app/features/payments/ui/payments_screen.dart';
import 'package:frontend_app/features/users/ui/manage_users_screen.dart';
import 'package:frontend_app/features/profile/ui/profile_screen.dart';
import 'core/middleware/auth_guard.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CrowdKnock Admin',
      debugShowCheckedModeBanner: false,
      initialRoute: '/login',
      routes: {
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
      },
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.deepPurple,
        scaffoldBackgroundColor: const Color(0xFFF5F5F5),
      ),
    );
  }
}

