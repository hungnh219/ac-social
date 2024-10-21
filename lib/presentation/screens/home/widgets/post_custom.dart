import 'package:flutter/material.dart';
import 'package:social_app/presentation/screens/post_detail/post_detail_screen.dart';
import 'package:social_app/utils/styles/colors.dart';

class PostCustom extends StatelessWidget {
  PostCustom({super.key, required this.post});

  dynamic post;
  @override
  Widget build(BuildContext context) {

    // print(post['user_id'].runtimeType);
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
      child: Container(
        height: 320,
        // color: Colors.grey[200],
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: AppColors.white,
        ),
        child: Column(
          children: [
            PostInfo(post: post,),
            // Image.network('https://via.placeholder.com/150'),
            InkWell(
              onTap: () {
                // Navigator.pushNamed(context, '/post-detail');
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PostDetailScreen(post: post)
                ));
              },
              child: Image.network(
                post['image'],
                width: double.infinity,
                height: 220,
                fit: BoxFit.cover,
              ),
            ),
            // Text(post['user_id'].toString()),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(Icons.thumb_up_alt_outlined),
                    onPressed: () {},
                  ),
                  Spacer(),
                  IconButton(
                    icon: Icon(Icons.comment_outlined),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Icon(Icons.favorite_border),
                    onPressed: () {},
                  ),
                ],
              ),
            )
          ],
        ),
      )
    );
  }
}

class PostInfo extends StatelessWidget {
  PostInfo({super.key, required this.post});
  dynamic post;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(children: [
          const CircleAvatar(
            radius: 16,
            backgroundImage: NetworkImage('https://via.placeholder.com/150'),
          ),
          const SizedBox(width: 8),
          // Text(post['username']),
          // Text(post['content'], style: TextStyle(
          //   overflow: TextOverflow.fade
          // ),),
          Spacer(),
          Text('hehehe'),
          // Text(post['user_id'].toString()),
        ],),
      ),
    );
  }
}