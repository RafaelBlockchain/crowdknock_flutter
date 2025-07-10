import 'package:flutter/material.dart';
import '../widgets/admin_scaffold.dart';

class FeedbackPage extends StatelessWidget {
  const FeedbackPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
      title: '💬 Retroalimentación de Usuarios',
      currentRoute: '/user-feedback',
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Mensajes Recientes',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            // 📨 Feedback list
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: const [
                    FeedbackItem(
                      message: 'Great app, love the challenges!',
                      user: 'jane.doe@example.com',
                      date: '2025-06-28',
                    ),
                    SizedBox(height: 12),
                    FeedbackItem(
                      message: 'I had trouble uploading my video.',
                      user: 'john.smith@example.com',
                      date: '2025-06-27',
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 32),

            // 📝 Internal Note Form
            const Text(
              'Agregar Nota Interna',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: const Padding(
                padding: EdgeInsets.all(16),
                child: FeedbackForm(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// -------------------- Feedback Item --------------------

class FeedbackItem extends StatelessWidget {
  final String message;
  final String user;
  final String date;

  const FeedbackItem({
    super.key,
    required this.message,
    required this.user,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('"$message"', style: const TextStyle(fontSize: 14, color: Colors.grey)),
          const SizedBox(height: 6),
          Text(
            'Usuario: $user • Fecha: $date',
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}

// -------------------- Feedback Form --------------------

class FeedbackForm extends StatefulWidget {
  const FeedbackForm({super.key});

  @override
  State<FeedbackForm> createState() => _FeedbackFormState();
}

class _FeedbackFormState extends State<FeedbackForm> {
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();

  void _submitForm() {
    final email = _emailController.text.trim();
    final message = _messageController.text.trim();

    if (email.isEmpty || message.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor completa todos los campos'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // TODO: integrar con backend real
    // await FeedbackService.submit(email, message);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Feedback enviado')),
    );
    _emailController.clear();
    _messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: _emailController,
          decoration: const InputDecoration(
            labelText: 'Correo del Usuario',
            hintText: 'example@correo.com',
            border: OutlineInputBorder(),
          ),
          keyboardType: TextInputType.emailAddress,
        ),
        const SizedBox(height: 16),
        TextField(
          controller: _messageController,
          decoration: const InputDecoration(
            labelText: 'Mensaje o nota',
            hintText: 'Escribe tu comentario...',
            border: OutlineInputBorder(),
          ),
          maxLines: 4,
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.indigo,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          ),
          onPressed: _submitForm,
          child: const Text('Enviar'),
        ),
      ],
    );
  }
}

