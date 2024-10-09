// main.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:social_app/data/services/firebase_auth_service.dart';
import 'package:social_app/data/providers/auth_provider.dart';
import 'package:social_app/presentation/screens/auth/auth_screen.dart';
import 'package:social_app/presentation/screens/log_in/log_in_screen.dart';
import 'package:social_app/presentation/screens/home/home_screen.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        Provider<AuthService>(create: (_) => AuthService()),
        ChangeNotifierProxyProvider<AuthService, AuthProvider>(
          create: (context) => AuthProvider(context.read<AuthService>()),
          update: (_, authService, authProvider) => AuthProvider(authService),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firebase Auth App',
      home: Consumer<AuthProvider>(
        builder: (ctx, auth, _) => auth.isSignedIn ? const HomeScreen() : const AuthScreen(),
      ),
    );
  }
}