
import 'package:flutter_test/flutter_test.dart';
import 'package:reddit_bel_ham/utilities/formatNumber.dart';

void main() {
  group('formatNumber', () {
    test('should format number less than 1000 correctly', () {
      expect(formatNumber(500), '500');
      expect(formatNumber(999), '999');
    });

    test('should format number between 1000 and 999999 correctly', () {
      expect(formatNumber(1500), '1.5k');
      expect(formatNumber(500000), '500.0k');
      expect(formatNumber(999999), '1000.0k');
    });

    test('should format number greater than or equal to 1000000 correctly', () {
      expect(formatNumber(1000000), '1.0M');
      expect(formatNumber(1500000), '1.5M');
      expect(formatNumber(5000000), '5.0M');
      expect(formatNumber(9999999), '10.0M');
    });
  });
}