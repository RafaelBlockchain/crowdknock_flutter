class FormValidator {
  static String? required(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Este campo es obligatorio';
    }
    return null;
  }

  static String? email(String? value) {
    const pattern = r'^[^@]+@[^@]+\.[^@]+$';
    final regex = RegExp(pattern);
    if (!regex.hasMatch(value ?? '')) {
      return 'Correo inválido';
    }
    return null;
  }

  static String? password(String? value) {
    if (value == null || value.length < 6) {
      return 'Mínimo 6 caracteres';
    }
    return null;
  }
}

