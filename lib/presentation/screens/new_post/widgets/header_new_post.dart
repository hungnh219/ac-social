import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:social_app/data/sources/firestore/firestore_service.dart';
import 'package:social_app/presentation/screens/new_post/cubit/post_cubit.dart';
import 'package:social_app/presentation/screens/new_post/cubit/post_state.dart';
import 'package:social_app/service_locator.dart';

class HeaderNewPost extends StatefulWidget {
  const HeaderNewPost({super.key});

  @override
  State<HeaderNewPost> createState() => _HeaderNewPostState();
}

class _HeaderNewPostState extends State<HeaderNewPost> {
  late PostCubit _postCubit;

  @override
  void initState() {
    super.initState();
    _postCubit = context.read<PostCubit>();
  }

  Future _uploadPost() async {
    PostState state = _postCubit.state;
    File? image;
    if (state is PostWithImage) {
      // print('image: ${state.getImage}');
      image = state.getImage;
    }

    if (image != null) {
      await serviceLocator<FirestoreService>().createPost('create new post from ui', image);
    }

    Navigator.pop(context);
  }

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
              // context.go('/signin/navigator');
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
            onPressed: () {
              _uploadPost();
            },
            child: const Text('Post'),
          ),
        ],
      ),
    );
  }
}