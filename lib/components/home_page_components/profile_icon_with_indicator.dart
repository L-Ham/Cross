import 'package:flutter/material.dart';
import '../../utilities/screen_size_handler.dart';

class ProfileIconWithIndicator extends StatelessWidget {
  const ProfileIconWithIndicator({
    required this.isOnline,
    this.imageURL,
    super.key,
  });

  final bool isOnline;
  final String? imageURL;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        CircleAvatar(
          backgroundColor: Colors.orange,
          radius: 25,
          child: CircleAvatar(
            backgroundImage:
                AssetImage(imageURL ?? 'assets/images/reddit_logo.png'),
            radius: 18,
          ),
        ),
        if (isOnline)
          Positioned(
            bottom: -ScreenSizeHandler.screenHeight * 0.002,
            left: ScreenSizeHandler.screenWidth * 0.0195,
            child: const CircleAvatar(
              backgroundColor: Colors.black,
              radius: 7,
              child: CircleAvatar(
                backgroundColor: Colors.green,
                radius: 5,
              ),
            ),
          ),
      ],
    );
  }
}
