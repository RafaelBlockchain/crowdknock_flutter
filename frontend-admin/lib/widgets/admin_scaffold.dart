import 'package:flutter/material.dart';
import 'admin_sidebar.dart';
import 'package:go_router/go_router.dart';

class AdminScaffold extends StatelessWidget {
  final String title;
  final Widget body;

  const AdminScaffold({
    super.key,
    required this.title,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    final currentRoute = GoRouter.of(context).location;

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.indigo,
      ),
      drawer: AdminSidebar(currentRoute: currentRoute),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: body,
      ),
    );
  }
}
