import 'package:social_app/domain/entities/post.dart';

class CollectionModel {
  final String name;
  final List<PostModel> posts;

  CollectionModel( {required this.name, required this.posts,});

  factory CollectionModel.fromMap(Map<String, dynamic> map) {
    return CollectionModel(
      name: map['name'] ?? '',
      posts: [],
    );
  }

  // Method to convert a CollectionModel to a Map (to store in Firestore)
  Map<String, dynamic> toMap() {
    return {
      'name': name,
    };
  }
}
