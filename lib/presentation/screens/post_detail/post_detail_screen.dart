import 'package:flutter/material.dart';
import 'package:social_app/presentation/screens/home/home_screen.dart';
import 'package:social_app/presentation/screens/post_detail/comment_list/comment_list.dart';
import 'package:social_app/presentation/screens/post_detail/post_detail/post_detail.dart';

class PostDetailScreen extends StatelessWidget {
  PostDetailScreen({super.key, required this.post});

  dynamic post;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
                BackButton(),
                ElevatedButton(
                onPressed: () {
                  Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomeScreen(),
                    settings: RouteSettings(name: 'HomeScreen'),
                  ),
                  );
                },
                child: Text('home'),
                ),
              Spacer(),
              IconButton(
                icon: Icon(Icons.favorite_border),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.add_circle_outline),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.ios_share),
                onPressed: () {},
              ),
            ],),
        
            PostDetail(post: post),
        
            Expanded(child: CommentList()),
          ]
        )
      )
    );
  }
}