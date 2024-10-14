import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_app/data/providers/auth_provider.dart';

class LoginScreen extends StatelessWidget {
  final VoidCallback onToggle;

  LoginScreen({super.key, required this.onToggle});

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void _login(BuildContext context) async {
    // final auth = Provider.of<AuthProvider>(context, listen: false);
    // try {
    //   await auth.signIn(_emailController.text, _passwordController.text);
    // } catch (e) {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     SnackBar(content: Text('Login failed')),
    //   );
    // }

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
            onPressed: onToggle,
            child: const Text("Don't have an account? Sign up"),
          ),
        ],
      ),
    );
  }
}
