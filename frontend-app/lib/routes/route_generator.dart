import 'package:flutter/material.dart';
import '../pages/home_page.dart';
import '../pages/onboarding_page.dart';
import '../pages/splash_page.dart';
import '../pages/not_found_page.dart';
import '../features/auth/login_page.dart';
import '../features/auth/register_page.dart';
import '../features/challenges/challenge_list.dart';
import '../features/manage_content/pages/content_list.dart';
import '../features/polls/ui/poll_list_page.dart';
import '../features/reports/submit_report_screen.dart';
import '../features/metrics/ui/app_metrics_screen.dart';
import '../features/setting/ui/settings_screen.dart';
import 'app_routes.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.splash:
        return MaterialPageRoute(builder: (_) => const SplashPage());

      case AppRoutes.onboarding:
        return MaterialPageRoute(builder: (_) => const OnboardingPage());

      case AppRoutes.login:
        return MaterialPageRoute(builder: (_) => const LoginPage());

      case AppRoutes.register:
        return MaterialPageRoute(builder: (_) => const RegisterPage());

      case AppRoutes.home:
        return MaterialPageRoute(builder: (_) => const HomePage());

      case AppRoutes.challenges:
        return MaterialPageRoute(builder: (_) => const ChallengeListPage());

      case AppRoutes.content:
        return MaterialPageRoute(builder: (_) => const ContentListPage());

      case AppRoutes.polls:
        return MaterialPageRoute(builder: (_) => const PollListPage());

      case AppRoutes.reports:
        return MaterialPageRoute(
          builder: (_) => const SubmitReportScreen(
            reportedItemId: 'example-id',
            reportType: 'general',
          ),
        );

      case AppRoutes.metrics:
        return MaterialPageRoute(builder: (_) => const AppMetricsScreen());

      case AppRoutes.settings:
        return MaterialPageRoute(builder: (_) => const SettingsScreen());

      default:
        return MaterialPageRoute(builder: (_) => const NotFoundPage());
    }
  }
}

