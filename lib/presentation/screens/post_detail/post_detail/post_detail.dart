import 'package:flutter/material.dart';

class PostDetail extends StatelessWidget {
  PostDetail({super.key, required this.post});

  dynamic post;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PostUserInfo(post: post),
        PostImage(post: post),
        PostStatsBar(),
        PostContent(),
      ],
    );
  }
}

class PostUserInfo extends StatelessWidget {
  PostUserInfo({super.key, required this.post});

  dynamic post;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: CircleAvatar(),
          ),
          Text(post['user_id']),
          Spacer(),
          Text(post['timestamp'].toString()),
        ],
      ),
    );
  }
}

class PostImage extends StatelessWidget {
  PostImage({super.key, required this.post});

  dynamic post;

  @override
  Widget build(BuildContext context) {
    return Image.network(post['image']);
  }
}

class PostStatsBar extends StatelessWidget {
  const PostStatsBar({super.key});

  // dynamic post;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            children: [
              Text('219'),
              IconButton(
                icon: Icon(Icons.favorite),
                onPressed: () {},
              ),
            ],
          ),
          Row(
            children: [
              Text('219'),
              IconButton(
                icon: Icon(Icons.comment),
                onPressed: () {},
              ),
            ],
          ),
          Row(
            children: [
              Text('219'),
              IconButton(
                icon: Icon(Icons.share),
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class PostContent extends StatelessWidget {
  const PostContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.all(16.0), child: Text('post content'));
  }
}