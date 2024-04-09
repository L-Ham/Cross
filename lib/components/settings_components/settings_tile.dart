import 'package:flutter/material.dart';
import 'package:reddit_bel_ham/constants.dart';
import 'package:reddit_bel_ham/utilities/screen_size_handler.dart';

class SettingsTile extends StatelessWidget {
  final Widget leadingIcon;
  final String titleText;
  final String? subtitleText;
  final Widget? trailingWidget;
  final VoidCallback? onTap;
  final FontWeight titleFontWeight;
  final FontWeight subtitileFontWeight;

  const SettingsTile({
    Key? key,
    required this.leadingIcon,
    required this.titleText,
    this.subtitleText,
    this.trailingWidget,
    this.onTap,
    this.titleFontWeight = FontWeight.w500,
    this.subtitileFontWeight = FontWeight.w500,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: kBackgroundColor,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: ScreenSizeHandler.screenWidth * 0.04, vertical: ScreenSizeHandler.screenHeight*0.008),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              leadingIcon,
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(right: ScreenSizeHandler.screenWidth*0.03),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        titleText,
                        style: kSettingsIconTextStyle.copyWith(
                          fontSize: ScreenSizeHandler.bigger *
                              kSettingsTileTextRatio, fontWeight: titleFontWeight
                        ),
                      ),
                      if (subtitleText != null)
                        Text(
                          subtitleText!,
                          style: kSettingsIconTextStyle.copyWith(
                            fontSize: ScreenSizeHandler.bigger *
                                kSettingsTileSubtextRatio,
                            color: Colors.grey,
                            fontWeight: subtitileFontWeight
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              if (trailingWidget != null) trailingWidget !,
            ],
          ),
        ),
      ),
    );
  }
}
