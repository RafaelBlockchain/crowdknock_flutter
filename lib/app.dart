import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

// Screens
import 'features/auth/ui/login_screen.dart';
import 'features/auth/ui/register_screen.dart';
import 'features/dashboard/ui/dashboard_screen.dart';
import 'features/manage_content/ui/manage_content_screen.dart';
import 'features/moderation/ui/moderation_screen.dart';
import 'features/reports/ui/reports_screen.dart';
import 'features/metrics/ui/app_metrics_screen.dart';
import 'features/payments/ui/payments_screen.dart';
import 'features/users/ui/manage_users_screen.dart';
import 'features/profile/ui/profile_screen.dart';

// Core
import 'core/providers/auth_provider.dart';
import 'core/middleware/auth_guard.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final baseApiUrl = dotenv.env['API_BASE_URL'] ?? 'http://localhost:3000';

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: MaterialApp(
        title: 'CrowdKnock Admin',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          scaffoldBackgroundColor: const Color(0xFFF5F5F5),
        ),
        initialRoute: '/login',
        routes: {
          '/login': (_) => const LoginScreen(),
          '/register': (_) => const RegisterScreen(),
          '/dashboard': (_) => const AuthGuard(child: DashboardScreen()),
          '/content': (_) => const AuthGuard(child: ManageContentScreen()),
          '/moderation': (_) => const AuthGuard(child: ModerationScreen()),
          '/reports': (_) => const AuthGuard(child: ReportsScreen()),
          '/metrics': (_) => const AuthGuard(child: AppMetricsScreen()),
          '/payments': (_) => const AuthGuard(child: PaymentsScreen()),
          '/users': (_) => const AuthGuard(child: ManageUsersScreen()),
          '/profile': (_) => const AuthGuard(child: ProfileScreen()),
        },
      ),
    );
  }
}

