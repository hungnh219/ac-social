import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:social_app/domain/entities/post.dart';
import 'package:social_app/presentation/screens/post_detail/post_detail_screen.dart';
import 'package:social_app/presentation/widgets/add_collection_icon.dart';
import 'package:social_app/utils/styles/colors.dart';

class PostCustom extends StatelessWidget {
  PostCustom({super.key, required this.post});

  PostModel post;
  // dynamic commentPostCollection;
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
                post.image,
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
                  AddCollectionIcon(),
                  Spacer(),

                  Text(post.commentAmount.toString()),
                  IconButton(
                    icon: Icon(Icons.comment_outlined, color: Colors.red,),
                    onPressed: () {},
                  ),

                  SizedBox(width: 8),

                  Text(post.likeAmount.toString()),
                  IconButton(
                    icon: Icon(Icons.favorite_border, color: Colors.red,),
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

  PostModel post;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          // direction: Axis.horizontal,
          // direction: Axis.horizontal,
          // runAlignment: WrapAlignment.spaceBetween,
          children: [
            // Flex()
            CircleAvatar(
              radius: 16,
              backgroundImage: NetworkImage(post.userAvatar),
            ),
            const SizedBox(width: 8),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.4,
              child: Text(post.username * 3, overflow: TextOverflow.ellipsis,),),
            // Spacer(),  
            Spacer(),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.2,
              child: Text('fdsfdsffdsfdsfdsfsfsfs' * 3, overflow: TextOverflow.ellipsis,),
            ),
          // Text(post['user_id'].toString()),
        ],),
      ),
    );
  }
}