import '../models/user_model.dart';
import '../../services/user_service.dart';

class UserRepository {
  final UserService _service = UserService();

  /// Obtener el perfil del usuario autenticado
  Future<UserModel> fetchCurrentUser() async {
    return await _service.getCurrentUser();
  }

  /// Actualizar perfil del usuario (nombre, avatar, etc.)
  Future<UserModel> updateUser(UserModel user) async {
    return await _service.updateUser(user);
  }

  /// Cambiar la contraseña del usuario
  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    await _service.changePassword(
      currentPassword: currentPassword,
      newPassword: newPassword,
    );
  }

  /// Cerrar sesión (limpia tokens localmente, si aplica)
  Future<void> logout() async {
    await _service.logout();
  }
}

