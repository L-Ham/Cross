
import 'package:flutter_test/flutter_test.dart';
import 'package:reddit_bel_ham/utilities/format_duration.dart';

void main() {
  group('formatDuration', () {
    test('should return years when duration is greater than or equal to 365 days', () {
      expect(formatDuration(Duration(days: 365)), '1y');
      expect(formatDuration(Duration(days: 730)), '2y');
      expect(formatDuration(Duration(days: 1095)), '3y');
    });

    test('should return months when duration is greater than or equal to 30 days', () {
      expect(formatDuration(Duration(days: 30)), '1mo');
      expect(formatDuration(Duration(days: 60)), '2mo');
      expect(formatDuration(Duration(days: 90)), '3mo');
    });

    test('should return days when duration is greater than or equal to 1 day', () {
      expect(formatDuration(Duration(days: 1)), '1d');
      expect(formatDuration(Duration(days: 2)), '2d');
      expect(formatDuration(Duration(days: 3)), '3d');
    });

    test('should return hours when duration is greater than or equal to 1 hour', () {
      expect(formatDuration(Duration(hours: 1)), '1h');
      expect(formatDuration(Duration(hours: 2)), '2h');
      expect(formatDuration(Duration(hours: 3)), '3h');
    });

    test('should return minutes when duration is greater than or equal to 1 minute', () {
      expect(formatDuration(Duration(minutes: 1)), '1m');
      expect(formatDuration(Duration(minutes: 2)), '2m');
      expect(formatDuration(Duration(minutes: 3)), '3m');
    });

    test('should return seconds when duration is less than 1 minute', () {
      expect(formatDuration(Duration(seconds: 1)), '1s');
      expect(formatDuration(Duration(seconds: 2)), '2s');
      expect(formatDuration(Duration(seconds: 3)), '3s');
    });
  });
}