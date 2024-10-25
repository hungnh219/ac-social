import 'dart:io';

import 'package:social_app/domain/entities/comment.dart';
import 'package:social_app/domain/entities/post.dart';

abstract class PostRepository {
  Future<List<PostModel>?>? getPostsData();

  Future<List<CommentModel>?> getCommentPost(PostModel post);

  Future<List<PostModel>?> getPostsByUserId(String userId);

  Future<void> createPost(String content, File image);

  Future<String?> getPostImageById(String postId);
  // Future<
  // Future<void> addPostData(AddPostReq addPostReq);

  // Future<void> updatePostData(UpdatePostReq updatePostReq);
}