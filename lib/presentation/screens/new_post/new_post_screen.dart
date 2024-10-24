import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:social_app/presentation/screens/new_post/cubit/post_cubit.dart';
import 'package:social_app/presentation/screens/new_post/widgets/action_post.dart';
import 'package:social_app/presentation/screens/new_post/widgets/header_new_post.dart';
import 'package:social_app/presentation/screens/new_post/widgets/post_content.dart';
// import 'package:social_app/presentation/screens/post_detail/post_detail/post_detail.dart';

class NewPostScreen extends StatefulWidget {
  const NewPostScreen({super.key});

  @override
  State<NewPostScreen> createState() => _NewPostScreenState();
}

class _NewPostScreenState extends State<NewPostScreen> {
  late PostCubit postCubit;

  @override
  void initState() {
    super.initState();
    postCubit = PostCubit();
  }

  @override
  void dispose() {
    postCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Column(
              children: [
                HeaderNewPost(),
                Expanded(
                  child: PostContent()
                ),
              ],
            ),
            Positioned(
              bottom: 100,
              left: MediaQuery.of(context).size.width / 2 - 60,
              child: Center(
                child: Container(
                  color: Colors.amber,
                  width: 120,
                  child: ActionPost(),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}