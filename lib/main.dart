import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Asset Test',
      debugShowCheckedModeBanner: false,
      home: const LogoTestScreen(), // pantalla de prueba
    );
  }
}

class LogoTestScreen extends StatelessWidget {
  const LogoTestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Test de Logos')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Desde assets/images/logo.png'),
            Image.asset(
              'assets/images/logo.png',
              height: 100,
            ),
            const SizedBox(height: 20),
            const Text('Desde assets/icons/logo.png'),
            Image.asset(
              'assets/icons/logo.png',
              height: 100,
            ),
          ],
        ),
      ),
    );
  }
}
