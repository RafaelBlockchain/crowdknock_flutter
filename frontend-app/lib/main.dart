import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// Páginas del panel
import 'pages/dashboard_page.dart';
import 'pages/manage_content_page.dart';
import 'pages/moderation_page.dart';
import 'pages/payments_page.dart';
import 'pages/system_status_page.dart';
import 'pages/app_metrics_page.dart';
import 'pages/manage_users_page.dart';

MaterialApp(
  onGenerateRoute: generateRoute,
  initialRoute: '/',
)

void main() async{
   WidgetsFlutterBinding.ensureInitialized();
  runApp(const CrowdKnockAdminApp());
}

class CrowdKnockAdminApp extends StatelessWidget {
  const CrowdKnockAdminApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'CrowdKnock Admin',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.indigo,
        scaffoldBackgroundColor: Colors.grey[100],
        fontFamily: 'Roboto',
      ),
      routerConfig: _router,
      debugShowCheckedModeBanner: false,
    );
  }
}

// Configuración de rutas del panel de administración
final _router = GoRouter(
  initialLocation: '/dashboard',
  routes: [
    GoRoute(
      path: '/dashboard',
      builder: (context, state) => const DashboardPage(),
    ),
    GoRoute(
      path: '/manage-content',
      builder: (context, state) => const ManageContentPage(),
    ),
    GoRoute(
      path: '/moderation',
      builder: (context, state) => const ModerationPage(),
    ),
    GoRoute(
      path: '/payments',
      builder: (context, state) => const PaymentsPage(),
    ),
    GoRoute(
      path: '/system-status',
      builder: (context, state) => const SystemStatusPage(),
    ),
    GoRoute(
      path: '/app-metrics',
      builder: (context, state) => const AppMetricsPage(),
    ),
    GoRoute(
      path: '/manage-users',
      builder: (context, state) => const ManageUsersPage(),
    ),
  ],
);
