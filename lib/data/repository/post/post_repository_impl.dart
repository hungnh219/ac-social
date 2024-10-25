import 'dart:io';

import 'package:social_app/data/sources/firestore/firestore_service.dart';
import 'package:social_app/domain/entities/comment.dart';
import 'package:social_app/domain/entities/post.dart';
import 'package:social_app/domain/repository/post/post_repository.dart';
import 'package:social_app/service_locator.dart';

class PostRepositoryImpl extends PostRepository {
  @override
  Future<List<PostModel>?>? getPostsData() {
    return serviceLocator.get<FirestoreService>().getPostsData();
  }

  @override
  Future<List<CommentModel>?> getCommentPost(PostModel post) {
    return serviceLocator.get<FirestoreService>().getCommentPost(post);
  }

  @override
  Future<void> createPost(String content, File image) {
    return serviceLocator.get<FirestoreService>().createPost(content, image);
  }

  Future<List<PostModel>?> getPostsByUserId(String userId){
    return serviceLocator.get<FirestoreService>().getPostsByUserId(userId);
  }

  @override
  Future<String?> getPostImageById(String postId){
    return serviceLocator.get<FirestoreService>().getPostImageById(postId);
  }
}