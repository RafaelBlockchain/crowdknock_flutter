import 'package:flutter/material.dart';

// Autenticación
import 'package:frontend_app/features/auth/login_page.dart';
import 'package:frontend_app/features/auth/register_page.dart';

// App principal
import 'package:frontend_app/pages/splash_page.dart';
import 'package:frontend_app/pages/onboarding_page.dart';
import 'package:frontend_app/pages/home_page.dart';
import 'package:frontend_app/pages/access_denied_page.dart';
import 'package:frontend_app/pages/not_found_page.dart';

// Features (usuario)
import 'package:frontend_app/features/challenges/challenge_list.dart';
import 'package:frontend_app/features/manage_content/pages/content_list.dart';
import 'package:frontend_app/features/polls/ui/poll_list_page.dart';
import 'package:frontend_app/features/reports/submit_report_screen.dart';
import 'package:frontend_app/features/metrics/ui/app_metrics_screen.dart';
import 'package:frontend_app/features/setting/ui/settings_screen.dart';
import 'package:frontend_app/features/profile/edit_profile_screen.dart';
import 'package:frontend_app/features/system_status/system_status_screen.dart';

// Admin panel
import 'package:frontend_app/features/dashboard/ui/dashboard_screen.dart';
import 'package:frontend_app/features/manage_content/ui/manage_content_screen.dart';
import 'package:frontend_app/features/moderation/ui/moderation_screen.dart';
import 'package:frontend_app/features/payments/ui/payments_screen.dart';
import 'package:frontend_app/features/reports/ui/reports_screen.dart';
import 'package:frontend_app/features/app_metrics/ui/app_metrics_screen.dart';
import 'package:frontend_app/features/users/ui/manage_users_screen.dart';
import 'package:frontend_app/features/profile/ui/change_password_screen.dart';

// Middleware
import 'package:frontend_app/core/middleware/auth_guard.dart';
import 'package:frontend_app/features/profile/ui/profile_screen.dart';

class AppRoutes {
  // Público / Core
  static const splash = '/';
  static const onboarding = '/onboarding';
  static const login = '/login';
  static const register = '/register';
  static const home = '/home';
  static const accessDenied = '/access-denied';
  static const notFound = '/404';

  // Usuario general
  static const challenges = '/challenges';
  static const content = '/content';
  static const polls = '/polls';
  static const reports = '/reports';
  static const metrics = '/metrics';
  static const settings = '/settings';
  static const editProfile = '/edit-profile';
  static const systemStatus = '/system-status';

  // Admin panel
  static const dashboard = '/dashboard';
  static const manageContent = '/manage-content';
  static const moderation = '/moderation';
  static const payments = '/payments';
  static const adminReports = '/admin-reports';
  static const adminMetrics = '/app-metrics';
  static const manageUsers = '/users';
  static const profile = '/profile';
  static const changePassword = '/change-password';
}

/// Mapa global de rutas
final Map<String, WidgetBuilder> appRoutes = {
  // Público
  AppRoutes.splash: (_) => const SplashPage(),
  AppRoutes.onboarding: (_) => const OnboardingPage(),
  AppRoutes.login: (_) => const LoginPage(),
  AppRoutes.register: (_) => const RegisterPage(),
  AppRoutes.accessDenied: (_) => const AccessDeniedPage(),
  AppRoutes.notFound: (_) => const NotFoundPage(),

  // Usuario
  AppRoutes.home: (_) => const HomePage(),
  AppRoutes.challenges: (_) => const ChallengeListPage(),
  AppRoutes.content: (_) => const ContentListPage(),
  AppRoutes.polls: (_) => const PollListPage(),
  AppRoutes.reports: (_) => const SubmitReportScreen(
        reportedItemId: 'example-id',
        reportType: 'general',
      ),
  AppRoutes.metrics: (_) => const AppMetricsScreen(),
  AppRoutes.settings: (_) => const SettingsScreen(),
  AppRoutes.editProfile: (_) => const EditProfileScreen(),
  AppRoutes.systemStatus: (_) => const SystemStatusScreen(),

  // Admin (protegidas)
  AppRoutes.dashboard: (_) => const AuthGuard(child: DashboardScreen()),
  AppRoutes.manageContent: (_) => const AuthGuard(child: ManageContentScreen()),
  AppRoutes.moderation: (_) => const AuthGuard(child: ModerationScreen()),
  AppRoutes.payments: (_) => const AuthGuard(child: PaymentsScreen()),
  AppRoutes.adminReports: (_) => const AuthGuard(child: ReportsScreen()),
  AppRoutes.adminMetrics: (_) => const AuthGuard(child: AppMetricsScreen()),
  AppRoutes.manageUsers: (_) => const AuthGuard(child: ManageUsersScreen()),
  AppRoutes.profile: (_) => const AuthGuard(child: ProfileScreen()),
  AppRoutes.changePassword: (_) => const AuthGuard(child: ChangePasswordScreen()),
};
