class ApiRoutes {
  // Auth
  static const String login = '/auth/login';
  static const String logout = '/auth/logout';

  // Usuarios
  static const String users = '/users';
  static String userById(int id) => '/users/$id';

  // Contenido
  static const String content = '/content';
  static String contentById(int id) => '/content/$id';

  // Métricas
  static const String globalMetrics = '/metrics/global';
  static const String userGrowth = '/metrics/user-growth';
  static const String contentActivity = '/metrics/content-activity';
  static const String topCategories = '/metrics/top-categories';

  // Feedback o reportes
  static const String feedback = '/feedback';
  static String feedbackById(int id) => '/feedback/$id';
}

