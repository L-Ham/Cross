import 'package:flutter/material.dart';
import '../utilities/screen_size_handler.dart';

class TextLink extends StatelessWidget {
  const TextLink({
    Key? key,
    required this.onTap,
    required this.text, // Add this line
  }) : super(key: key);

  final VoidCallback onTap;
  final String text; // Add this line

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.only(left: ScreenSizeHandler.smaller * 0.015),
        child: Text(
          text,
          style: TextStyle(
            fontSize: ScreenSizeHandler.smaller * 0.035,
            color: Colors.blue,
          ),
        ),
      ),
    );
  }
}
