import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:frontend_app/core/providers/auth_provider.dart';
import 'package:frontend_app/core/widgets/custom_text_field.dart';
import 'package:frontend_app/core/widgets/primary_button.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _emailController;

  @override
  void initState() {
    super.initState();
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    _nameController = TextEditingController(text: authProvider.user?.name ?? '');
    _emailController = TextEditingController(text: authProvider.user?.email ?? '');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _saveProfile() {
    if (_formKey.currentState?.validate() ?? false) {
      // Aquí puedes llamar al servicio user_service.updateProfile(...)
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Perfil actualizado exitosamente')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Editar Perfil')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              CustomTextField(
                label: 'Nombre',
                controller: _nameController,
                validator: (value) => value!.isEmpty ? 'El nombre es requerido' : null,
              ),
              const SizedBox(height: 16),
              CustomTextField(
                label: 'Correo electrónico',
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                validator: (value) => value!.contains('@') ? null : 'Email inválido',
              ),
              const SizedBox(height: 32),
              PrimaryButton(
                text: 'Guardar Cambios',
                onPressed: _saveProfile,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
