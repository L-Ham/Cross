import 'package:flutter/material.dart';
import 'package:reddit_bel_ham/utilities/screen_size_handler.dart';

class SettingsTileImage extends StatelessWidget {
  const SettingsTileImage({
    super.key,
    required this.assetImageData,
  });

  final String assetImageData;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        right: ScreenSizeHandler.screenWidth * 0.04,
      ),
      child: Image(
        image: AssetImage(
          assetImageData,
        ),
        width: ScreenSizeHandler.smaller * 0.045,
        height: ScreenSizeHandler.bigger * 0.045,
      ),
    );
  }
}
