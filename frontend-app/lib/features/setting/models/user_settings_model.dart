class UserSettingsModel {
  final String languageCode;
  final bool isDarkMode;
  final bool notificationsEnabled;
  final String? preferredRole;

  UserSettingsModel({
    required this.languageCode,
    required this.isDarkMode,
    required this.notificationsEnabled,
    this.preferredRole,
  });

  // Método para convertir a Map<String, dynamic>
  Map<String, dynamic> toJson() {
    return {
      'languageCode': languageCode,
      'isDarkMode': isDarkMode,
      'notificationsEnabled': notificationsEnabled,
      'preferredRole': preferredRole,
    };
  }

  // Método para crear una instancia desde un Map
  factory UserSettingsModel.fromJson(Map<String, dynamic> json) {
    return UserSettingsModel(
      languageCode: json['languageCode'] ?? 'es',
      isDarkMode: json['isDarkMode'] ?? false,
      notificationsEnabled: json['notificationsEnabled'] ?? true,
      preferredRole: json['preferredRole'],
    );
  }

  // Crear una copia con cambios
  UserSettingsModel copyWith({
    String? languageCode,
    bool? isDarkMode,
    bool? notificationsEnabled,
    String? preferredRole,
  }) {
    return UserSettingsModel(
      languageCode: languageCode ?? this.languageCode,
      isDarkMode: isDarkMode ?? this.isDarkMode,
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
      preferredRole: preferredRole ?? this.preferredRole,
    );
  }

  @override
  String toString() {
    return 'UserSettingsModel(languageCode: $languageCode, darkMode: $isDarkMode, notifications: $notificationsEnabled, role: $preferredRole)';
  }
}

