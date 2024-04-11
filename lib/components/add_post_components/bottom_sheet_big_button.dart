import 'package:flutter/material.dart';

import '../../constants.dart';
import '../../utilities/screen_size_handler.dart';

class BottomSheetBigButton extends StatelessWidget {
  const BottomSheetBigButton(
      {super.key,
      required this.title,
      this.textColor = Colors.black,
      this.isBold = false,
      required this.onTap});

  final String title;
  final Color textColor;
  final bool isBold;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: kFillingColor,
        height: ScreenSizeHandler.screenHeight * 0.067,
        child: Center(
          child: Text(
            title,
            style: TextStyle(
                fontSize: ScreenSizeHandler.bigger * 0.023,
                color: textColor,
                fontWeight: isBold ? FontWeight.bold : FontWeight.w400),
          ),
        ),
      ),
    );
  }
}
