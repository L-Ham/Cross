import 'package:flutter/material.dart';
import 'package:reddit_bel_ham/utilities/screen_size_handler.dart';

class EmptyDog extends StatelessWidget {
  const EmptyDog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'assets/images/empty_dog.png',
          width: ScreenSizeHandler.screenWidth * 0.35,
          height: ScreenSizeHandler.screenHeight * 0.15,
        ),
        Text(
          'Wow, such empty',
          style: TextStyle(
            color: Colors.grey,
            fontSize: ScreenSizeHandler.bigger * 0.02,
          ),
        )
      ],
    );
  }
}
