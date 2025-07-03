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
        title: const Text('💬 User Feedback'),
        backgroundColor: Colors.indigo,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Recent Feedback
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Recent Feedback',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 16),
                      _FeedbackItem(
                        message: 'Great app, love the challenges!',
                        user: 'jane.doe@example.com',
                        date: '2025-06-28',
                      ),
                      SizedBox(height: 12),
                      _FeedbackItem(
                        message: 'I had trouble uploading my video.',
                        user: 'john.smith@example.com',
                        date: '2025-06-27',
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 30),

              // Add Note Form
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: const Padding(
                  padding: EdgeInsets.all(16),
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

// Sidebar reused
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
          _SidebarItem(title: 'Analytics', route: '/analytics'),
          _SidebarItem(title: 'App Metrics', route: '/app-metrics'),
          _SidebarItem(title: 'User Feedback', route: '/user-feedback', isActive: true),
          _SidebarItem(title: 'Settings', route: '/settings'),
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

// Feedback visual
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
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '"$message"',
            style: const TextStyle(fontSize: 14, color: Colors.grey),
          ),
          const SizedBox(height: 6),
          Text(
            'User: $user • Date: $date',
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}

// Feedback form + backend integration
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
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill in all fields'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    try {
      final response = await http.post(
        Uri.parse('https://your-api-url.com/api/feedback'), // TODO: Actualiza con la URL real del backend
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer YOUR_JWT_TOKEN', // TODO: Reemplaza con token real obtenido desde login
        },
        body: jsonEncode({
          'email': email,
          'message': message,
        }),
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Feedback submitted')),
        );
        _emailController.clear();
        _messageController.clear();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to submit: ${response.statusCode}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Add Note',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        TextField(
          controller: _emailController,
          decoration: const InputDecoration(
            labelText: 'User Email',
            hintText: 'example@domain.com',
            border: OutlineInputBorder(),
          ),
          keyboardType: TextInputType.emailAddress,
        ),
        const SizedBox(height: 16),
        TextField(
          controller: _messageController,
          decoration: const InputDecoration(
            labelText: 'Message',
            hintText: 'Enter note or comment',
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
          child: const Text('Submit'),
        ),
      ],
    );
  }
}
