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
    String? content;

    if (state is PostWithData) {
      // print('image: ${state.getImage}');
      image = state.getImage;
      content = state.getContent;
      if (content == null) {
        content = '';
      }
    }

    if (image != null) {
      print('image: $image');
      print('content: $content');
      // await serviceLocator<FirestoreService>().createPost(content!, image);
    }

    _postCubit.closeNewPost();

    context.go('/signin/navigator');
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
              _postCubit.closeNewPost();
              context.go('/signin/navigator');
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