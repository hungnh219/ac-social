import 'package:flutter/material.dart';
import 'package:social_app/domain/entities/post.dart';
import 'package:social_app/domain/repository/post/post_repository.dart';
import 'package:social_app/presentation/screens/comment/widgets/single_comment.dart';
import 'package:social_app/presentation/screens/post_detail/post_detail/post_detail.dart';
import 'package:social_app/presentation/screens/post_detail/post_detail_screen.dart';
import 'package:social_app/service_locator.dart';
import 'package:social_app/utils/styles/colors.dart';

class CommentScreen extends StatelessWidget {
  CommentScreen({super.key, required this.post});

  PostModel post;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Container(
              height: 40,
              color: AppColors.lavenderBlueShadow,
              child: Stack(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,  
                    children: [
                      IconButton(
                        onPressed: () {
                     
                        },
                        icon: const Icon(Icons.arrow_back, color: AppColors.white,),
                      ),
                      
                      IconButton(onPressed: () {}, icon: Icon(Icons.flag_outlined))
                    ],
                  ),
                
                  Positioned(
                    left: 0,
                    right: 0,
                    top: 0,
                    bottom: 0,
                    child: SizedBox(
                      child: Center(
                        child: Text(
                          'Comments',
                          style: TextStyle(color: AppColors.white, fontSize: 16, fontWeight: FontWeight.bold)
                        ),
                      ),
                    )
                  ),
                ]    
              ),
            ),

            Expanded(
              child: FutureBuilder(
                future: serviceLocator<PostRepository>().getCommentPost(post),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }

                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text('No comments available'));
                  }
                  
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: SingleComment(comment: snapshot.data![index]),
                      );
                    }
                  );
                }
              )
            )
          ],
        )
      )
    );
  }
}
