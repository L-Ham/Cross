import 'package:flutter/material.dart';
import 'package:reddit_bel_ham/constants.dart';
import 'package:reddit_bel_ham/components/general_components/text_link.dart';
import 'package:reddit_bel_ham/screens/forgot_password_screen.dart';
import 'package:reddit_bel_ham/utilities/screen_size_handler.dart';

class ForgetPasswordText extends StatelessWidget {
  const ForgetPasswordText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextLink(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ForgotPasswordScreen()),
        );
      },
      text: 'Forget Password',
      fontSizeRatio: kForgetPasswordTextHeightRatio*ScreenSizeHandler.bigger,
    );
  }
}
