class CommentModel {
  final String userId;
  final String content;
  final DateTime timestamp;
  final Map<String, dynamic>? likes;

  CommentModel({
    required this.userId,
    required this.content,
    required this.timestamp,
    required this.likes,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      userId: json['userId'],
      content: json['content'],
      timestamp: DateTime.parse(json['timestamp']),
      likes: json['likes'] ?? {},
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'content': content,
      'timestamp': timestamp.toIso8601String(),
      'likes': likes,
    };
  }
}