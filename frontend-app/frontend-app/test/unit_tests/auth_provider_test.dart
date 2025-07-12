import 'package:flutter_test/flutter_test.dart';
import 'package:frontend_app/core/providers/auth_provider.dart';

void main() {
  group('AuthProvider Tests', () {
    late AuthProvider authProvider;

    setUp(() {
      authProvider = AuthProvider();
    });

    test('Estado inicial debe ser no autenticado', () {
      expect(authProvider.isAuthenticated, false);
      expect(authProvider.token, isNull);
    });

    test('setToken establece el token y cambia estado', () {
      authProvider.setToken('test123');
      expect(authProvider.token, 'test123');
      expect(authProvider.isAuthenticated, true);
    });

    test('logout borra token y cambia estado', () {
      authProvider.setToken('test123');
      authProvider.logout();
      expect(authProvider.token, isNull);
      expect(authProvider.isAuthenticated, false);
    });

    test('Simular login exitoso con setToken', () async {
      // Simula login
      await Future.delayed(Duration(milliseconds: 300)); // Simular carga
      authProvider.setToken('jwt_token');
      expect(authProvider.isAuthenticated, true);
    });
  });
}
