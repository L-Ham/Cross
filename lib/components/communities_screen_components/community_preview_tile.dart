import 'package:flutter/material.dart';
import 'package:reddit_bel_ham/constants.dart';
import '../../screens/subreddit_screen.dart';
import '../../utilities/screen_size_handler.dart';
import '../general_components/avatar.dart';

class CommunityPreviewTile extends StatelessWidget {
  const CommunityPreviewTile({
    required this.id,
    required this.subredditName,
    required this.numOfMembers,
    required this.description,
    required this.image,
    super.key,
  });

  final String id;
  final String subredditName;
  final String numOfMembers;
  final String description;
  final String image;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, SubredditScreen.id,
            arguments: subredditName);
      },
      child: Container(
        padding: EdgeInsets.only(
            top: ScreenSizeHandler.screenHeight * 0.01,
            left: ScreenSizeHandler.screenWidth * 0.025,
            right: ScreenSizeHandler.screenWidth * 0.025),
        decoration: BoxDecoration(
          color: Colors.black,
          border: Border.all(
            color: Colors.grey[700]!,
            width: 0.5,
          ),
          borderRadius: BorderRadius.circular(12.0),
        ),
        height: ScreenSizeHandler.bigger * 0.115,
        width: ScreenSizeHandler.bigger * 0.38,
        child: Column(
          children: [
            Row(
              children: [
                Avatar(
                  avatar: image,
                  radius: ScreenSizeHandler.bigger * 0.0245,
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: ScreenSizeHandler.screenWidth * 0.02),
                  child: SizedBox(
                    width: ScreenSizeHandler.screenWidth * 0.4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          subredditName,
                          style: TextStyle(
                              fontSize: ScreenSizeHandler.bigger * 0.018,
                              fontWeight: FontWeight.w600,
                              color: Colors.white),
                        ),
                        Text(
                          '$numOfMembers members',
                          style: TextStyle(
                              fontSize: ScreenSizeHandler.bigger * 0.015,
                              color: Colors.grey[600],
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                ),
                const Spacer(),
                Container(
                  height: ScreenSizeHandler.bigger * 0.035,
                  width: ScreenSizeHandler.bigger * 0.055,
                  decoration: BoxDecoration(
                    color: kSwitchOnColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Text(
                      'Join',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: ScreenSizeHandler.bigger * 0.0148,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                )
              ],
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(
                    top: ScreenSizeHandler.screenHeight * 0.006),
                child: Text(
                  description,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 4,
                  style: TextStyle(
                      height: 1.1,
                      fontSize: ScreenSizeHandler.bigger * 0.015,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w400),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
