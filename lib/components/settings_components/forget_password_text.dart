import 'package:flutter/material.dart';
import 'package:reddit_bel_ham/components/general_components/interactive_text.dart';
import 'package:reddit_bel_ham/constants.dart';
import 'package:reddit_bel_ham/screens/forgot_password_screen.dart';

class ForgetPasswordText extends StatelessWidget {
  const ForgetPasswordText({
    super.key,
    this.isDisconnectScreen = false,
  });

  final bool isDisconnectScreen;

  @override
  Widget build(BuildContext context) {
    return InteractiveText(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ForgotPasswordScreen()),
        );
      },
      text: isDisconnectScreen? 'Forgot Password?':'Forget Password',
      isUnderlined: true,
      fontSizeRatio: kForgetPasswordTextHeightRatio,
      fontWeight: FontWeight.normal,
    );
  }
}
