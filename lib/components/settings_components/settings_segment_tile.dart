import 'package:flutter/material.dart';
import 'package:reddit_bel_ham/constants.dart';
import 'package:reddit_bel_ham/utilities/screen_size_handler.dart';

class SettingsSegmentTitle extends StatelessWidget {
  final String titleText;

  const SettingsSegmentTitle({
    required this.titleText,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(ScreenSizeHandler.bigger * 0.02),
      child: Text(
        titleText,
        style: kSettingsSegmentTileTextStyle.copyWith(
          fontSize:
              ScreenSizeHandler.bigger * kSettingsSegmentTextRatio,
        ),
      ),
    );
  }
}
