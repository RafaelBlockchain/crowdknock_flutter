import 'package:flutter/material.dart';
import '../../config/theme.dart';

class AppProvider extends ChangeNotifier {
  // Tema actual de la app
  ThemeMode _themeMode = ThemeMode.light;

  // Idioma actual (opcional, si usas i18n)
  Locale _locale = const Locale('es');

  // Modo oscuro activado o no
  bool get isDarkMode => _themeMode == ThemeMode.dark;

  // Exponer los valores
  ThemeMode get themeMode => _themeMode;
  Locale get locale => _locale;

  // Cambiar tema entre claro/oscuro
  void toggleTheme() {
    _themeMode = isDarkMode ? ThemeMode.light : ThemeMode.dark;
    notifyListeners();
  }

  // Establecer directamente un tema
  void setTheme(ThemeMode mode) {
    _themeMode = mode;
    notifyListeners();
  }

  // Cambiar idioma de la app
  void setLocale(Locale newLocale) {
    _locale = newLocale;
    notifyListeners();
  }

  // Inicialización de configuración futura
  Future<void> initializeApp() async {
    // TODO: cargar configuración desde almacenamiento persistente
    // Ejemplo: SharedPreferences prefs = await SharedPreferences.getInstance();
    // setTheme(prefs.getBool('isDark') ? ThemeMode.dark : ThemeMode.light);
    // setLocale(Locale(prefs.getString('lang') ?? 'es'));
  }
}

