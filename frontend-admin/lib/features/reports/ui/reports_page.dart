import 'package:flutter/material.dart';

class ReportsPage extends StatelessWidget {
  const ReportsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const _Sidebar(),
      appBar: AppBar(
        title: const Text('📩 Reportes de Usuarios'),
        backgroundColor: Colors.indigo,
      ),
      backgroundColor: Colors.grey[100],
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: ListView(
          children: const [
            Text(
              'Panel de Reportes',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 32),
            _ReportsTable(),
          ],
        ),
      ),
    );
  }
}

