import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:frontend_app/features/auth/ui/login_screen.dart';
import 'package:frontend_app/features/auth/ui/register_screen.dart';
import 'package:frontend_app/features/dashboard/ui/dashboard_screen.dart';
import 'package:frontend_app/features/manage_content/ui/manage_content_screen.dart';
import 'package:frontend_app/features/moderation/ui/moderation_screen.dart';
import 'package:frontend_app/features/reports/ui/reports_screen.dart';
import 'package:frontend_app/features/metrics/ui/app_metrics_screen.dart';
import 'package:frontend_app/features/payments/ui/payments_screen.dart';
import 'package:frontend_app/features/users/ui/manage_users_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  import 'package:frontend_app/core/middleware/auth_guard.dart';

// Dentro de routes:
'/dashboard': (_) => const AuthGuard(child: DashboardScreen()),
'/content': (_) => const AuthGuard(child: ManageContentScreen()),
'/moderation': (_) => const AuthGuard(child: ModerationScreen()),
'/reports': (_) => const AuthGuard(child: ReportsScreen()),
'/metrics': (_) => const AuthGuard(child: AppMetricsScreen()),
'/payments': (_) => const AuthGuard(child: PaymentsScreen()),
'/users': (_) => const AuthGuard(child: ManageUsersScreen()),


  
  @override
  Widget build(BuildContext context) {
    final baseApiUrl = dotenv.env['API_BASE_URL'] ?? 'http://localhost:3000';

    return MaterialApp(
      title: 'CrowdKnock Admin',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.grey[100],
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/dashboard': (context) => const DashboardScreen(),
        '/content': (context) => const ManageContentScreen(),
        '/moderation': (context) => const ModerationScreen(),
        '/reports': (context) => const ReportsScreen(),
        '/metrics': (context) => const AppMetricsScreen(),
        '/payments': (context) => const PaymentsScreen(),
        '/users': (context) => const ManageUsersScreen(),
      },
    );
  }
}
