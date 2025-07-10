import 'package:flutter/material.dart';
import 'home_page.dart';
import 'splash_page.dart';
import 'onboarding_page.dart';
import 'not_found_page.dart';

final Map<String, WidgetBuilder> appRoutes = {
  '/': (_) => const SplashPage(),
  '/onboarding': (_) => const OnboardingPage(),
  '/home': (_) => const HomePage(),
};

Route<dynamic> generateRoute(RouteSettings settings) {
  final builder = appRoutes[settings.name];
  return MaterialPageRoute(
    builder: builder ?? (_) => const NotFoundPage(),
  );
}

