import 'package:flutter/material.dart';
import '../../constants.dart';
import '../../utilities/screen_size_handler.dart';

class ContinueButton extends StatelessWidget {
  final VoidCallback onPress;
  final String text;
  final Widget? icon;
  final bool isButtonEnabled;
  final Color? color;

  const ContinueButton({
    Key? key,
    required this.onPress,
    required this.text,
    this.icon,
    this.isButtonEnabled = true,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: ScreenSizeHandler.screenWidth * 0.04,
          vertical: ScreenSizeHandler.screenHeight * 0.01),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: !isButtonEnabled ?kDisabledButtonColor: color!=null?color: kFillingColor,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            padding: EdgeInsets.symmetric(
              vertical: ScreenSizeHandler.screenHeight * 0.015,
              horizontal: ScreenSizeHandler.screenWidth * 0.04,
            )),
        onPressed: onPress,
        child: Row(
          children: [
            if (icon != null) icon!,
            Expanded(
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  text,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: ScreenSizeHandler.smaller * 0.035,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}