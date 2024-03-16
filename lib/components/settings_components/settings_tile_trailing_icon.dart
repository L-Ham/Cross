import 'package:flutter/material.dart';
import 'package:reddit_bel_ham/constants.dart';
import 'package:reddit_bel_ham/utilities/screen_size_handler.dart';

class SettingsTileTrailingIcon extends StatelessWidget {
  const SettingsTileTrailingIcon({
    required this.trailingIcon,
    super.key,
  });

  final IconData trailingIcon;

  @override
  Widget build(BuildContext context) {
    return Icon(
      trailingIcon,
      size: ScreenSizeHandler.bigger * kSettingsTrailingIconRatio,
      color: Colors.white38,
    );
  }
}