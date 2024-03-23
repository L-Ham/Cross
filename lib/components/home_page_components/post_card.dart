class Post {
  final String username;
  final String content;
  final String contentTitle;
  int upvotes;
  int comments;
  bool isUpvoted = false;
  bool isDownvoted = false;

  Post({
    required this.username,
    required this.contentTitle,
    required this.content,
    required this.upvotes,
    required this.comments,
  });
}