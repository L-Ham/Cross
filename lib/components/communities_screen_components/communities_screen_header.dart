import 'package:flutter/material.dart';

import '../../utilities/screen_size_handler.dart';

class CommunitiesScreenHeader extends StatelessWidget {
  const CommunitiesScreenHeader({
    required this.title,
    required this.onTap,
    super.key,
  });

  final String title;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(
            vertical: ScreenSizeHandler.screenHeight * 0.015),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: ScreenSizeHandler.bigger * 0.02),
            ),
            Icon(
              Icons.keyboard_arrow_right,
              color: Colors.grey,
              size: ScreenSizeHandler.bigger * 0.03,
            )
          ],
        ),
      ),
    );
  }
}