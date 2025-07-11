import 'package:flutter/material.dart';
import 'package:frontend_admin/core/constants/app_colors.dart';
import 'package:frontend_admin/core/layouts/admin_layout.dart';
import 'package:frontend_admin/core/services/settings_service.dart';

class AppSettingsScreen extends StatefulWidget {
  const AppSettingsScreen({super.key});

  @override
  State<AppSettingsScreen> createState() => _AppSettingsScreenState();
}

class _AppSettingsScreenState extends State<AppSettingsScreen> {
  final SettingsService _settingsService = SettingsService();

  Map<String, dynamic> _settings = {};
  bool _isLoading = true;
  String? _error;
  bool _saving = false;

  final _formKey = GlobalKey<FormState>();
  late TextEditingController _appNameController;
  late TextEditingController _supportEmailController;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final data = await _settingsService.fetchSettings();
      setState(() {
        _settings = data;
        _appNameController = TextEditingController(text: data['app_name'] ?? '');
        _supportEmailController = TextEditingController(text: data['support_email'] ?? '');
      });
    } catch (e) {
      setState(() => _error = 'Error al cargar la configuración.');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _saveSettings() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _saving = true);

    try {
      await _settingsService.updateSettings({
        'app_name': _appNameController.text,
        'support_email': _supportEmailController.text,
      });
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('✅ Configuración actualizada'),
        backgroundColor: Colors.green,
      ));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('❌ Error al guardar'),
        backgroundColor: Colors.red,
      ));
    } finally {
      setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AdminLayout(
      title: 'Configuración de la App',
      child: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
              ? Center(child: Text(_error!, style: const TextStyle(color: Colors.red)))
              : Form(
                  key: _formKey,
                  child: ListView(
                    padding: const EdgeInsets.all(24),
                    children: [
                      TextFormField(
                        controller: _appNameController,
                        decoration: const InputDecoration(labelText: 'Nombre de la App'),
                        validator: (value) =>
                            value == null || value.isEmpty ? 'Este campo es obligatorio' : null,
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _supportEmailController,
                        decoration: const InputDecoration(labelText: 'Email de Soporte'),
                        validator: (value) =>
                            value == null || value.isEmpty ? 'Este campo es obligatorio' : null,
                      ),
                      const SizedBox(height: 32),
                      ElevatedButton.icon(
                        onPressed: _saving ? null : _saveSettings,
                        icon: const Icon(Icons.save),
                        label: _saving
                            ? const SizedBox(
                                height: 18, width: 18, child: CircularProgressIndicator(strokeWidth: 2))
                            : const Text('Guardar Cambios'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                        ),
                      )
                    ],
                  ),
                ),
    );
  }
}
