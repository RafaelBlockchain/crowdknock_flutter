import 'package:flutter/material.dart';
import '../widgets/login_form.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: LoginForm(),
        ),
      ),
    );
  }
}