import 'package:flutter/material.dart';
import 'package:frontend_admin/core/constants/app_colors.dart';
import 'package:frontend_admin/core/layouts/admin_layout.dart';
import 'package:frontend_admin/core/services/feedback_service.dart';

class FeedbackPage extends StatefulWidget {
  const FeedbackPage({super.key});

  @override
  State<FeedbackPage> createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  final FeedbackService _feedbackService = FeedbackService();

  List<Map<String, dynamic>> _feedbackList = [];
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _fetchFeedback();
  }

  Future<void> _fetchFeedback() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final data = await _feedbackService.getAllFeedback();
      setState(() {
        _feedbackList = data;
      });
    } catch (e) {
      setState(() {
        _error = 'Error al cargar feedback.';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Widget _buildFeedbackCard(Map<String, dynamic> item) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: const Icon(Icons.feedback_outlined, color: AppColors.primary),
        title: Text(item['subject'] ?? 'Sin asunto'),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(item['message'] ?? 'Sin mensaje'),
            const SizedBox(height: 4),
            Text(
              'Enviado por: ${item['user_email'] ?? 'Anónimo'}',
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
            if (item['created_at'] != null)
              Text(
                'Fecha: ${item['created_at']}',
                style: const TextStyle(fontSize: 12, color: Colors.grey),
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
      title: 'Feedback de Usuarios',
      child: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
              ? Center(child: Text(_error!, style: const TextStyle(color: Colors.red)))
              : _feedbackList.isEmpty
                  ? const Center(child: Text('No se ha recibido feedback aún.'))
                  : ListView.builder(
                      itemCount: _feedbackList.length,
                      itemBuilder: (_, index) => _buildFeedbackCard(_feedbackList[index]),
                    ),
    );
  }
}

