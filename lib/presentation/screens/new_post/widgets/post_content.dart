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
  late PostCubit _postCubit;
  late TextEditingController _textController;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController();
    _postCubit = context.read<PostCubit>();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: _textController,
          maxLines: null,
          decoration: InputDecoration(
            hintText: 'What\'s on your mind?',
          ),
          onChanged: (value) {
            // _postCubit.createPost(content: value);
            _postCubit.updateContent(value.isEmpty ? null : value);
          },
        ),
        BlocBuilder<PostCubit, PostState>(
          builder: (context, state) {
            print('state: $state');
            if (state is PostWithData) {
              if (state.getImage != null) {
                print('check 1');
                return Image.file(state.getImage!);
              } else {
                print('check 2');
                return const SizedBox.shrink();
              }
            } else {
                print('check 3');
              return const SizedBox.shrink();
            }
          }
        ),
      ],
    );
  }
}