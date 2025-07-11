class AppConfig {
  /// URL base del backend (Express + PostgreSQL)
  static const String baseUrl = 'https://api.tu-backend.com';

  /// Activar logs y errores detallados (solo desarrollo)
  static const bool debugMode = true;

  /// Nombre del entorno actual
  static const String environment = 'production'; // 'development', 'staging', 'production'

  /// Versión actual del panel admin
  static const String version = '1.0.0';

  /// Timeout estándar para peticiones HTTP (en segundos)
  static const int requestTimeout = 30;
}

