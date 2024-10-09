import 'package:flutter/material.dart';
import '../log_in/log_in_screen.dart';
import '../sign_up/sign_up_screen.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool _isLogin = true;

  void toggleAuthMode() {
    setState(() => _isLogin = !_isLogin);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_isLogin ? 'Login' : 'Sign Up')),
      body: _isLogin
          ? LoginScreen(onToggle: toggleAuthMode)
          : SignupScreen(onToggle: toggleAuthMode),
    );
  }
}
