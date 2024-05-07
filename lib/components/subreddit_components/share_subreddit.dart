import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:reddit_bel_ham/components/home_page_components/post_card.dart';
import 'package:reddit_bel_ham/constants.dart';
import 'package:reddit_bel_ham/utilities/screen_size_handler.dart';
import 'package:reddit_bel_ham/components/subreddit_components/subreddit.dart';

class sharetoSubreddit extends StatelessWidget {
  final Subreddit subreddit;
  sharetoSubreddit({required this.subreddit});

  @override
  Widget build(BuildContext context) {
    return buildSharetoSubreddit(context, subreddit);
  }
}

buildSharetoSubreddit(BuildContext context, Subreddit subreddit) {
  return Container(
    margin: EdgeInsets.only(
      top: ScreenSizeHandler.screenHeight * 0.01,
      bottom: ScreenSizeHandler.screenHeight * 0.01,
    ),
    decoration: BoxDecoration(
      color: kBackgroundColor,
      borderRadius: BorderRadius.circular(ScreenSizeHandler.screenWidth * 0.05),
      border: Border.all(color: Color.fromARGB(255, 72, 71, 71)),
    ),
    height: ScreenSizeHandler.screenHeight * 0.15,
    width: ScreenSizeHandler.screenWidth * 0.9,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
            padding: EdgeInsets.only(
              left: ScreenSizeHandler.screenWidth * 0.025,
              right: ScreenSizeHandler.screenWidth * 0.025,
              top: ScreenSizeHandler.screenWidth * 0.03,
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: ScreenSizeHandler.bigger * 0.013,
                  foregroundImage:
                      subreddit.avatarImage != 'assets/images/planet3.png'
                          ? NetworkImage(subreddit.avatarImage)
                          : Image.asset('assets/images/planet3.png').image,
                ),
                SizedBox(
                  width: ScreenSizeHandler.screenWidth * 0.01,
                ),
                Text(
                  "r/${subreddit.name}",
                  style: TextStyle(
                    color: Color.fromARGB(255, 173, 164, 164),
                    fontSize: ScreenSizeHandler.screenWidth * 0.035,
                  ),
                ),
              ],
            )),
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: ScreenSizeHandler.screenWidth * 0.025,
              vertical: ScreenSizeHandler.screenWidth * 0.012),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  subreddit.description,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: ScreenSizeHandler.screenWidth * 0.047,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: ScreenSizeHandler.screenWidth * 0.025),
          child: Text(
            "${subreddit.followersCount} followers . ${subreddit.onlineCount} online",
            style: TextStyle(
              color: Color.fromARGB(255, 173, 164, 164),
              fontSize: ScreenSizeHandler.screenWidth * 0.032,
            ),
          ),
        ),
      ],
    ),
  );
}
