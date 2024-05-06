import 'package:flutter/material.dart';

import '../../utilities/screen_size_handler.dart';

class SchedulePostTile extends StatelessWidget {
  const SchedulePostTile({
    required this.leadingText,
    this.trailingText = "",
    this.isText = true,
    this.trailingWidget,
    required this.onTap,
    super.key,
  });

  final String leadingText;
  final String trailingText;
  final bool isText;
  final Widget? trailingWidget;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(
            vertical: ScreenSizeHandler.screenHeight * 0.012),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              leadingText,
              style: TextStyle(fontSize: ScreenSizeHandler.bigger * 0.0225),
            ),
            if (isText)
              Text(
                trailingText,
                style: TextStyle(
                    color: Colors.blue,
                    fontSize: ScreenSizeHandler.bigger * 0.0185),
              ),
            if (!isText && trailingWidget != null) trailingWidget!
          ],
        ),
      ),
    );
  }
}
