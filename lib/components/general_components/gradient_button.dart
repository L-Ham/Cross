import 'package:flutter/material.dart';
import 'package:reddit_bel_ham/utilities/screen_size_handler.dart';

class GradientButton extends StatelessWidget {
  const GradientButton({
    super.key,
    required this.isPassFocused,
  });

  final bool isPassFocused;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (isPassFocused) {}
      },
      child: Opacity(
        opacity: isPassFocused ? 1 : 0.5,
        child: Container(
          height: ScreenSizeHandler.bigger * 0.065,
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
              'Confirm',
              style: TextStyle(
                color: Colors.white,
                fontSize: ScreenSizeHandler.bigger * 0.025,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
