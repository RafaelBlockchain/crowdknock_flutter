class FormValidators {
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) return 'El correo es obligatorio';
    final emailRegex = RegExp(r'^[\w\.\-]+@[\w\.\-]+\.\w{2,4}$');
    if (!emailRegex.hasMatch(value)) return 'Correo inválido';
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) return 'La contraseña es obligatoria';
    if (value.length < 6) return 'Debe tener al menos 6 caracteres';
    return null;
  }

  static String? validateNotEmpty(String? value, String field) {
    if (value == null || value.trim().isEmpty) return '$field es obligatorio';
    return null;
  }
}

