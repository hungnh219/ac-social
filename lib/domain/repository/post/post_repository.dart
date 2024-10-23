import 'package:social_app/domain/entities/comment.dart';
import 'package:social_app/domain/entities/post.dart';

abstract class PostRepository {
  Future<List<PostModel>?>? getPostsData();

  Future<List<CommentModel>?> getCommentPost(PostModel post);
  // Future<
  // Future<void> addPostData(AddPostReq addPostReq);

  // Future<void> updatePostData(UpdatePostReq updatePostReq);
}