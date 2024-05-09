Duration parseDuration(String duration) {
  int value = int.parse(duration.substring(0, duration.length - 1));
  String unit = duration.substring(duration.length - 1);

  switch (unit) {
    case 's':
      return Duration(seconds: value);
    case 'm':
      return Duration(minutes: value);
    case 'h':
      return Duration(hours: value);
    case 'd':
      return Duration(days: value);
    case 'w':
      return Duration(days: value * 7);
    case 'mo':
      return Duration(days: value * 30);
    case 'y':
      return Duration(days: value * 365);
    default:
      throw FormatException('Unknown duration unit $unit');
  }
}