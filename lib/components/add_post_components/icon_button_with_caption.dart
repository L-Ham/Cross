import 'package:flutter/material.dart';

import '../../constants.dart';
import '../../utilities/screen_size_handler.dart';

class IconButtonWithCaption extends StatelessWidget {
  const IconButtonWithCaption({
    required this.icon,
    this.backgroundColor = kBackgroundColor,
    this.caption = "",
    required this.onTap,
    this.iconRadiusRatio = 0.026,
    this.isIconEnabled = false,
    this.isIconChosen = false,
    this.hasCaption = true,
    this.isFontAwesomeIcons = false,
    super.key,
  });

  final IconData icon;
  final Color backgroundColor;
  final String caption;
  final Function() onTap;
  final double iconRadiusRatio;
  final bool isIconEnabled;
  final bool isIconChosen;
  final bool hasCaption;
  final bool isFontAwesomeIcons;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          CircleAvatar(
            radius: ScreenSizeHandler.bigger * iconRadiusRatio,
            backgroundColor: isIconChosen ? kSwitchOnColor : backgroundColor,
            child: Icon(
              icon,
              color: isIconChosen
                  ? Colors.white
                  : isIconEnabled
                      ? Colors.grey[100]
                      : Colors.grey[700],
              size: isFontAwesomeIcons
                  ? ScreenSizeHandler.bigger * iconRadiusRatio
                  : ScreenSizeHandler.bigger * iconRadiusRatio * 1.45,
            ),
          ),
          if (hasCaption)
            Padding(
              padding:
                  EdgeInsets.only(top: ScreenSizeHandler.screenHeight * 0.005),
              child: Text(
                caption,
                style: TextStyle(
                    fontSize: ScreenSizeHandler.bigger * 0.015,
                    color: isIconChosen
                        ? kSwitchOnColor
                        : isIconEnabled
                            ? Colors.grey[100]
                            : Colors.grey[700],
                    fontWeight: FontWeight.w500),
              ),
            )
        ],
      ),
    );
  }
}
