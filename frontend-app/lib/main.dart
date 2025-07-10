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
import 'package:flutter/material.dart';
import 'routes/route_generator.dart';
import 'routes/app_routes.dart';
import 'theme/app_theme.dart';
import 'package:provider/provider.dart';
import 'core/providers/auth_provider.dart';
import 'core/providers/theme_provider.dart';
import 'core/providers/connectivity_provider.dart';


void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => ConnectivityProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => ConnectivityProvider()),
      ],
      child: const MyApp(),
    ),
  );
}


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CrowdKnock',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: const SplashPage(),
    );
  }
}


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CrowdKnock',
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.splash,
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}


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
