import 'package:flutter/material.dart';
import 'package:social_app/data/models/auth/sign_in_user_req.dart';
import 'package:social_app/presentation/screens/auth/sign_up_screen.dart';
import 'package:social_app/service_locator.dart';

import '../../../domain/repository/auth/auth.dart';

class LogInScreen extends StatelessWidget {

  LogInScreen({super.key});

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void _login(BuildContext context) async {
    try {
      await serviceLocator<AuthRepository>().signInWithEmailAndPassword(
          SignInUserReq(email: _emailController.text, password: _passwordController.text));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Login failed')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            controller: _emailController,
            decoration: const InputDecoration(labelText: 'Email'),
          ),
          TextField(
            controller: _passwordController,
            decoration: const InputDecoration(labelText: 'Password'),
            obscureText: true,
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => _login(context),
            child: const Text('Login'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => SignUpScreen()
                  )
              );
            },
            child: const Text("Don't have an account? Sign up"),
          ),
        ],
      ),
    );
  }
}
