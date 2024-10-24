class PostModel {
  final String postId;
  final String username;
  final String userAvatar;
  final String content;
  final String image;
  final DateTime timestamp;
  final int likeAmount;
  final int commentAmount;
  final int viewAmount;
  final Map<String, dynamic>? comments;
  final Map<String, dynamic>? likes;
  final Map<String, dynamic>? views;

  PostModel({
    required this.postId,
    required this.username,
    required this.userAvatar,
    required this.content,
    required this.likeAmount,
    required this.commentAmount,
    required this.viewAmount,
    required this.image,
    required this.timestamp,
    required this.comments,
    required this.likes,
    required this.views,
  });

  factory PostModel.newPost({
    required String postId,
    required String username,
    required String userAvatar,
    required String content,
    required String image,
    required DateTime timestamp,
  }) {
    return PostModel(
      postId: postId,
      username: username,
      userAvatar: userAvatar,
      content: content,
      image: image,
      timestamp: timestamp,
      likeAmount: 0,
      commentAmount: 0,
      viewAmount: 0,
      comments: {},
      likes: {},
      views: {},
    );
  }
  // factory PostModel.fromJson(Map<String, dynamic> json) {
  //   return PostModel(
  //     username: json['userId'],
  //     content: json['content'],
  //     image: json['imageUrl'],
  //     timestamp: json['timestamp'],
  //     comments: json['comments'] ?? {},
  //     likes: json['likes'] ?? {},
  //     views: json['views'] ?? {},
  //   );
  // }

  // Map<String, dynamic> toJson() {
  //   return {
  //     'userId': userId,
  //     'content': content,
  //     'imageUrl': image,
  //     'timestamp': timestamp,
  //     'comments': comments,
  //     'likes': likes,
  //     'views': views,
  //   };
  // }
}