import 'package:flutter_test/flutter_test.dart';
import 'package:reddit_bel_ham/utilities/change_password_utils.dart';

void main() {
  group('ChangePasswordUtils', () {
    test('doPasswordsMatch should return true when passwords match', () {
      // Arrange
      final newPassword = 'password123';
      final confirmPassword = 'password123';

      // Act
      final result = doPasswordsMatch(newPassword, confirmPassword);

      // Assert
      expect(result, true);
    });

    test('doPasswordsMatch should return false when passwords do not match', () {
      // Arrange
      final newPassword = 'password123';
      final confirmPassword = 'differentPassword';

      // Act
      final result = doPasswordsMatch(newPassword, confirmPassword);

      // Assert
      expect(result, false);
    });

    test('isNewPasswordValid should return true when password length is at least 8', () {
      // Arrange
      final newPassword = 'password123';

      // Act
      final result = isNewPasswordValid(newPassword);

      // Assert
      expect(result, true);
    });

    test('isNewPasswordValid should return false when password length is less than 8', () {
      // Arrange
      final newPassword = 'pass';

      // Act
      final result = isNewPasswordValid(newPassword);

      // Assert
      expect(result, false);
    });

    test('isEmpty should return true when any of the password fields is empty', () {
      // Arrange
      final currentPass = 'currentPassword';
      final newPass = '';
      final confirmPass = 'confirmPassword';

      // Act
      final result = isAnyFieldEmpty(currentPass, newPass, confirmPass);

      // Assert
      expect(result, true);
    });

    test('isEmpty should return false when all password fields are not empty', () {
      // Arrange
      final currentPass = 'currentPassword';
      final newPass = 'newPassword';
      final confirmPass = 'newPassword';

      // Act
      final result = isAnyFieldEmpty(currentPass, newPass, confirmPass);

      // Assert
      expect(result, false);
    });

    test('doPasswordsMatch should return false when newPassword is null', () {
      // Arrange
      final newPassword = null;
      final confirmPassword = 'password123';

      // Act
      final result = doPasswordsMatch(newPassword, confirmPassword);

      // Assert
      expect(result, false);
    });

    test('isNewPasswordValid should return false when newPassword is null', () {
      // Arrange
      final newPassword = null;

      // Act
      final result = isNewPasswordValid(newPassword);

      // Assert
      expect(result, false);
    });

    test('isEmpty should return true when all password fields are null', () {
      // Arrange
      final currentPass = null;
      final newPass = null;
      final confirmPass = null;

      // Act
      final result = isAnyFieldEmpty(currentPass, newPass, confirmPass);

      // Assert
      expect(result, true);
    });
  });
}