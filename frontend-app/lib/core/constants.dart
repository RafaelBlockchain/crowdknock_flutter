import 'package:flutter/material.dart';

/// Rutas usadas en la app
class AppRoutes {
  static const String login = '/login';
  static const String dashboard = '/dashboard';
  static const String manageContent = '/manage-content';
  static const String accessDenied = '/access-denied';
}

/// Textos globales reutilizables
class AppTexts {
  static const String appName = 'CrowdKnock';
  static const String welcome = 'Bienvenido';
  static const String loading = 'Cargando...';
  static const String error = 'Ocurrió un error inesperado';
}

/// Roles de usuario
class AppRoles {
  static const String admin = 'admin';
  static const String user = 'user';
  static const String moderator = 'moderator';
}

/// Colores globales base
class AppColors {
  static const Color primary = Colors.blue;
  static const Color accent = Colors.blueAccent;
  static const Color danger = Colors.red;
  static const Color success = Colors.green;
  static const Color warning = Colors.orange;
}

/// Duraciones animaciones y efectos
class AppDurations {
  static const Duration short = Duration(milliseconds: 200);
  static const Duration medium = Duration(milliseconds: 400);
  static const Duration long = Duration(milliseconds: 700);
}

/// Tamaños y paddings estándar
class AppSizes {
  static const double paddingSmall = 8.0;
  static const double paddingMedium = 16.0;
  static const double paddingLarge = 24.0;

  static const double radiusSmall = 6.0;
  static const double radiusMedium = 12.0;
  static const double radiusLarge = 20.0;
}

