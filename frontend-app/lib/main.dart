import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:frontend_app/app.dart';
import 'package:frontend_app/core/providers/auth_provider.dart';

initialRoute: '/login',
routes: appRoutes,

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");

  runApp(
    ChangeNotifierProvider(
      create: (_) => AuthProvider()..loadToken(),
      child: const MyApp(),
    ),
  );
}
