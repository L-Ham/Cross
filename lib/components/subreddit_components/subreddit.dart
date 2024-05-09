class Subreddit {
  String name;
  String description;
  String avatarImage;
  String bannerImage;
  String followersCount;
  String onlineCount;
  String link;
  bool isMuted;
  bool isJoined;
  String onlineNickname;
  String id;

  Subreddit({
    required this.name,
    required this.description,
    required this.avatarImage,
    required this.bannerImage,
    required this.followersCount,
    required this.onlineCount,
    required this.link,
    required this.isMuted,
    required this.isJoined,
    required this.onlineNickname,
    required this.id,
  });
}
