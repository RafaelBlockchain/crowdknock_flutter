import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens/dashboard_screen.dart';
import 'screens/manage_users_screen.dart';
import 'screens/manage_content_screen.dart';
import 'screens/moderation_queue_screen.dart';
import 'screens/user_reports_screen.dart';
import 'screens/payments_screen.dart';
import 'screens/app_metrics_screen.dart';
import 'screens/settings_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(); // Carga variables desde .env
  runApp(const AdminPanelApp());
}

class AdminPanelApp extends StatelessWidget {
  const AdminPanelApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'CrowdKnock Admin',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        textTheme: GoogleFonts.interTextTheme(),
      ),
      routerConfig: _router,
    );
  }
}

final _router = GoRouter(
  initialLocation: '/dashboard',
  routes: [
    GoRoute(
      path: '/dashboard',
      builder: (context, state) => const DashboardScreen(),
    ),
    GoRoute(
      path: '/manage-users',
      builder: (context, state) => const ManageUsersScreen(),
    ),
    GoRoute(
      path: '/manage-content',
      builder: (context, state) => const ManageContentScreen(),
    ),
    GoRoute(
      path: '/moderation',
      builder: (context, state) => const ModerationQueueScreen(),
    ),
    GoRoute(
      path: '/reports',
      builder: (context, state) => const UserReportsScreen(),
    ),
    GoRoute(
      path: '/payments',
      builder: (context, state) => const PaymentsPage(),
    ),
    GoRoute(
      path: '/app-metrics',
      builder: (context, state) => const AppMetricsScreen(),
    ),
    GoRoute(
      path: '/settings',
      builder: (context, state) => const SettingsScreen(),
    ),
  ],
);
