import 'package:flutter/material.dart';
import 'package:reddit_bel_ham/components/general_components/custom_switch.dart';
import 'package:reddit_bel_ham/components/general_components/reddit_loading_indicator.dart';
import 'package:reddit_bel_ham/components/settings_components/settings_segment_tile.dart';
import 'package:reddit_bel_ham/components/settings_components/settings_tile.dart';
import 'package:reddit_bel_ham/components/settings_components/settings_tile_leading_icon.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:reddit_bel_ham/constants.dart';
import 'package:reddit_bel_ham/services/api_service.dart';
import 'package:reddit_bel_ham/utilities/screen_size_handler.dart';
import 'package:reddit_bel_ham/utilities/token_decoder.dart';

class NotificationSettingsScreen extends StatefulWidget {
  const NotificationSettingsScreen({super.key});

  static const String id = 'notification_settings_screen';

  @override
  _NotificationSettingsScreenState createState() =>
      _NotificationSettingsScreenState();
}

class _NotificationSettingsScreenState
    extends State<NotificationSettingsScreen> {
  ApiService? apiService;
  List<bool> notificationsSwitchStates = List.generate(11, (index) => false);
  bool isLoading = true;

  void getNotificationsSettings() async {
    Map<String, dynamic> data = await apiService!.getNotificationSettings();
    setState(() {
      notificationsSwitchStates =
          data['notificationSettings'].values.toList().cast<bool>();
      notificationsSwitchStates.add(false);
      notificationsSwitchStates[
              kNotificationSettingsModNotificationsSwitchIndex] =
          notificationsSwitchStates[kNotificationSettingsCakeDaySwitchIndex];
      notificationsSwitchStates[kNotificationSettingsCakeDaySwitchIndex] =
          false;
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    apiService = ApiService(TokenDecoder.token);
    getNotificationsSettings();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kSettingsBackGroundColor,
      appBar: AppBar(
        key: const Key('notification_settings_app_bar'),
        centerTitle: true,
        backgroundColor: kBackgroundColor,
        title: Padding(
          padding: EdgeInsets.only(
              top: ScreenSizeHandler.screenHeight *
                  kPageTtleTopBottomPaddingRatio,
              bottom: ScreenSizeHandler.screenHeight *
                  kPageTtleTopBottomPaddingRatio),
          child: Text(
            'Notification Settings',
            key: const Key('notification_settings_app_bar_title'),
            style: TextStyle(
              fontSize:
                  ScreenSizeHandler.screenWidth * kAppBarTitleSmallerFontRatio,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
      body: isLoading
          ? const Align(
              alignment: Alignment.topCenter, child: RedditLoadingIndicator())
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SettingsSegmentTitle(
                      key: Key('messages_segment_title'),
                      titleText: "Messages"),
                  SettingsTile(
                      key: const Key('private_messages_tile'),
                      leadingIcon: const SettingsTileLeadingIcon(
                          leadingIcon: Icons.mail_outline),
                      titleText: "Private messages",
                      trailingWidget: CustomSwitch(
                          key: const Key('private_messages_switch'),
                          isSwitched: notificationsSwitchStates[
                              kNotificationSettingsPrivateMessagesSwitchIndex],
                          onChanged: (value) async {
                            setState(() {
                              notificationsSwitchStates[
                                      kNotificationSettingsPrivateMessagesSwitchIndex] =
                                  value;
                            });
                            await apiService!.patchNotificationSettings(
                                notificationsSwitchStates);
                          })),
                  SettingsTile(
                      key: const Key('chat_messages_tile'),
                      leadingIcon: const SettingsTileLeadingIcon(
                          leadingIcon: FontAwesomeIcons.commentDots),
                      titleText: "Chat messages",
                      trailingWidget: CustomSwitch(
                          key: const Key('chat_messages_switch'),
                          isSwitched: notificationsSwitchStates[
                              kNotificationSettingsChatMessagesSwitchIndex],
                          onChanged: (value) async {
                            setState(() {
                              notificationsSwitchStates[
                                      kNotificationSettingsChatMessagesSwitchIndex] =
                                  value;
                            });
                            await apiService!.patchNotificationSettings(
                                notificationsSwitchStates);
                          })),
                  SettingsTile(
                      key: const Key('chat_requests_tile'),
                      leadingIcon: const SettingsTileLeadingIcon(
                          leadingIcon: Icons.add_comment_outlined),
                      titleText: "Chat requests",
                      trailingWidget: CustomSwitch(
                          key: const Key('chat_requests_switch'),
                          isSwitched: notificationsSwitchStates[
                              kNotificationSettingsChatRequestsSwitchIndex],
                          onChanged: (value) async {
                            setState(() {
                              notificationsSwitchStates[
                                      kNotificationSettingsChatRequestsSwitchIndex] =
                                  value;
                            });
                            await apiService!.patchNotificationSettings(
                                notificationsSwitchStates);
                          })),
                  const SettingsSegmentTitle(
                      key: Key('activity_title'), titleText: "Activity"),
                  SettingsTile(
                      key: const Key('mentions_tile'),
                      leadingIcon: const SettingsTileLeadingIcon(
                          leadingIcon: Icons.account_circle_outlined),
                      titleText: "Mentions of u/username",
                      trailingWidget: CustomSwitch(
                          key: const Key('mentions_switch'),
                          isSwitched: notificationsSwitchStates[
                              kNotificationSettingsMentionsOfUsernameSwitchIndex],
                          onChanged: (value) async {
                            setState(() {
                              notificationsSwitchStates[
                                      kNotificationSettingsMentionsOfUsernameSwitchIndex] =
                                  value;
                            });
                            await apiService!.patchNotificationSettings(
                                notificationsSwitchStates);
                          })),
                  SettingsTile(
                      key: const Key('comments_on_your_posts_tile'),
                      leadingIcon: const SettingsTileLeadingIcon(
                          leadingIcon: Icons.mode_comment_outlined),
                      titleText: "Comments on your posts",
                      trailingWidget: CustomSwitch(
                          key: const Key('comments_on_your_posts_switch'),
                          isSwitched: notificationsSwitchStates[
                              kNotificationSettingsCommentsOnYourPostsSwitchIndex],
                          onChanged: (value) async {
                            setState(() {
                              notificationsSwitchStates[
                                      kNotificationSettingsCommentsOnYourPostsSwitchIndex] =
                                  value;
                            });
                            await apiService!.patchNotificationSettings(
                                notificationsSwitchStates);
                          })),
                  SettingsTile(
                      key: const Key('upvotes_on_your_posts_tile'),
                      leadingIcon: const SettingsTileLeadingIcon(
                          leadingIcon: FontAwesomeIcons.arrowUp),
                      titleText: "Upvotes on your posts",
                      trailingWidget: CustomSwitch(
                          key: const Key('upvotes_on_your_posts_switch'),
                          isSwitched: notificationsSwitchStates[
                              kNotificationSettingsUpvotesOnYourPostsSwitchIndex],
                          onChanged: (value) async {
                            setState(() {
                              notificationsSwitchStates[
                                      kNotificationSettingsUpvotesOnYourPostsSwitchIndex] =
                                  value;
                            });
                            await apiService!.patchNotificationSettings(
                                notificationsSwitchStates);
                          })),
                  SettingsTile(
                      key: const Key('upvotes_on_your_comments_tile'),
                      leadingIcon: const SettingsTileLeadingIcon(
                          leadingIcon: FontAwesomeIcons.arrowUp),
                      titleText: "Upvotes on your comments",
                      trailingWidget: CustomSwitch(
                          key: const Key('upvotes_on_your_comments_switch'),
                          isSwitched: notificationsSwitchStates[
                              kNotificationSettingsUpvotesOnYourCommentsSwitchIndex],
                          onChanged: (value) async {
                            setState(() {
                              notificationsSwitchStates[
                                      kNotificationSettingsUpvotesOnYourCommentsSwitchIndex] =
                                  value;
                            });
                            apiService!.patchNotificationSettings(
                                notificationsSwitchStates);
                          })),
                  SettingsTile(
                      key: const Key('replies_to_your_comments_tile'),
                      leadingIcon: const SettingsTileLeadingIcon(
                          leadingIcon: Icons.reply),
                      titleText: "Replies to your comments",
                      trailingWidget: CustomSwitch(
                          key: const Key('replies_to_your_comments_switch'),
                          isSwitched: notificationsSwitchStates[
                              kNotificationSettingsRepliesToYourCommentsSwitchIndex],
                          onChanged: (value) async {
                            setState(() {
                              notificationsSwitchStates[
                                      kNotificationSettingsRepliesToYourCommentsSwitchIndex] =
                                  value;
                            });
                            await apiService!.patchNotificationSettings(
                                notificationsSwitchStates);
                          })),
                  SettingsTile(
                      key: const Key('new_followers_tile'),
                      leadingIcon: const SettingsTileLeadingIcon(
                          leadingIcon: Icons.supervisor_account_rounded),
                      titleText: "New followers",
                      trailingWidget: CustomSwitch(
                          key: const Key('new_followers_switch'),
                          isSwitched: notificationsSwitchStates[
                              kNotificationSettingsNewFollowersSwitchIndex],
                          onChanged: (value) async {
                            setState(() {
                              notificationsSwitchStates[
                                      kNotificationSettingsNewFollowersSwitchIndex] =
                                  value;
                            });
                            await apiService!.patchNotificationSettings(
                                notificationsSwitchStates);
                          })),
                  const SettingsSegmentTitle(
                      key: Key('updates_title'), titleText: "Updates"),
                  SettingsTile(
                      key: const Key('cake_day_tile'),
                      leadingIcon: const SettingsTileLeadingIcon(
                          leadingIcon: FontAwesomeIcons.cakeCandles),
                      titleText: "Cake day",
                      trailingWidget: CustomSwitch(
                          key: const Key('cake_day_switch'),
                          isSwitched: notificationsSwitchStates[
                              kNotificationSettingsCakeDaySwitchIndex],
                          onChanged: (value) async {
                            setState(() {
                              notificationsSwitchStates[
                                      kNotificationSettingsCakeDaySwitchIndex] =
                                  value;
                            });
                            await apiService!.patchNotificationSettings(
                                notificationsSwitchStates);
                          })),
                  const SettingsSegmentTitle(
                      key: Key('modeartion_title'), titleText: "Moderation"),
                  SettingsTile(
                      key: const Key('mod_notifications_tile'),
                      leadingIcon: const SettingsTileLeadingIcon(
                          leadingIcon: Icons.notifications_none_rounded),
                      titleText: "Mod notifications",
                      trailingWidget: CustomSwitch(
                          key: const Key('mod_notifications_switch'),
                          isSwitched: notificationsSwitchStates[
                              kNotificationSettingsModNotificationsSwitchIndex],
                          onChanged: (value) async {
                            setState(() {
                              notificationsSwitchStates[
                                      kNotificationSettingsModNotificationsSwitchIndex] =
                                  value;
                            });
                            await apiService!.patchNotificationSettings(
                                notificationsSwitchStates);
                          })),
                ],
              ),
            ),
    );
  }
}
