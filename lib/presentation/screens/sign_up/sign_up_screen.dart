import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_app/data/providers/auth_provider.dart';

class SignupScreen extends StatelessWidget {
  final VoidCallback onToggle;

  SignupScreen({super.key, required this.onToggle});

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  void _signup(BuildContext context) async {
    final auth = Provider.of<AuthProvider>(context, listen: false);

    if (_passwordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Passwords do not match')),
      );
      return;
    }

    try {
      await auth.signUp(_emailController.text, _passwordController.text);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Sign-up failed')),
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
            onPressed: onToggle,
            child: const Text('Already have an account? Login'),
          ),
        ],
      ),
    );
  }
}
