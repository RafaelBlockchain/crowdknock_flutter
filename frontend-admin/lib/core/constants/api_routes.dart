class ApiRoutes {
  // Auth
  static const String login = '/auth/login';
  static const String logout = '/auth/logout';
  static const String userReports = '/reports/user';
  static const String resolveReport = '/reports/resolve';
  static const String emailTemplates = '/emails/templates';
  static const String updateEmailTemplate = '/emails/templates/update';

  
  // Usuarios
  static const String users = '/users';
  static String userById(int id) => '/users/$id';
  static const String userReports = '/reports/user';
  


  // Contenido
  static const String content = '/content';
  static String contentById(int id) => '/content/$id';

  // Métricas
  static const String globalMetrics = '/metrics/global';
  static const String userGrowth = '/metrics/user-growth';
  static const String contentActivity = '/metrics/content-activity';
  static const String topCategories = '/metrics/top-categories';
  static const String feedbackAll = '/feedback/all';
  static const String moderationPending = '/moderation/pending';
  static const String moderationAction = '/moderation/action'; // con PATCH o POST
  static const String resolveReport = '/reports/resolve'; // PATCH/POST con body { id }
  
  // Feedback o reportes
  static const String feedback = '/feedback';
  static String feedbackById(int id) => '/feedback/$id';
}

