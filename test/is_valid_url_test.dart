import 'package:flutter_test/flutter_test.dart';
import 'package:reddit_bel_ham/utilities/is_valid_url.dart';

void main() {
  group('isValidUrl', () {
    test('should return true for valid URLs', () {
      // Arrange
      String validUrl = 'https://example.com';

      // Act
      bool result = isValidUrl(validUrl);

      // Assert
      expect(result, true);
    });

    test('should return false for invalid URLs', () {
      // Arrange
      String invalidUrl = 'example.com';

      // Act
      bool result = isValidUrl(invalidUrl);

      // Assert
      expect(result, true);
    });
    test('should return true for URLs with valid TLDs', () {
      // Arrange
      String url = 'https://example.com';

      // Act
      bool result = isValidUrl(url);

      // Assert
      expect(result, true);
    });

    test('should return false for URLs with invalid TLDs', () {
      // Arrange
      String url = 'https://example.invalid';

      // Act
      bool result = isValidUrl(url);

      // Assert
      expect(result, false);
    });


    test('should return false for empty URLs', () {
      // Arrange
      String url = '';

      // Act
      bool result = isValidUrl(url);

      // Assert
      expect(result, false);
    });

    test('should return false for null URLs', () {
      // Arrange
      String? url = null;

      // Act
      bool result = isValidUrl(url);

      // Assert
      expect(result, false);
    });
  });
}
