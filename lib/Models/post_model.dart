class PostModel {
  final String username;
  final String imageUrl;
  final String caption;
  final int likes;
  final int comments;
  final String timeAgo;

  PostModel({
    required this.username,
    required this.imageUrl,
    required this.caption,
    required this.likes,
    required this.comments,
    required this.timeAgo,
  });
}
