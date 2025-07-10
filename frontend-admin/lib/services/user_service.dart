import 'package:frontend_admin/services/api_service.dart';
import 'package:frontend_admin/services/auth_service.dart';
import 'package:frontend_admin/models/user_model.dart';

class UserService {
  static Future<ApiService> _api() async {
    final token = await AuthService.getToken();
    return ApiService(
      baseUrl: 'https://api.crowdknock.com/api',
      jwtToken: token ?? '',
    );
  }

  /// 📥 Obtener todos los usuarios
  static Future<List<UserModel>> getAllUsers() async {
    final api = await _api();
    final response = await api.get('/users');
    return List<Map<String, dynamic>>.from(response)
        .map((json) => UserModel.fromJson(json))
        .toList();
  }

  /// ➕ Crear un nuevo usuario
  static Future<void> createUser(UserModel user) async {
    final api = await _api();
    await api.post('/users', user.toJson());
  }

  /// ✏️ Actualizar usuario por ID
  static Future<void> updateUser(String userId, Map<String, dynamic> updatedData) async {
    final api = await _api();
    await api.put('/users/$userId', updatedData);
  }

  /// 🗑 Eliminar usuario por ID
  static Future<void> deleteUser(String userId) async {
    final api = await _api();
    await api.delete('/users/$userId');
  }
}
