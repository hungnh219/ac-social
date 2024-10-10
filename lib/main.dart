// main.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:social_app/firebase_options.dart';
import 'package:social_app/presentation/screens/auth/auth_screen.dart';
import 'package:social_app/presentation/screens/auth/log_in_screen.dart';
import 'package:social_app/presentation/screens/home/home_screen.dart';
import 'package:social_app/service_locator.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  initializeDependencies();

  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firebase Auth App',
      home : const AuthScreen(),
    );
  }
}