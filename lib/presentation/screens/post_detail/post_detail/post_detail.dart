import 'package:flutter/material.dart';

class PostDetail extends StatelessWidget {
  const PostDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PostUserInfo(),
        PostImage(),
        PostStatsBar(),
        PostContent(),
      ],
    );
  }
}

class PostUserInfo extends StatelessWidget {
  const PostUserInfo({super.key});

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
          Text('username'),
          Spacer(),
          Text('timestamp'),
        ],
      ),
    );
  }
}

class PostImage extends StatelessWidget {
  const PostImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset('assets/images/appscyclone.png');
  }
}

class PostStatsBar extends StatelessWidget {
  const PostStatsBar({super.key});

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