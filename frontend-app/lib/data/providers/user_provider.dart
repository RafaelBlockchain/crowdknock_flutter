import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../../services/user_service.dart';

class UserProvider extends ChangeNotifier {
  UserModel? _currentUser;
  bool _isLoading = false;
  String? _error;

  UserModel? get currentUser => _currentUser;
  bool get isLoading => _isLoading;
  String? get error => _error;

  /// Cargar datos del usuario autenticado desde el backend
  Future<void> loadUserProfile() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final user = await UserService().getCurrentUser();
      _currentUser = user;
    } catch (e) {
      _error = 'Error al cargar el perfil del usuario';
      _currentUser = null;
    }

    _isLoading = false;
    notifyListeners();
  }

  /// Actualizar datos del usuario (nombre, avatar, etc.)
  Future<void> updateUserProfile(UserModel updatedUser) async {
    try {
      final user = await UserService().updateUser(updatedUser);
      _currentUser = user;
      notifyListeners();
    } catch (e) {
      _error = 'Error al actualizar el perfil';
      notifyListeners();
    }
  }

  /// Cerrar sesión (solo limpia localmente)
  void logout() {
    _currentUser = null;
    notifyListeners();
  }
}

