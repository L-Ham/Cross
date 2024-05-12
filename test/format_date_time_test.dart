import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reddit_bel_ham/utilities/format_date_time.dart';

void main() {
  group('FormatDate', () {
    test('should format date correctly', () {
      final date = DateTime(2022, 12, 31);
      final formattedDate = formatDate(date);
      expect(formattedDate, 'December 31, 2022');
    });

    test('should format time correctly', () {
      final time = TimeOfDay(hour: 9, minute: 30);
      final formattedTime = formatTime(time);
      expect(formattedTime, '09:30');
    });
  });
}