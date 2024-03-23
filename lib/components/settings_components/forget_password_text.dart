import 'package:flutter/material.dart';
import 'package:reddit_bel_ham/constants.dart';
import 'package:reddit_bel_ham/components/general_components/interactive_text.dart';

class ForgetPasswordText extends StatelessWidget {
  const ForgetPasswordText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InteractiveText(
      onTap: () {
        //TODO: Implement the forgot password functionality
      },
      text: 'Forget Password',
      fontSizeRatio: kForgetPasswordTextHeightRatio,
    );
  }
}
