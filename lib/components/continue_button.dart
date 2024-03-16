import 'package:flutter/material.dart';
import '../constants.dart';
import '../utilities/screen_size_handler.dart';

class ContinueButton extends StatelessWidget {
  final VoidCallback onPress;
  final String text;
  final Widget? icon;

  const ContinueButton({
    Key? key,
    required this.onPress,
    required this.text,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.04,
          vertical: MediaQuery.of(context).size.height * 0.01),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: kFillingColor,
            foregroundColor: Colors.white,
            padding: EdgeInsets.symmetric(
              vertical: MediaQuery.of(context).size.height * 0.015,
              horizontal: MediaQuery.of(context).size.width * 0.04,
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
