  bool doPasswordsMatch(String? newPassword, String? confirmPassword) {
    if (newPassword == null || confirmPassword == null) {
      return false;
    }

    if (newPassword != confirmPassword) {
      return false;
    }
    return true;
  }

  bool isNewPasswordValid(String? newPassword) {
    if (newPassword == null) {
      return false;
    }
    if (newPassword.length < 8) {
      return false;
    }
    return true;
  }

  bool isAnyFieldEmpty(String? currentPass, String? newPass, String? confirmPass) {
    if (currentPass == null || newPass == null || confirmPass == null) {
      return true;
    }

    if (currentPass.isEmpty || newPass.isEmpty || confirmPass.isEmpty) {
      return true;
    }
    return false;
  }