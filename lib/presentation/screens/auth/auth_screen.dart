import 'package:flutter/material.dart';
import 'package:social_app/presentation/screens/auth/sign_up_screen.dart';
import 'package:social_app/presentation/screens/home/home_screen.dart';
import 'log_in_screen.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => AuthScreenState();
}

class AuthScreenState extends State<AuthScreen> {
  bool _isLogin = false;

  void toggleAuthMode() {
    setState(() => _isLogin = !_isLogin);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_isLogin ? 'Login' : 'Sign Up')),
      body: !_isLogin
          ? SignUpScreen()
          : const HomeScreen(),
    );
  }
}
