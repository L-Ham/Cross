String formatDuration(Duration duration) {
  if (duration.inDays >= 365) {
    return '${duration.inDays ~/ 365}y';
  } else if (duration.inDays >= 30) {
    return '${duration.inDays ~/ 30}mo';
  } else if (duration.inDays >= 1) {
    return '${duration.inDays}d';
  } else if (duration.inHours >= 1) {
    return '${duration.inHours}h';
  } else if (duration.inMinutes >= 1) {
    return '${duration.inMinutes}m';
  } else {
    return '${duration.inSeconds}s';
  }
}