import 'package:flutter/material.dart';

import '../../constants.dart';
import '../../screens/notifications_settings_screen.dart';
import '../../utilities/screen_size_handler.dart';
import '../settings_components/settings_tile.dart';
import '../settings_components/settings_tile_leading_icon.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:reddit_bel_ham/components/home_page_components/post_card.dart';
import 'package:reddit_bel_ham/services/api_service.dart';
import 'package:reddit_bel_ham/utilities/token_decoder.dart';

class ModeratorPostBottomSheet extends StatelessWidget {
  final Post post;
  bool isChanged = false;
  ModeratorPostBottomSheet({required this.post});

  ApiService apiService = ApiService(TokenDecoder.token);

  Future<void> markAsNSFW(String postId) async {
    await apiService.markAsNSFW(postId);
  }

  Future<void> unmarkAsNSFW(String postId) async {
    await apiService.unmarkAsNSFW(postId);
  }

  Future<void> markAsSpoiler(String postId) async {
    await apiService.markAsSpoiler(postId);
  }

  Future<void> unmarkAsSpoiler(String postId) async {
    await apiService.unmarkAsSpoiler(postId);
  }

  Future<void> lockPost(String postId) async {
    await apiService.lockPost(postId);
  }

  Future<void> unlockPost(String postId) async {
    await apiService.unlockPost(postId);
  }

  Future<void> approvePosts(String postId) async {
    await apiService.approvePost(postId);
  }

  Future<void> removePost(String postId) async {
    await apiService.removePost(postId);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenSizeHandler.screenWidth * 0.96,
      height: ScreenSizeHandler.screenHeight * 0.4,
      color: kBackgroundColor,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: ScreenSizeHandler.screenHeight * 0.0055),
              child: GestureDetector(
                onTap: () {
                  if (post.isSpoiler) {
                    unmarkAsSpoiler(post.postId);
                  } else {
                    markAsSpoiler(post.postId);
                  }
                  isChanged = true;
                  Navigator.pop(context, isChanged);
                },
                child: SettingsTile(
                    leadingIcon: SettingsTileLeadingIcon(
                      leadingIcon: FontAwesomeIcons.circleExclamation,
                    ),
                    titleText:
                        post.isSpoiler ? "Unmark spoiler" : "Mark spoiler"),
              ),
            ),
            GestureDetector(
              onTap: () async {
                if (post.isLocked) {
                  await unlockPost(post.postId);
                } else {
                  await lockPost(post.postId);
                }
                isChanged = true;
                Navigator.pop(context, isChanged);
              },
              child: Padding(
                padding: EdgeInsets.symmetric(
                    vertical: ScreenSizeHandler.screenHeight * 0.0055),
                child: SettingsTile(
                    leadingIcon: SettingsTileLeadingIcon(
                      leadingIcon: FontAwesomeIcons.lock,
                    ),
                    titleText:
                        post.isLocked ? "Unlock comments" : "Lock comments"),
              ),
            ),
            GestureDetector(
              onTap: () {
                if (post.isNSFW) {
                  unmarkAsNSFW(post.postId);
                } else {
                  markAsNSFW(post.postId);
                }
                isChanged = true;
                Navigator.pop(context, isChanged);
              },
              child: Padding(
                padding: EdgeInsets.symmetric(
                    vertical: ScreenSizeHandler.screenHeight * 0.0055),
                child: SettingsTile(
                    leadingIcon: SettingsTileLeadingIcon(
                      leadingIcon: Icons.eighteen_up_rating_outlined,
                    ),
                    titleText: post.isNSFW ? "Unmark NSFW" : "Mark NSFW"),
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: Padding(
                padding: EdgeInsets.symmetric(
                    vertical: ScreenSizeHandler.screenHeight * 0.0055),
                child: SettingsTile(
                    leadingIcon: SettingsTileLeadingIcon(
                      leadingIcon: FontAwesomeIcons.trash,
                    ),
                    titleText: "Remove post"),
              ),
            ),
            GestureDetector(
              onTap: () {
                removePost(post.postId);
                isChanged = false;
                Navigator.pop(context, isChanged);
              },
              child: Padding(
                padding: EdgeInsets.symmetric(
                    vertical: ScreenSizeHandler.screenHeight * 0.0055),
                child: SettingsTile(
                    leadingIcon: SettingsTileLeadingIcon(
                      leadingIcon: FontAwesomeIcons.calendarXmark,
                    ),
                    titleText: "Remove as spam"),
              ),
            ),
            GestureDetector(
              onTap: () {
                if (!post.isApproved) {
                  approvePosts(post.postId);
                }
                isChanged = true;
                Navigator.pop(context, isChanged);
              },
              child: Padding(
                padding: EdgeInsets.only(
                    left: ScreenSizeHandler.screenWidth * 0.045,
                    bottom: ScreenSizeHandler.screenHeight * 0.015,
                    top: ScreenSizeHandler.screenHeight * 0.008),
                child: Row(
                  children: [
                    Icon(FontAwesomeIcons.check,
                        color: post.isApproved
                            ? const Color.fromARGB(255, 56, 55, 55)
                            : Colors.grey,
                        size: ScreenSizeHandler.bigger * 0.025),
                    SizedBox(
                      width: ScreenSizeHandler.screenWidth * 0.045,
                    ),
                    Text(
                      post.isApproved ? "Approved" : "Approve",
                      style: TextStyle(
                        color: post.isApproved
                            ? const Color.fromARGB(255, 56, 55, 55)
                            : Colors.white,
                        fontSize:
                            ScreenSizeHandler.bigger * kSettingsTileTextRatio,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: ScreenSizeHandler.screenWidth * 0.04,
                    vertical: ScreenSizeHandler.screenHeight * 0.0055),
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
