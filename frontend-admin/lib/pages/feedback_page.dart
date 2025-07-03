import 'package:flutter/material.dart';

class FeedbackPage extends StatelessWidget {
  const FeedbackPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      drawer: const Sidebar(currentRoute: '/user-feedback'),
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
              const SizedBox(height: 30),

              // Internal Note Form
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
      ),
    );
  }
}

// -------------------- Sidebar --------------------
class Sidebar extends StatelessWidget {
  final String currentRoute;

  const Sidebar({super.key, required this.currentRoute});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'CrowdKnock Admin',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.indigo,
            ),
          ),
          const SizedBox(height: 20),
          SidebarItem(title: 'Dashboard', route: '/dashboard', isActive: currentRoute == '/dashboard'),
          SidebarItem(title: 'Analytics', route: '/analytics', isActive: currentRoute == '/analytics'),
          SidebarItem(title: 'App Metrics', route: '/app-metrics', isActive: currentRoute == '/app-metrics'),
          SidebarItem(title: 'User Feedback', route: '/user-feedback', isActive: currentRoute == '/user-feedback'),
          SidebarItem(title: 'Settings', route: '/settings', isActive: currentRoute == '/settings'),
        ],
      ),
    );
  }
}

class SidebarItem extends StatelessWidget {
  final String title;
  final String route;
  final bool isActive;

  const SidebarItem({
    super.key,
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
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please fill in all fields'),
            backgroundColor: Colors.red,
          ),
        );
      }
      return;
    }

    // TODO: Enviar a backend cuando esté disponible
    // await FeedbackService.submit(email, message);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Feedback submitted')),
      );
      _emailController.clear();
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Add Internal Note',
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

