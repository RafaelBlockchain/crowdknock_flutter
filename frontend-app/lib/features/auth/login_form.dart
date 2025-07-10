import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../controllers/auth_controller.dart';

class LoginForm extends ConsumerStatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends ConsumerState<LoginForm> {
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();
  bool isLoading = false;

  void handleLogin() async {
    setState(() => isLoading = true);
    try {
      await ref.read(authControllerProvider).login(emailCtrl.text, passCtrl.text);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: \$e')));
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(controller: emailCtrl, decoration: InputDecoration(labelText: 'Email')),
        TextField(controller: passCtrl, obscureText: true, decoration: InputDecoration(labelText: 'Password')),
        SizedBox(height: 20),
        isLoading
            ? CircularProgressIndicator()
            : ElevatedButton(onPressed: handleLogin, child: Text("Iniciar Sesión")),
      ],
    );
  }
}