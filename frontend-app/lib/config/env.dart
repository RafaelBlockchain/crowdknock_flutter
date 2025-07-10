class Env {
  static const String appName = String.fromEnvironment('APP_NAME', defaultValue: 'CrowdKnock');
  static const String environment = String.fromEnvironment('ENV', defaultValue: 'development');
  static const String apiBaseUrl = String.fromEnvironment('API_BASE_URL', defaultValue: 'http://localhost:3000/api');

  static const bool isProduction = environment == 'production';
}

