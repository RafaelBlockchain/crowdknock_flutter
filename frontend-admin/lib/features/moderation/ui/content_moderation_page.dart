import 'package:flutter/material.dart';
import 'package:frontend_admin/core/constants/app_colors.dart';
import 'package:frontend_admin/core/layouts/admin_layout.dart';
import 'package:frontend_admin/core/services/moderation_service.dart';

class ContentModerationPage extends StatefulWidget {
  const ContentModerationPage({super.key});

  @override
  State<ContentModerationPage> createState() => _ContentModerationPageState();
}

class _ContentModerationPageState extends State<ContentModerationPage> {
  final ModerationService _moderationService = ModerationService();

  List<Map<String, dynamic>> _pendingContent = [];
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadPendingContent();
  }

  Future<void> _loadPendingContent() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final content = await _moderationService.fetchPendingContent();
      setState(() {
        _pendingContent = content;
      });
    } catch (e) {
      setState(() {
        _error = 'Error al cargar contenido pendiente.';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _moderateContent(String id, String action) async {
    try {
      await _moderationService.moderateContent(id, action);
      _loadPendingContent(); // refresh
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al procesar contenido: $e')),
      );
    }
  }

  Widget _buildContentCard(Map<String, dynamic> content) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: const Icon(Icons.report, color: AppColors.warning),
        title: Text(content['title'] ?? 'Sin título'),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (content['description'] != null)
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(content['description']),
              ),
            if (content['user'] != null)
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text('Usuario: ${content['user']}',
                    style: const TextStyle(fontSize: 12, color: Colors.grey)),
              ),
            if (content['submitted_at'] != null)
              Text('Fecha: ${content['submitted_at']}',
                  style: const TextStyle(fontSize: 12, color: Colors.grey)),
          ],
        ),
        isThreeLine: true,
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.check_circle, color: Colors.green),
              tooltip: 'Aprobar',
              onPressed: () => _moderateContent(content['id'], 'approve'),
            ),
            IconButton(
              icon: const Icon(Icons.cancel, color: Colors.red),
              tooltip: 'Rechazar',
              onPressed: () => _moderateContent(content['id'], 'reject'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AdminLayout(
      title: 'Moderación de Contenido',
      child: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
              ? Center(child: Text(_error!, style: const TextStyle(color: Colors.red)))
              : _pendingContent.isEmpty
                  ? const Center(child: Text('No hay contenido pendiente por moderar.'))
                  : ListView.builder(
                      itemCount: _pendingContent.length,
                      itemBuilder: (_, index) => _buildContentCard(_pendingContent[index]),
                    ),
    );
  }
}
