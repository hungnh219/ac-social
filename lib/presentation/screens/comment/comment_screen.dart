import 'package:flutter/material.dart';

class CommentScreen extends StatelessWidget {
  const CommentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [BackButton(), Text('comment screen')],
        ),
      )
    );
  }
}
