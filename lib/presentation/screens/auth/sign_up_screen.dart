import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_app/data/models/auth/create_user_req.dart';

import '../../../domain/repository/auth/auth.dart';
import '../../../service_locator.dart';
import 'log_in_screen.dart';

class SignUpScreen extends StatelessWidget {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  SignUpScreen({super.key});

  void _signup(BuildContext context) async {

    if (_passwordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Passwords do not match')),
      );
      return;
    }

    try {
      await serviceLocator<AuthRepository>().signUp(SignUpUserReq(email: _emailController.text, password:  _passwordController.text));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Sign-up failed')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Padding(
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
            TextField(
              controller: _confirmPasswordController,
              decoration: const InputDecoration(labelText: 'Confirm Password'),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _signup(context),
              child: const Text('Sign Up'),
            ),
            TextButton(
              onPressed: (){ Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => LogInScreen()
                  )
              );},
              child: const Text('Already have an account? Login'),
            ),
          ],
        ),
      ),
    );
  }
}
