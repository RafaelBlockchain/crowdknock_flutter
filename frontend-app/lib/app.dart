import 'package:flutter/material.dart';

// Screens
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
import 'package:frontend_app/features/profile/ui/change_password_screen.dart';

'/edit-profile': (context) => const AuthGuard(child: EditProfileScreen()),
'/forgot-password': (context) => const ForgotPasswordScreen(),


// Middleware
import 'package:frontend_app/core/middleware/auth_guard.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CrowdKnock Admin',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.deepPurple,
        scaffoldBackgroundColor: const Color(0xFFF5F5F5),
      ),
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/dashboard': (context) => const AuthGuard(child: DashboardScreen()),
        '/content': (context) => const AuthGuard(child: ManageContentScreen()),
        '/moderation': (context) => const AuthGuard(child: ModerationScreen()),
        '/reports': (context) => const AuthGuard(child: ReportsScreen()),
        '/metrics': (context) => const AuthGuard(child: AppMetricsScreen()),
        '/payments': (context) => const AuthGuard(child: PaymentsScreen()),
        '/users': (context) => const AuthGuard(child: ManageUsersScreen()),
        '/profile': (context) => const AuthGuard(child: ProfileScreen()),
        '/change-password': (context) => const AuthGuard(child: ChangePasswordScreen()),
      },
    );
  }
}
