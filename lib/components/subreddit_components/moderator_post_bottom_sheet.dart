import 'package:flutter/material.dart';

import '../../constants.dart';
import '../../screens/notifications_settings_screen.dart';
import '../../utilities/screen_size_handler.dart';
import '../settings_components/settings_tile.dart';
import '../settings_components/settings_tile_leading_icon.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:reddit_bel_ham/components/home_page_components/post_card.dart';

class ModeratorPostBottomSheet extends StatelessWidget {
  final Post post;
  ModeratorPostBottomSheet({required this.post});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kBackgroundColor,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: ScreenSizeHandler.screenHeight * 0.004),
              child: GestureDetector(
                onTap: () {},
                child: const SettingsTile(
                    leadingIcon: SettingsTileLeadingIcon(
                      leadingIcon: FontAwesomeIcons.circleExclamation,
                    ),
                    titleText: "Mark spoiler"),
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: Padding(
                padding: EdgeInsets.symmetric(
                    vertical: ScreenSizeHandler.screenHeight * 0.004),
                child: const SettingsTile(
                    leadingIcon: SettingsTileLeadingIcon(
                      leadingIcon: FontAwesomeIcons.lock,
                    ),
                    titleText: "Lock comments"),
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: Padding(
                padding: EdgeInsets.symmetric(
                    vertical: ScreenSizeHandler.screenHeight * 0.004),
                child: const SettingsTile(
                    leadingIcon: SettingsTileLeadingIcon(
                      leadingIcon: Icons.eighteen_up_rating_outlined,
                    ),
                    titleText: "Mark NSFW"),
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: Padding(
                padding: EdgeInsets.symmetric(
                    vertical: ScreenSizeHandler.screenHeight * 0.004),
                child: const SettingsTile(
                    leadingIcon: SettingsTileLeadingIcon(
                      leadingIcon: FontAwesomeIcons.trash,
                    ),
                    titleText: "Remove post"),
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: Padding(
                padding: EdgeInsets.symmetric(
                    vertical: ScreenSizeHandler.screenHeight * 0.004),
                child: const SettingsTile(
                    leadingIcon: SettingsTileLeadingIcon(
                      leadingIcon: FontAwesomeIcons.calendarXmark,
                    ),
                    titleText: "Remove as spam"),
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: Padding(
                padding: EdgeInsets.symmetric(
                    vertical: ScreenSizeHandler.screenHeight * 0.004),
                child: const SettingsTile(
                    leadingIcon: SettingsTileLeadingIcon(
                      leadingIcon: Icons.check,
                    ),
                    titleText: "Approve post"),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: ScreenSizeHandler.screenWidth * 0.04,
                    vertical: ScreenSizeHandler.screenHeight * 0.004),
                child: Container(
                  height: ScreenSizeHandler.screenHeight * 0.04,
                  width: ScreenSizeHandler.screenWidth,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: kFillingColor),
                  child: const Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Close',
                      style: TextStyle(
                          color: Colors.grey,
                          decorationColor: Colors.grey,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
