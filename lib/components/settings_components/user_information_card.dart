import 'package:flutter/material.dart';
import 'package:reddit_bel_ham/constants.dart';
import 'package:reddit_bel_ham/utilities/screen_size_handler.dart';

class UserInformationCard extends StatelessWidget {
  const UserInformationCard({
    super.key,
    required this.username,
    required this.email,
    this.imageUrl,
  });

  final String username;
  final String email;
  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          backgroundColor: kFillingColor,
          radius: ScreenSizeHandler.bigger * 0.032,
          backgroundImage: imageUrl != null ? NetworkImage(imageUrl!) : null,
        ),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(
                    left: ScreenSizeHandler.smaller * 0.04,
                    top: ScreenSizeHandler.bigger * 0.01,
                    bottom: ScreenSizeHandler.bigger * 0.01),
                child: Text(
                  "u/$username",
                  style: kSettingsSubHeaderTextStyle.copyWith(
                      fontSize: ScreenSizeHandler.bigger * kSettingsTextRatio),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: ScreenSizeHandler.smaller * 0.04,
                    top: ScreenSizeHandler.bigger * 0.01,
                    bottom: ScreenSizeHandler.bigger * 0.01),
                child: Text(
                  email,
                  style: kSettingsBodyTextStyle.copyWith(
                    fontSize: ScreenSizeHandler.bigger * kSettingsTextRatio,
                  ),
                  softWrap: true,
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
