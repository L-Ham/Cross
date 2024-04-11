import 'package:flutter/material.dart';
import '../../constants.dart';
import '../../utilities/screen_size_handler.dart';

class ContinueButton extends StatelessWidget {
  final VoidCallback onPress;
  final String text;
  final Widget? icon;
  final bool isButtonEnabled;
  final Color? color;
  final Color? textColor;

  const ContinueButton({
    Key? key,
    required this.onPress,
    required this.text,
    this.icon,
    this.isButtonEnabled = true,
    this.color,
    this.textColor
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: ScreenSizeHandler.screenWidth * kButtonWidthRatio,
          vertical: ScreenSizeHandler.screenHeight * kButtonHeightRatio),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: !isButtonEnabled ?kDisabledButtonColor: color!=null?color: kFillingColor,
            foregroundColor: textColor!=null? textColor:Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            padding: EdgeInsets.symmetric(
              vertical: ScreenSizeHandler.screenHeight * 0.015,
              horizontal: ScreenSizeHandler.screenWidth * kButtonWidthRatio,
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
                    fontSize: ScreenSizeHandler.smaller * kButtonSmallerFontRatio,
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
