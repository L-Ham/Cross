import 'package:flutter/material.dart';
import '/constants.dart';
import '../utilities/screen_size_handler.dart';

class AcknowledgementText extends StatelessWidget {
  const AcknowledgementText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: ScreenSizeHandler.screenWidth * 0.04,
          vertical: ScreenSizeHandler.screenHeight * 0.02),
      child: Text(
        'By continuing, you agree to our User Agreement and acknowlege that you understand the Privacy Policy',
        style: TextStyle(
          fontSize: ScreenSizeHandler.smaller * 0.03,
          color: kHintTextColor,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
