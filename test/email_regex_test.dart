import 'package:flutter_test/flutter_test.dart';
import 'package:reddit_bel_ham/utilities/email_regex.dart';

void main() {
  group('EmailRegex', () {
    test('should return true for a valid email', () {
      // Arrange
      final email = 'test@example.com';

      // Act
      final result = isEmailValid(email);

      // Assert
      expect(result, true);
    });

    test('should return false for an invalid email', () {
      // Arrange
      final email = 'invalid_email';

      // Act
      final result = isEmailValid(email);

      // Assert
      expect(result, false);
    });

    test('should return false for an empty email', () {
      // Arrange
      final email = '';

      // Act
      final result = isEmailValid(email);

      // Assert
      expect(result, false);
    });

    test('should return false for an email without domain', () {
      // Arrange
      final email = 'test';

      // Act
      final result = isEmailValid(email);

      // Assert
      expect(result, false);
    });

    test('should return false for an email without username', () {
      // Arrange
      final email = '@example.com';

      // Act
      final result = isEmailValid(email);

      // Assert
      expect(result, false);
    });

    test('should return false for an email with multiple @ symbols', () {
      // Arrange
      final email = 'test@example@com';

      // Act
      final result = isEmailValid(email);

      // Assert
      expect(result, false);
    });

    test('should return false for an email with invalid characters', () {
      // Arrange
      final email = 'test!@example.com';

      // Act
      final result = isEmailValid(email);

      // Assert
      expect(result, false);
    });
  });
}
