import 'package:flutter/material.dart';
import 'package:frontend_admin/core/constants/app_colors.dart';
import 'package:frontend_admin/core/constants/app_texts.dart';
import 'package:frontend_admin/core/services/user_service.dart';

class UserListScreen extends StatefulWidget {
  const UserListScreen({super.key});

  @override
  State<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  final UserService _userService = UserService();

  List<Map<String, dynamic>> _users = [];
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadUsers();
  }

  Future<void> _loadUsers() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final data = await _userService.fetchAllUsers();
      setState(() {
        _users = data;
      });
    } catch (e) {
      setState(() {
        _error = AppTexts.errorNetwork;
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _onEditUser(Map<String, dynamic> user) {
    // TODO: implementar pantalla de edición
    print('Editar: ${user['email']}');
  }

  void _onDeleteUser(int id) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text(AppTexts.deleteUser),
        content: const Text(AppTexts.confirmDeleteUser),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Cancelar')),
          TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Eliminar')),
        ],
      ),
    );

    if (confirmed == true) {
      try {
        final success = await _userService.deleteUser(id);
        if (success) _loadUsers();
      } catch (_) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text(AppTexts.errorGeneral)),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppTexts.usersTitle),
        backgroundColor: AppColors.primary,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadUsers,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: AppColors.primary,
        icon: const Icon(Icons.person_add),
        label: const Text(AppTexts.newUser),
        onPressed: () {
          Navigator.pushNamed(context, '/register'); // ruta a RegisterPage
        },
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
              ? Center(child: Text(_error!))
              : _users.isEmpty
                  ? const Center(child: Text(AppTexts.noData))
                  : ListView.separated(
                      padding: const EdgeInsets.all(16),
                      itemCount: _users.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 12),
                      itemBuilder: (_, index) {
                        final user = _users[index];
                        return Card(
                          elevation: 2,
                          child: ListTile(
                            leading: CircleAvatar(
                              child: Text(user['name'][0]),
                            ),
                            title: Text(user['name']),
                            subtitle: Text('${user['email']} • ${user['role']}'),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.edit),
                                  onPressed: () => _onEditUser(user),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () => _onDeleteUser(user['id']),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
    );
  }
}

