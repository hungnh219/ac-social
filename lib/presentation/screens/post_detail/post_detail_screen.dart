import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:social_app/domain/entities/post.dart';
import 'package:social_app/domain/repository/post/post_repository.dart';
import 'package:social_app/presentation/screens/home/home_screen.dart';
import 'package:social_app/presentation/screens/post_detail/comment_list/comment_list.dart';
import 'package:social_app/presentation/screens/post_detail/post_detail/post_detail.dart';
import 'package:social_app/presentation/widgets/add_collection_icon.dart';
import 'package:social_app/service_locator.dart';

class PostDetailScreen extends StatelessWidget {
  PostDetailScreen({super.key, required this.post});

  PostModel post;
 
  // CollectionReference<Map<String, dynamic>> postCollection = FirebaseFirestore.instance.collection('NewPost').doc('');
  
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
              BackButton(
                color: Colors.black,
              ),
                
              Spacer(),
              AddCollectionIcon()
            ],),
        
            PostDetail(post: post),
        
            FutureBuilder(
              future: serviceLocator<PostRepository>().getCommentPost(post),
              builder: (context, snapshot) {
                return Text('hehe');
              }
            )
          ]
        )
      )
    );
  }
}
