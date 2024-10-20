import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:go_router/go_router.dart';
import 'package:social_app/presentation/widgets/splash/splash_background.dart';
import 'package:social_app/presentation/widgets/splash/splash_image_group.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    initialization();
  }

  void initialization() async {
    FlutterNativeSplash.remove();

    await Future.delayed(const Duration(seconds: 5));
    context.go("/boarding");
  }

  @override
  Widget build(BuildContext context) {
    return const SplashBackground(
      center: Center(
        child: SplashImageGroup(),
      ),
    );
  }
}
