import 'package:flutter/material.dart';
import 'package:reddit_bel_ham/constants.dart';
import 'package:reddit_bel_ham/utilities/screen_size_handler.dart';

class UserTile extends StatelessWidget {
  final String titleText;
  final String? subtitleText;
  final VoidCallback? onTap;
  final VoidCallback? onIconTap;
  final FontWeight titleFontWeight;
  final FontWeight subtitileFontWeight;
  final Color? fontColor;
  final String? avatarLink;

  const UserTile({
    Key? key,
    required this.titleText,
    this.subtitleText,
    this.onTap,
    this.onIconTap,
    this.titleFontWeight = FontWeight.w500,
    this.subtitileFontWeight = FontWeight.w500,
    this.fontColor,
    this.avatarLink,
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
              ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(
                  right: ScreenSizeHandler.screenWidth * 0.04,
                ),
                child: 
                avatarLink != null ? CircleAvatar(
                  backgroundImage: NetworkImage(avatarLink!),
                  radius: ScreenSizeHandler.screenWidth * 0.035,
                ) :
                Image(
                  image: const AssetImage('assets/images/avatarDaniel.png'),
                  height: ScreenSizeHandler.screenHeight * 0.07,
                  width: ScreenSizeHandler.screenWidth * 0.07,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(
                      right: ScreenSizeHandler.screenWidth * 0.03),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        titleText,
                        style: kSettingsIconTextStyle.copyWith(
                          fontSize:
                              ScreenSizeHandler.bigger * kSettingsTileTextRatio,
                          fontWeight: titleFontWeight,
                          color: fontColor,
                        ),
                      ),
                      if (subtitleText != null)
                        Text(
                          subtitleText!,
                          style: kSettingsIconTextStyle.copyWith(
                              fontSize: ScreenSizeHandler.bigger *
                                  kSettingsTileSubtextRatio,
                              color: Colors.grey,
                              fontWeight: subtitileFontWeight),
                        ),
                    ],
                  ),
                ),
              ),
              IconButton(
                icon:const Icon(
                  Icons.more_horiz,
                ),
                iconSize: ScreenSizeHandler.bigger * kSettingsTrailingIconRatio,
                color: Colors.white,
                onPressed: () {
                  if (onIconTap != null) {
                    onIconTap!();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
