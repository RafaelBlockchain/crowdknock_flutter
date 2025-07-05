import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'routes/app_router.dart';

class CrowdKnockApp extends StatefulWidget {
  const CrowdKnockApp({super.key});

  @override
  State<CrowdKnockApp> createState() => _CrowdKnockAppState();
}

class _CrowdKnockAppState extends State<CrowdKnockApp> {
  @override
  void initState() {
    super.initState();
    _loadEnv();
  }

  Future<void> _loadEnv() async {
    await dotenv.load(fileName: ".env");
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'CrowdKnock',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.indigo,
      ),
      routerConfig: AppRouter.router,
    );
  }
}

