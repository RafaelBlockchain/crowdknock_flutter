import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_settings_model.dart';

class SettingsService {
  static const _key = 'user_settings';

  /// Guarda los ajustes del usuario como JSON
  Future<void> saveSettings(UserSettingsModel settings) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = jsonEncode(settings.toJson());
    await prefs.setString(_key, jsonString);
  }

  /// Carga los ajustes desde almacenamiento local
  Future<UserSettingsModel> loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_key);

    if (jsonString != null) {
      final decoded = jsonDecode(jsonString);
      return UserSettingsModel.fromJson(decoded);
    }

    // Retorna ajustes por defecto si no hay guardados
    return UserSettingsModel(
      languageCode: 'es',
      isDarkMode: false,
      notificationsEnabled: true,
    );
  }

  /// Elimina los ajustes (por ejemplo, al cerrar sesión)
  Future<void> clearSettings() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key);
  }
}

