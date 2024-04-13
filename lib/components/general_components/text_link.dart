import 'package:flutter/material.dart';
import 'package:reddit_bel_ham/constants.dart';
import '../../utilities/screen_size_handler.dart';

class TextLink extends StatelessWidget {
  const TextLink({
    Key? key,
    required this.onTap,
    required this.text, 
    required this.fontSizeRatio,
    this.color,
    this.isBold,
  }) : super(key: key);

  final VoidCallback onTap;
  final String text; 
  final double? fontSizeRatio;
  final Color? color;
  final bool? isBold;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.only(left: ScreenSizeHandler.smaller * kTextLinkPaddingRatio),
        child: Text(
          text,
          style: TextStyle(
            fontSize: fontSizeRatio,
            color: color ?? Colors.blue,
            fontWeight: isBold == true ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
