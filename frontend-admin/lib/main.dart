import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_fonts/google_fonts.dart';
import 'router/router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(); // Carga las variables desde .env
  runApp(const AdminPanelApp());
}

class AdminPanelApp extends StatelessWidget {
  const AdminPanelApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'CrowdKnock Admin',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        textTheme: GoogleFonts.interTextTheme(),
        scaffoldBackgroundColor: Colors.grey.shade100,
      ),
      routerConfig: appRouter, // Importado desde router/router.dart
    );
  }
}
