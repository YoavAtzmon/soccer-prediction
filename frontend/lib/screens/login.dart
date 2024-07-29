import 'package:flutter/material.dart';
import 'package:namer_app/services/auth_service.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: _isLoading
          ? const CircularProgressIndicator()
          : ElevatedButton(
              onPressed: () async {
                setState(() {
                  _isLoading = true;
                });
                await GoogleAuthService().signInWithGoogle();
              },
              child: const Text('Sign in with Google'),
            ),
    );
  }
}
