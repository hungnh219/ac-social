import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/presentation/screens/new_post/cubit/post_cubit.dart';
import 'package:social_app/presentation/screens/new_post/cubit/post_state.dart';
import 'package:social_app/presentation/screens/new_post/widgets/action_post.dart';

class PostContent extends StatefulWidget {
  const PostContent({super.key});

  @override
  State<PostContent> createState() => _PostContentState();
}

class _PostContentState extends State<PostContent> {
  late PostCubit postCubit;

  @override
  void initState() {
    super.initState();
    postCubit = context.read<PostCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const TextField(
          maxLines: null,
          decoration: InputDecoration(
            hintText: 'What\'s on your mind?',
          ),
        ),
        BlocBuilder<PostCubit, PostState>(
          builder: (context, state) {
            if (state is PostWithImage) {
              return Image.file(state.image);
            } else {
              return Image.asset('assets/images/appscyclone.png');
            }
          }
        ),
        // const SizedBox(height: 8),
        // ActionPost(),
      ],
    );
  }
}