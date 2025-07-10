import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/providers/auth_provider.dart';
import '../models/login_request.dart';
import '../services/auth_repository.dart';

final authControllerProvider = Provider((ref) {
  return AuthController(ref.read);
});

class AuthController {
  final Reader read;
  final AuthRepository _repository = AuthRepository();

  AuthController(this.read);

  Future<void> login(String email, String password) async {
    final token = await _repository.login(LoginRequest(email: email, password: password));
    if (token != null) {
      read(authProvider.notifier).login(token);
    }
  }
}