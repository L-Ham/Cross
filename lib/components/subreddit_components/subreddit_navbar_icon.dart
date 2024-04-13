import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:reddit_bel_ham/utilities/screen_size_handler.dart';

class SubredditNavbarIcon extends StatelessWidget {
  final double iconSize;
  final Widget icon;
  final VoidCallback onPressed;
  const SubredditNavbarIcon({
    super.key,
    required this.iconSize,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: ScreenSizeHandler.bigger * 0.008),
      child: CircleAvatar(
        radius: ScreenSizeHandler.bigger * 0.026,
        backgroundColor: Color.fromARGB(155, 0, 0, 0),
        child: Center(
          child: IconButton(
            iconSize: ScreenSizeHandler.bigger * iconSize,
            icon: icon,
            onPressed: onPressed,
          ),
        ),
      ),
    );
  }
}
