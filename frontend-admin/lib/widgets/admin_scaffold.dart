import 'package:flutter/material.dart';
import 'package:frontend_admin/widgets/sidebar.dart';
import 'package:frontend_admin/widgets/top_app_bar.dart';

class AdminScaffold extends StatelessWidget {
  final String title;
  final Widget child;

  const AdminScaffold({
    super.key,
    required this.title,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Sidebar(),
      appBar: TopAppBar(title: title),
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: child,
        ),
      ),
    );
  }
}
