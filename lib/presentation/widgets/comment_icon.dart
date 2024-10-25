import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:social_app/config/routes/app_routes.dart';
import 'package:social_app/utils/styles/colors.dart';

class CommentIcon extends StatelessWidget {
  const CommentIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(onPressed: () {
      context.go('/signin/comment');
    }, icon: Icon(Icons.comment_outlined, color: AppColors.carbon,));
  }
}