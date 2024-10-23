import 'package:social_app/data/sources/firestore/firestore_service.dart';
import 'package:social_app/domain/entities/post.dart';
import 'package:social_app/domain/repository/post/post_repository.dart';
import 'package:social_app/service_locator.dart';

class PostRepositoryImpl extends PostRepository {
  @override
  Future<List<PostModel>?>? getPostsData() {
    return serviceLocator.get<FirestoreService>().getPostsData();
  }
}