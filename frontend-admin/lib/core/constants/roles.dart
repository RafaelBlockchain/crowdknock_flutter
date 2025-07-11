class UserRoles {
  static const String admin = 'ADMIN';
  static const String moderator = 'MODERATOR';
  static const String reviewer = 'REVIEWER';
  static const String editor = 'EDITOR';
  static const String viewer = 'VIEWER';

  // Para listas desplegables o selección
  static const List<String> allRoles = [
    admin,
    moderator,
    reviewer,
    editor,
    viewer,
  ];

  // Descripciones opcionales (para UI amigable)
  static const Map<String, String> roleDescriptions = {
    admin: 'Administrador general del sistema',
    moderator: 'Modera contenido y usuarios',
    reviewer: 'Revisa reportes o contenido crítico',
    editor: 'Puede crear y editar contenido',
    viewer: 'Solo lectura',
  };
}

