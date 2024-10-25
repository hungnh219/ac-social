import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:social_app/domain/entities/comment.dart';
import 'package:social_app/mixin/methods/convert_timestamp.dart';

class SingleComment extends StatefulWidget {
  SingleComment({super.key, required this.comment});

  CommentModel comment;

  @override
  State<SingleComment> createState() => _SingleCommentState();
}

class _SingleCommentState extends State<SingleComment> with Methods{
  late String timestamp;

  @override
  void initState() {
    super.initState();
    timestamp = calculateTimeFromNow(widget.comment.timestamp);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
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
              child: CircleAvatar(
                backgroundImage: CachedNetworkImageProvider(
                  widget.comment.userAvatar,
                ),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.comment.username),
                  Text(widget.comment.content),
                  Row(
                    children: [
                      Text(timestamp, overflow: TextOverflow.ellipsis,),
                      InkWell(
                        onTap: () {},
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text('Like'),
                        ),
                      ),
                      Spacer(),
                      Text('02'),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.favorite_border),
                      )
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