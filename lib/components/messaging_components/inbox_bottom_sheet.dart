import 'package:flutter/material.dart';

import '../../constants.dart';
import '../../screens/new_message_screen.dart';
import '../../screens/notifications_settings_screen.dart';
import '../../utilities/screen_size_handler.dart';
import '../settings_components/settings_tile.dart';
import '../settings_components/settings_tile_leading_icon.dart';

class InboxBottomSheet extends StatelessWidget {
  const InboxBottomSheet({
    super.key,
  });

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
                onTap: () {
                  Navigator.pop(context, 1);
                  Navigator.pushNamed(context, NewMessageScreen.id,
                      arguments: {"isReply": false});
                },
                child: SettingsTile(
                    leadingIcon: SettingsTileLeadingIcon(
                      leadingIcon: Icons.edit_outlined,
                    ),
                    titleText: "New message"),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pop(context, 2);
              },
              child: Padding(
                padding: EdgeInsets.symmetric(
                    vertical: ScreenSizeHandler.screenHeight * 0.004),
                child: SettingsTile(
                    leadingIcon: SettingsTileLeadingIcon(
                      leadingIcon: Icons.mark_email_read_outlined,
                    ),
                    titleText: "Mark all inbox tabs as read"),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pop(context, 3);
                Navigator.pushNamed(context, NotificationSettingsScreen.id);
              },
              child: Padding(
                padding: EdgeInsets.symmetric(
                    vertical: ScreenSizeHandler.screenHeight * 0.004),
                child: SettingsTile(
                    leadingIcon: SettingsTileLeadingIcon(
                      leadingIcon: Icons.settings_outlined,
                    ),
                    titleText: "Edit notifications settings"),
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
                          decoration: TextDecoration.underline,
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
