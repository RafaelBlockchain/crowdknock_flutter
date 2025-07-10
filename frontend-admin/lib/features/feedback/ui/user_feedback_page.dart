import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UserFeedbackPage extends StatelessWidget {
  const UserFeedbackPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      drawer: const _Sidebar(),
      appBar: AppBar(
        title: const Text('💬 Retroalimentación de Usuarios'),
        backgroundColor: Colors.indigo,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 🔹 Lista de feedback reciente
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text('Últimos comentarios',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      SizedBox(height: 20),
                      _FeedbackItem(
                        message: 'Excelente app, ¡me encantan los retos!',
                        user: 'jane.doe@example.com',
                        date: '2025-06-28',
                      ),
                      SizedBox(height: 12),
                      _FeedbackItem(
                        message: 'Tuve problemas al subir mi video.',
                        user: 'john.smith@example.com',
                        date: '2025-06-27',
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 32),

              // 🔹 Formulario de nota o comentario
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: const Padding(
                  padding: EdgeInsets.all(20),
                  child: _FeedbackForm(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// 🔹 Sidebar reutilizable
class _Sidebar extends StatelessWidget {
  const _Sidebar();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          Text(
            'CrowdKnock Admin',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.indigo,
            ),
          ),
          SizedBox(height: 20),
          _SidebarItem(title: 'Dashboard', route: '/dashboard'),
          _SidebarItem(title: 'Analítica', route: '/analytics'),
          _SidebarItem(title: 'Métricas App', route: '/app-metrics'),
          _SidebarItem(title: 'Feedback Usuarios', route: '/user-feedback', isActive: true),
          _SidebarItem(title: 'Configuración', route: '/settings'),
        ],
      ),
    );
  }
}

class _SidebarItem extends StatelessWidget {
  final String title;
  final String route;
  final bool isActive;

  const _SidebarItem({
    required this.title,
    required this.route,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      tileColor: isActive ? Colors.indigo[500] : null,
      textColor: isActive ? Colors.white : null,
      onTap: () {
        if (!isActive) {
          Navigator.pushReplacementNamed(context, route);
        } else {
          Navigator.pop(context);
        }
      },
    );
  }
}

// 🔹 Ítem individual de feedback
class _FeedbackItem extends StatelessWidget {
  final String message;
  final String user;
  final String date;

  const _FeedbackItem({
    required this.message,
    required this.user,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('"$message"', style: const TextStyle(fontSize: 14, color: Colors.black87)),
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

// 🔹 Formulario de feedback conectado al backend
class _FeedbackForm extends StatefulWidget {
  const _FeedbackForm({super.key});

  @override
  State<_FeedbackForm> createState() => _FeedbackFormState();
}

class _FeedbackFormState extends State<_FeedbackForm> {
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();

  Future<void> _submitForm() async {
    final email = _emailController.text.trim();
    final message = _messageController.text.trim();

    if (email.isEmpty || message.isEmpty) {
      _showSnackbar('Por favor completa todos los campos', isError: true);
      return;
    }

    try {
      final response = await http.post(
        Uri.parse('https://your-backend-api.com/api/feedback'), // 🔁 Actualiza con tu API real
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer YOUR_JWT_TOKEN', // 🔒 Sustituye con token real
        },
        body: jsonEncode({'email': email, 'message': message}),
      );

      if (response.statusCode == 200) {
        _showSnackbar('✅ Feedback enviado correctamente');
        _emailController.clear();
        _messageController.clear();
      } else {
        _showSnackbar('Error ${response.statusCode}: No se pudo enviar feedback', isError: true);
      }
    } catch (e) {
      _showSnackbar('Error: $e', isError: true);
    }
  }

  void _showSnackbar(String msg, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: isError ? Colors.red : Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Enviar Nota / Comentario', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        TextField(
          controller: _emailController,
          decoration: const InputDecoration(
            labelText: 'Correo del usuario',
            hintText: 'usuario@ejemplo.com',
            border: OutlineInputBorder(),
          ),
          keyboardType: TextInputType.emailAddress,
        ),
        const SizedBox(height: 16),
        TextField(
          controller: _messageController,
          maxLines: 4,
          decoration: const InputDecoration(
            labelText: 'Mensaje',
            hintText: 'Escribe un comentario, error o sugerencia...',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 20),
        ElevatedButton.icon(
          onPressed: _submitForm,
          icon: const Icon(Icons.send),
          label: const Text('Enviar'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.indigo,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          ),
        ),
      ],
    );
  }
}

