import 'package:cloud_firestore/cloud_firestore.dart';
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
        PostContent(post: post),
      ],
    );
  }
}

class PostUserInfo extends StatelessWidget {
  PostUserInfo({super.key, required this.post});

  dynamic post;
  DateTime now = DateTime.now();
  String readTimestamp(int timestamp) {
    var now = DateTime.now();
    // var format = DateFormat('HH:mm a');
    var date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    var diff = now.difference(date);
    var time = '';

    if (diff.inSeconds <= 0 || diff.inSeconds > 0 && diff.inMinutes == 0 || diff.inMinutes > 0 && diff.inHours == 0 || diff.inHours > 0 && diff.inDays == 0) {
      // time = format.format(date);
    } else if (diff.inDays > 0 && diff.inDays < 7) {
      if (diff.inDays == 1) {
        time = diff.inDays.toString() + ' DAY AGO';
      } else {
        time = diff.inDays.toString() + ' DAYS AGO';
      }
    } else {
      if (diff.inDays == 7) {
        time = (diff.inDays / 7).floor().toString() + ' WEEK AGO';
      } else {

        time = (diff.inDays / 7).floor().toString() + ' WEEKS AGO';
      }
    }

    return time;
  }

  @override
  Widget build(BuildContext context) {
    DateTime date = (post['timestamp'] as Timestamp).toDate();
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: CircleAvatar(),
              ),
              Text(post['content']),
              Spacer(),
              Text((post['timestamp'] as Timestamp).toDate().toString()),
            ],
          ),
          Text(now.toString()),
          Text(now.difference(date).inMinutes.toString()),
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
  PostContent({super.key, this.post});

  dynamic post;
  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.all(16.0), child: Text(post['content']));
  }
}