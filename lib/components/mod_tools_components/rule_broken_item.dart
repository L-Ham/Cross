import 'package:flutter/material.dart';
import 'package:reddit_bel_ham/constants.dart';
import 'package:reddit_bel_ham/utilities/screen_size_handler.dart';

class RuleBrokenItem extends StatelessWidget {
  final String text;
  final VoidCallback? onTap;
  final FontWeight titleFontWeight;
  final Widget? icon;

  const RuleBrokenItem({
    Key? key,
    required this.text,
    this.icon,
    this.onTap,
    this.titleFontWeight = FontWeight.normal,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: Colors.transparent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: ScreenSizeHandler.screenWidth * 0.03,
                  vertical: ScreenSizeHandler.screenHeight * 0.015
                  ),
              child: Text(
                text,
                style: kSettingsIconTextStyle.copyWith(
                  fontSize: ScreenSizeHandler.bigger *
                      kSettingsTileTextRatio *
                      1.32,
                  color: Colors.white,
                  fontWeight: titleFontWeight,
                ),
              ),
            ),
            if (icon != null)
              Padding(
                  padding: EdgeInsets.only(
                      right: ScreenSizeHandler.screenWidth * 0.02),
                  child: icon),
          ],
        ),
      ),
    );
  }
}
