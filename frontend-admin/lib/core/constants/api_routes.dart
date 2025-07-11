class ApiRoutes {
  // 🔐 Autenticación
  static const String login = '/auth/login';
  static const String logout = '/auth/logout';

  // 👥 Usuarios
  static const String users = '/users';
  static String userById(int id) => '/users/$id';

  // 📦 Contenido
  static const String contentAll = '/content';
  static const String content = '/content';
  static String contentById(int id) => '/content/$id';

  // ⚖️ Moderación
  static const String moderationPending = '/moderation/pending';
  static const String moderationAction = '/moderation/action'; // PATCH o POST

  // 📊 Métricas
  static const String globalMetrics = '/metrics/global';
  static const String userGrowth = '/metrics/user-growth';
  static const String contentActivity = '/metrics/content-activity';
  static const String topCategories = '/metrics/top-categories';

  // 📨 Reportes
  static const String userReports = '/reports/user';
  static const String resolveReport = '/reports/resolve'; // PATCH/POST

  // 📨 Email Templates
  static const String emailTemplates = '/emails/templates';
  static const String updateEmailTemplate = '/emails/templates/update';

  // 💳 Pagos
  static const String paymentsList = '/payments';

  // 💬 Feedback
  static const String feedback = '/feedback';
  static const String feedbackAll = '/feedback/all';
  static String feedbackById(int id) => '/feedback/$id';

  // ⚙️ Configuración
  static const String getSettings = '/settings';
  static const String updateSettings = '/settings/update';
}
