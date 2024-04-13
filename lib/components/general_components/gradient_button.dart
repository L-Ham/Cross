import 'package:flutter/material.dart';
import 'package:reddit_bel_ham/utilities/screen_size_handler.dart';

class GradientButton extends StatelessWidget {
  const GradientButton(
      {super.key,
      required this.isPassFocused,
      required this.buttonTitle,
      required this.onTap});

  final bool isPassFocused;
  final String buttonTitle;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Opacity(
        opacity: isPassFocused ? 1 : 0.5,
        child: Container(
          height: ScreenSizeHandler.bigger * 0.055,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Colors.red, Colors.orange],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            borderRadius: BorderRadius.circular(30.0), // adjust as needed
          ),
          child: Center(
            child: Text(
              buttonTitle,
              style: TextStyle(
                color: Colors.white,
                fontSize: ScreenSizeHandler.bigger * 0.02,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
