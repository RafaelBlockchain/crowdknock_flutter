import 'package:flutter/material.dart';
import 'package:frontend_admin/core/constants/app_colors.dart';
import 'package:frontend_admin/core/layouts/admin_layout.dart';
import 'package:frontend_admin/core/services/feedback_service.dart';

class AppFeedbackScreen extends StatefulWidget {
  const AppFeedbackScreen({super.key});

  @override
  State<AppFeedbackScreen> createState() => _AppFeedbackScreenState();
}

class _AppFeedbackScreenState extends State<AppFeedbackScreen> {
  final FeedbackService _feedbackService = FeedbackService();

  List<Map<String, dynamic>> _feedbacks = [];
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadFeedbacks();
  }

  Future<void> _loadFeedbacks() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final data = await _feedbackService.fetchAllFeedback();
      setState(() => _feedbacks = data);
    } catch (e) {
      setState(() => _error = 'Error al cargar feedback de usuarios.');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Widget _buildFeedbackCard(Map<String, dynamic> fb) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      elevation: 2,
      child: ListTile(
        leading: const Icon(Icons.feedback, color: AppColors.primary),
        title: Text(fb['title'] ?? 'Sin título'),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (fb['user'] != null) Text('Usuario: ${fb['user']}'),
            if (fb['message'] != null)
              Padding(
                padding: const EdgeInsets.only(top: 6.0),
                child: Text(
                  fb['message'],
                  style: const TextStyle(fontSize: 13, color: Colors.black87),
                ),
              ),
            if (fb['created_at'] != null)
              Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Text(
                  'Fecha: ${fb['created_at']}',
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ),
          ],
        ),
        isThreeLine: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AdminLayout(
      title: 'Feedback de la App',
      child: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
              ? Center(child: Text(_error!, style: const TextStyle(color: Colors.red)))
              : _feedbacks.isEmpty
                  ? const Center(child: Text('No se ha recibido feedback aún.'))
                  : ListView.builder(
                      itemCount: _feedbacks.length,
                      itemBuilder: (_, i) => _buildFeedbackCard(_feedbacks[i]),
                    ),
    );
  }
}
