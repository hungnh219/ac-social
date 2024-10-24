import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:social_app/presentation/widgets/navigator_bar.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: () {
      context.go('/signin');
    }, child: Text('signout'));
  }
}