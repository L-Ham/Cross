import 'package:flutter/material.dart';
import 'package:reddit_bel_ham/constants.dart';
import 'package:reddit_bel_ham/utilities/screen_size_handler.dart';

class UserBottomSheetTile extends StatelessWidget {
  final String text;
  final VoidCallback? onTap;
  final FontWeight titleFontWeight;
  final Widget icon;

  const UserBottomSheetTile({
    Key? key,
    required this.text,
    required this.icon,
    this.onTap,
    this.titleFontWeight = FontWeight.w500,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: Colors.transparent,
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: ScreenSizeHandler.screenWidth * 0.01,
              vertical: ScreenSizeHandler.screenHeight * 0.015
              ),
          child: Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: ScreenSizeHandler.screenWidth * 0.04),
                child: icon,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: ScreenSizeHandler.screenWidth * 0.03,
                  // vertical: ScreenSizeHandler.screenHeight * 0.02,
                ),
                child: Text(
                  text,
                  style: kSettingsIconTextStyle.copyWith(
                    fontSize:
                        ScreenSizeHandler.bigger * kSettingsTileTextRatio * 1.3,
                    color: Colors.white,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
