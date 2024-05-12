
import 'package:flutter_test/flutter_test.dart';
import 'package:reddit_bel_ham/utilities/time_ago.dart';

void main() {
  group('timeAgo', () {
    test('should return seconds when difference is less than 1 minute', () {
      String result = timeAgo(DateTime.now().subtract(Duration(seconds: 30)).toString());
      expect(result, '30s');
    });

    test('should return minutes when difference is less than 1 hour', () {
      String result = timeAgo(DateTime.now().subtract(Duration(minutes: 45)).toString());
      expect(result, '45m');
    });

    test('should return hours when difference is less than 1 day', () {
      String result = timeAgo(DateTime.now().subtract(Duration(hours: 12)).toString());
      expect(result, '12h');
    });

    test('should return days when difference is less than 30 days', () {
      String result = timeAgo(DateTime.now().subtract(Duration(days: 15)).toString());
      expect(result, '15d');
    });

    test('should return months when difference is less than 1 year', () {
      String result = timeAgo(DateTime.now().subtract(Duration(days: 90)).toString());
      expect(result, '3mo');
    });

    test('should return years when difference is more than 1 year', () {
      String result = timeAgo(DateTime.now().subtract(Duration(days: 400)).toString());
      expect(result, '1y');
    });
  });
}