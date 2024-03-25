import 'package:flutter/material.dart';
import 'package:reddit_bel_ham/constants.dart';
import 'package:reddit_bel_ham/utilities/screen_size_handler.dart';

class InteractiveText extends StatelessWidget {
  const InteractiveText(
      {super.key,
      required this.text,
      required this.onTap,
      this.fontSizeRatio = kInteractiveTextHeightRatio});

  final String text;
  final double fontSizeRatio;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        text,
        style: kInteractiveTextStyle.copyWith(
          fontSize: ScreenSizeHandler.bigger * fontSizeRatio,
        ),
      ),
    );
  }
}
