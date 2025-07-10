import 'package:flutter/material.dart';
import '../core/services/auth_service.dart';
import '../pages/login_page.dart';

class RouteGuard {
  static Future<bool> isAuthenticated() async {
    final token = await AuthService().getToken();
    return token != null;
  }

  static Route<dynamic> guard({
    required RouteSettings settings,
    required WidgetBuilder builder,
  }) {
    return MaterialPageRoute(
      builder: (_) => FutureBuilder<bool>(
        future: isAuthenticated(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          return snapshot.data! ? builder(context) : const LoginPage();
        },
      ),
    );
  }
}

