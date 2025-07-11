import 'package:flutter/material.dart';
import 'package:frontend_admin/core/constants/app_colors.dart';
import 'package:frontend_admin/core/layouts/admin_layout.dart';
import 'package:frontend_admin/core/services/email_service.dart';

class EmailTemplatesScreen extends StatefulWidget {
  const EmailTemplatesScreen({super.key});

  @override
  State<EmailTemplatesScreen> createState() => _EmailTemplatesScreenState();
}

class _EmailTemplatesScreenState extends State<EmailTemplatesScreen> {
  final EmailService _emailService = EmailService();

  List<Map<String, dynamic>> _templates = [];
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadTemplates();
  }

  Future<void> _loadTemplates() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final data = await _emailService.fetchTemplates();
      setState(() => _templates = data);
    } catch (e) {
      setState(() => _error = 'Error al cargar las plantillas de correo.');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _editTemplate(Map<String, dynamic> template) {
    showDialog(
      context: context,
      builder: (_) => _EditTemplateDialog(
        template: template,
        onSave: (updatedContent) async {
          await _emailService.updateTemplate(template['id'], updatedContent);
          Navigator.of(context).pop();
          _loadTemplates(); // Reload after save
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AdminLayout(
      title: 'Plantillas de Correo',
      child: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
              ? Center(child: Text(_error!, style: const TextStyle(color: Colors.red)))
              : _templates.isEmpty
                  ? const Center(child: Text('No hay plantillas disponibles.'))
                  : ListView.builder(
                      itemCount: _templates.length,
                      itemBuilder: (_, index) {
                        final tpl = _templates[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          child: ListTile(
                            title: Text(tpl['subject'] ?? 'Sin asunto'),
                            subtitle: Text(
                              tpl['name'] ?? '',
                              style: const TextStyle(fontSize: 13),
                            ),
                            trailing: IconButton(
                              icon: const Icon(Icons.edit, color: AppColors.primary),
                              tooltip: 'Editar plantilla',
                              onPressed: () => _editTemplate(tpl),
                            ),
                          ),
                        );
                      },
                    ),
    );
  }
}

class _EditTemplateDialog extends StatefulWidget {
  final Map<String, dynamic> template;
  final Future<void> Function(String updatedContent) onSave;

  const _EditTemplateDialog({
    required this.template,
    required this.onSave,
  });

  @override
  State<_EditTemplateDialog> createState() => _EditTemplateDialogState();
}

class _EditTemplateDialogState extends State<_EditTemplateDialog> {
  late TextEditingController _contentController;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    _contentController = TextEditingController(text: widget.template['content'] ?? '');
  }

  @override
  void dispose() {
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.template['name'] ?? 'Editar plantilla'),
      content: SizedBox(
        width: 500,
        child: TextField(
          controller: _contentController,
          maxLines: 10,
          decoration: const InputDecoration(
            labelText: 'Contenido del correo',
            border: OutlineInputBorder(),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: _saving ? null : () => Navigator.of(context).pop(),
          child: const Text('Cancelar'),
        ),
        ElevatedButton(
          onPressed: _saving
              ? null
              : () async {
                  setState(() => _saving = true);
                  await widget.onSave(_contentController.text);
                  setState(() => _saving = false);
                },
          child: _saving
              ? const SizedBox(height: 16, width: 16, child: CircularProgressIndicator(strokeWidth: 2))
              : const Text('Guardar'),
        ),
      ],
    );
  }
}
