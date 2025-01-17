import 'package:flutter/material.dart';
import 'package:social_app/domain/entities/comment.dart';
import 'package:social_app/domain/entities/post.dart';

class CommentList extends StatelessWidget {
  CommentList({super.key, required this.comments});

  List<CommentModel>? comments;
  
  @override
  Widget build(BuildContext context) {
    return comments == null ? Center(child: Text('No comments')) :
      ListView.builder(
      itemBuilder: (context, index) {
        return Text('213');
      },
      itemCount: comments!.length,
    );
  }
}

class UserComment extends StatelessWidget {
  const UserComment({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 108,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: CircleAvatar(),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('username'),
                  Text('comment'),
                  Row(
                    children: [
                      Text('timestamp'),
                      InkWell(
                        onTap: () {},
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text('like'),
                        ),
                      ),
                      Spacer(),
                      Text('02'),
                      IconButton(
                        icon: Icon(Icons.favorite_border),
                        onPressed: () {},
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}