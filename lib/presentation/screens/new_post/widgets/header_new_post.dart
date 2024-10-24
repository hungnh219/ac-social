import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/presentation/screens/new_post/cubit/post_cubit.dart';

class HeaderNewPost extends StatelessWidget {
  const HeaderNewPost({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      color: Colors.amberAccent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () {

              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back),
          ),

          Expanded(
            child: Center(
              child: Text('Create post', textAlign: TextAlign.center),
            ),
          ),

          TextButton(
            onPressed: () {},
            child: const Text('Post'),
          ),
        ],
      ),
    );
  }
}