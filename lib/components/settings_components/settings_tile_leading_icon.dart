import 'package:flutter/material.dart';
import 'package:reddit_bel_ham/constants.dart';
import 'package:reddit_bel_ham/utilities/screen_size_handler.dart';

class SettingsTileLeadingIcon extends StatelessWidget {
  const SettingsTileLeadingIcon({
    super.key,
    required this.leadingIcon,
  });

  final IconData leadingIcon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        right: ScreenSizeHandler.screenWidth * 0.04,
      ),
      child: Icon(
        leadingIcon,
        size: ScreenSizeHandler.bigger* kSettingsLeadingIconRatio,
        color: Colors.grey,
      ),
    );
  }
}
