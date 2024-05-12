import 'package:flutter_test/flutter_test.dart';
import 'package:reddit_bel_ham/utilities/parse_duration.dart';

void main() {
  test('should parse seconds correctly', () {
    expect(parseDuration('10s'), equals(Duration(seconds: 10)));
  });

  test('should parse minutes correctly', () {
    expect(parseDuration('5m'), equals(Duration(minutes: 5)));
  });

  test('should parse hours correctly', () {
    expect(parseDuration('2h'), equals(Duration(hours: 2)));
  });

  test('should parse days correctly', () {
    expect(parseDuration('3d'), equals(Duration(days: 3)));
  });

  test('should parse weeks correctly', () {
    expect(parseDuration('2w'), equals(Duration(days: 14)));
  });

  test('should parse months correctly', () {
    expect(parseDuration('6mo'), equals(Duration(days: 180)));
  });

  test('should parse years correctly', () {
    expect(parseDuration('1y'), equals(Duration(days: 365)));
  });

  test('should throw FormatException for unknown duration unit', () {
    expect(() => parseDuration('10x'), throwsA(isA<FormatException>()));
  });
}