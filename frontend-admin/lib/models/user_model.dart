// frontend-admin/lib/models/user_model.dart

class UserModel {
  final String id;
  final String name;
  final String email;
  final String role;
  final bool isActive;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    required this.isActive,
  });
  Map<String, dynamic> toJson() {
  return {
    'name': name,
    'email': email,
    'role': role,
    // otros campos que tu backend espera
  };
}

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json['id'],
        name: json['name'],
        email: json['email'],
        role: json['role'],
        isActive: json['is_active'] ?? true,
      );
   }
}
