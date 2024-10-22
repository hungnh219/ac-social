import 'package:social_app/domain/entities/post.dart';

abstract class PostRepository {
  Future<List<PostModel>?>? getPostsData();

  // Future<void> addPostData(AddPostReq addPostReq);

  // Future<void> updatePostData(UpdatePostReq updatePostReq);
}