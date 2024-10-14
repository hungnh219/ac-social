import 'package:flutter/material.dart';
import 'package:social_app/utils/styles/colors.dart';

class PostCustom extends StatelessWidget {
  PostCustom({super.key, required this.post});

  dynamic post;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
      child: Container(
        height: 320,
        // color: Colors.grey[200],
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: AppColors.white,
        ),
        child: Column(
          children: [
            PostInfo(post: post,),
            Image.network('https://via.placeholder.com/150'),
          ],
        ),
      )
    );
  }
}

class PostInfo extends StatelessWidget {
  PostInfo({super.key, required this.post});
  dynamic post;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(children: [
          const CircleAvatar(
            radius: 16,
            backgroundImage: NetworkImage('https://via.placeholder.com/150'),
          ),
          const SizedBox(width: 8),
          Text(post['username']),
          Spacer(),
          Text(post['timestamp']),
        ],),
      ),
    );
  }
}