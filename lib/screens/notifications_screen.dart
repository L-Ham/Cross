import 'package:flutter/material.dart';
import 'package:reddit_bel_ham/components/general_components/custom_switch.dart';
import 'package:reddit_bel_ham/components/settings_components/settings_segment_tile.dart';
import 'package:reddit_bel_ham/components/settings_components/settings_tile.dart';
import 'package:reddit_bel_ham/components/settings_components/settings_tile_leading_icon.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:reddit_bel_ham/constants.dart';
import 'package:reddit_bel_ham/utilities/screen_size_handler.dart';

class NotificationSettingsScreen extends StatefulWidget {
  const NotificationSettingsScreen({super.key});

  @override
  _NotificationSettingsScreenState createState() =>
      _NotificationSettingsScreenState();
}

class _NotificationSettingsScreenState
    extends State<NotificationSettingsScreen> {
  List<bool> switchStates = List.generate(11, (index) => false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kSettingsBackGroundColor,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: kBackgroundColor,
          title: Padding(
            padding: const EdgeInsets.only(top: kPageTtleTopBottomPadding, bottom: kPageTtleTopBottomPadding),
            child: Text(
              'Notification Settings',
              style: TextStyle(
                fontSize: ScreenSizeHandler.bigger * kAppBarTitleFontSizeRatio,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SettingsSegmentTitle(titleText: "MESSAGES"),
              SettingsTile(
                  leadingIcon: const SettingsTileLeadingIcon(
                      leadingIcon: Icons.mail_outline),
                  titleText: "Private messages",
                  trailingWidget: CustomSwitch(
                      isSwitched: switchStates[kNotificationSettingsPrivateMessagesSwitchIndex],
                      onChanged: (value) {
                        setState(() {
                          switchStates[kNotificationSettingsPrivateMessagesSwitchIndex] = value;
                        });
                      })),
              SettingsTile(
                  leadingIcon: const SettingsTileLeadingIcon(
                      leadingIcon: FontAwesomeIcons.commentDots),
                  titleText: "Chat messages",
                  trailingWidget: CustomSwitch(
                      isSwitched: switchStates[kNotificationSettingsChatMessagesSwitchIndex],
                      onChanged: (value) {
                        setState(() {
                          switchStates[kNotificationSettingsChatMessagesSwitchIndex] = value;
                        });
                      })),
              SettingsTile(
                  leadingIcon: const SettingsTileLeadingIcon(
                      leadingIcon: Icons.add_comment_outlined),
                  titleText: "Chat requests",
                  trailingWidget: CustomSwitch(
                      isSwitched: switchStates[kNotificationSettingsChatRequestsSwitchIndex],
                      onChanged: (value) {
                        setState(() {
                          switchStates[kNotificationSettingsChatRequestsSwitchIndex] = value;
                        });
                      })),
              const SettingsSegmentTitle(titleText: "ACTIVITY"),
              SettingsTile(
                  leadingIcon: const SettingsTileLeadingIcon(
                      leadingIcon: Icons.account_circle_outlined),
                  titleText: "Mentions of u/username",
                  trailingWidget:
                      CustomSwitch(isSwitched: switchStates[kNotificationSettingsMentionsOfUsernameSwitchIndex],
                      onChanged: (value) {
                        setState(() {
                          switchStates[kNotificationSettingsMentionsOfUsernameSwitchIndex] = value;
                        });
                      })),
              SettingsTile(
                  leadingIcon: const SettingsTileLeadingIcon(
                      leadingIcon: Icons.mode_comment_outlined),
                  titleText: "Comments on your posts",
                  trailingWidget:
                      CustomSwitch(isSwitched: switchStates[kNotificationSettingsCommentsOnYourPostsSwitchIndex],
                      onChanged: (value) {
                        setState(() {
                          switchStates[kNotificationSettingsCommentsOnYourPostsSwitchIndex] = value;
                        });
                      })),
              SettingsTile(
                  leadingIcon: const SettingsTileLeadingIcon(
                      leadingIcon: FontAwesomeIcons.arrowUp),
                  titleText: "Upvotes on your posts",
                  trailingWidget:
                      CustomSwitch(isSwitched: switchStates[kNotificationSettingsUpvotesOnYourPostsSwitchIndex],
                      onChanged: (value) {
                        setState(() {
                          switchStates[kNotificationSettingsUpvotesOnYourPostsSwitchIndex] = value;
                        });
                      })),
              SettingsTile(
                  leadingIcon: const SettingsTileLeadingIcon(
                      leadingIcon: FontAwesomeIcons.arrowUp),
                  titleText: "Upvotes on your comments",
                  trailingWidget:
                      CustomSwitch(isSwitched: switchStates[kNotificationSettingsUpvotesOnYourCommentsSwitchIndex],
                      onChanged: (value) {
                        setState(() {
                          switchStates[kNotificationSettingsUpvotesOnYourCommentsSwitchIndex] = value;
                        });
                      })),
              SettingsTile(
                  leadingIcon:
                      const SettingsTileLeadingIcon(leadingIcon: Icons.reply),
                  titleText: "Replies to your comments",
                  trailingWidget:
                      CustomSwitch(isSwitched: switchStates[kNotificationSettingsRepliesToYourCommentsSwitchIndex],
                      onChanged: (value) {
                        setState(() {
                          switchStates[kNotificationSettingsRepliesToYourCommentsSwitchIndex] = value;
                        });
                      })),
              SettingsTile(
                  leadingIcon: const SettingsTileLeadingIcon(
                      leadingIcon: Icons.supervisor_account_rounded),
                  titleText: "New followers",
                  trailingWidget:
                      CustomSwitch(isSwitched: switchStates[kNotificationSettingsNewFollowersSwitchIndex],
                      onChanged: (value) {
                        setState(() {
                          switchStates[kNotificationSettingsNewFollowersSwitchIndex] = value;
                        });
                      })),
              const SettingsSegmentTitle(titleText: "UPDATES"),
              SettingsTile(
                  leadingIcon: const SettingsTileLeadingIcon(
                      leadingIcon: FontAwesomeIcons.cakeCandles),
                  titleText: "Cake day",
                  trailingWidget:
                      CustomSwitch(isSwitched: switchStates[kNotificationSettingsCakeDaySwitchIndex],
                      onChanged: (value) {
                        setState(() {
                          switchStates[kNotificationSettingsCakeDaySwitchIndex] = value;
                        });
                      })),
              const SettingsSegmentTitle(titleText: "MODERATION"),
              SettingsTile(
                  leadingIcon: const SettingsTileLeadingIcon(
                      leadingIcon: Icons.notifications_none_rounded),
                  titleText: "Mod notifications",
                  trailingWidget:
                      CustomSwitch(isSwitched: switchStates[kNotificationSettingsModNotificationsSwitchIndex],
                      onChanged: (value) {
                        setState(() {
                          switchStates[kNotificationSettingsModNotificationsSwitchIndex] = value;
                        });
                      })),
            ],
          ),
        ),
      );
  }
}
