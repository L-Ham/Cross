import 'package:flutter/material.dart';
import 'package:reddit_bel_ham/components/general_components/custom_switch.dart';
import 'package:reddit_bel_ham/components/settings_components/settings_segment_tile.dart';
import 'package:reddit_bel_ham/components/settings_components/settings_tile.dart';
import 'package:reddit_bel_ham/components/settings_components/settings_tile_leading_icon.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:reddit_bel_ham/constants.dart';

class NotificationSettingsScreen extends StatefulWidget {
  @override
  _NotificationSettingsScreenState createState() =>
      _NotificationSettingsScreenState();
}

class _NotificationSettingsScreenState
    extends State<NotificationSettingsScreen> {
  List<bool> switchStates = List.generate(11, (index) => false);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: Padding(
            padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
            child: Center(
              child: Text(
                'Notification Settings',
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.height * kPageTitleFontSizeHeightRatio,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(9.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SettingsSegmentTitle(titleText: "MESSAGES"),
                SettingsTile(
                    leadingIcon: SettingsTileLeadingIcon(
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
                    leadingIcon: SettingsTileLeadingIcon(
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
                    leadingIcon: SettingsTileLeadingIcon(
                        leadingIcon: Icons.add_comment_outlined),
                    titleText: "Chat requests",
                    trailingWidget: CustomSwitch(
                        isSwitched: switchStates[kNotificationSettingsChatRequestsSwitchIndex],
                        onChanged: (value) {
                          setState(() {
                            switchStates[kNotificationSettingsChatRequestsSwitchIndex] = value;
                          });
                        })),
                SettingsSegmentTitle(titleText: "ACTIVITY"),
                SettingsTile(
                    leadingIcon: SettingsTileLeadingIcon(
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
                    leadingIcon: SettingsTileLeadingIcon(
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
                    leadingIcon: SettingsTileLeadingIcon(
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
                    leadingIcon: SettingsTileLeadingIcon(
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
                        SettingsTileLeadingIcon(leadingIcon: Icons.reply),
                    titleText: "Replies to your comments",
                    trailingWidget:
                        CustomSwitch(isSwitched: switchStates[kNotificationSettingsRepliesToYourCommentsSwitchIndex],
                        onChanged: (value) {
                          setState(() {
                            switchStates[kNotificationSettingsRepliesToYourCommentsSwitchIndex] = value;
                          });
                        })),
                SettingsTile(
                    leadingIcon: SettingsTileLeadingIcon(
                        leadingIcon: Icons.supervisor_account_rounded),
                    titleText: "New followers",
                    trailingWidget:
                        CustomSwitch(isSwitched: switchStates[kNotificationSettingsNewFollowersSwitchIndex],
                        onChanged: (value) {
                          setState(() {
                            switchStates[kNotificationSettingsNewFollowersSwitchIndex] = value;
                          });
                        })),
                SettingsSegmentTitle(titleText: "UPDATES"),
                SettingsTile(
                    leadingIcon: SettingsTileLeadingIcon(
                        leadingIcon: FontAwesomeIcons.cakeCandles),
                    titleText: "Cake day",
                    trailingWidget:
                        CustomSwitch(isSwitched: switchStates[kNotificationSettingsCakeDaySwitchIndex],
                        onChanged: (value) {
                          setState(() {
                            switchStates[kNotificationSettingsCakeDaySwitchIndex] = value;
                          });
                        })),
                SettingsSegmentTitle(titleText: "MODERATION"),
                SettingsTile(
                    leadingIcon: SettingsTileLeadingIcon(
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
        ),
      ),
    );
  }
}
