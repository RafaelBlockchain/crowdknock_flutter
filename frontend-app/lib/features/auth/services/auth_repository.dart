import '../../../core/services/api_service.dart';
import '../models/login_request.dart';

class AuthRepository {
  final ApiService _api = ApiService();

  Future<String?> login(LoginRequest data) async {
    final response = await _api.post('/auth/login', body: data.toJson());
    if (response.statusCode == 200) {
      return response.data['token'];
    } else {
      throw Exception(response.data['message']);
    }
  }
}