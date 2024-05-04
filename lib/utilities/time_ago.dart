String timeAgo(String date) {
  DateTime dateTime = DateTime.parse(date);
  DateTime now = DateTime.now();
  Duration difference = now.difference(dateTime);

  if (difference.inSeconds < 60) {
    return '${difference.inSeconds}s';
  } else if (difference.inMinutes < 60) {
    return '${difference.inMinutes}m';
  } else if (difference.inHours < 24) {
    return '${difference.inHours}h';
  } else if (difference.inDays < 30) {
    return '${difference.inDays}d';
  } else if (difference.inDays < 365) {
    int months = difference.inDays ~/ 30;
    return '${months}mo';
  } else {
    int years = difference.inDays ~/ 365;
    return '${years}y';
  }
}