import 'package:flutter/material.dart';
import 'package:reddit_bel_ham/screens/subreddit_screen.dart';
import 'package:reddit_bel_ham/utilities/go_to_profile.dart';

import '../../constants.dart';
import '../../utilities/screen_size_handler.dart';
import '../general_components/avatar.dart';

class SearchCommunitiesPeopleTile extends StatelessWidget {
  const SearchCommunitiesPeopleTile({
    required this.title,
    required this.description,
    required this.image,
    required this.isSubreddit,
    super.key,
  });

  final String title;
  final String description;
  final bool isSubreddit;
  final String image;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (isSubreddit) {
          Navigator.pushNamed(context, SubredditScreen.id, arguments: title);
        } else {
          // go to user profile screen
          goToProfile(context, title.replaceFirst('u/', ''));
        }
      },
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: ScreenSizeHandler.screenWidth * 0.05,
                vertical: isSubreddit
                    ? ScreenSizeHandler.screenHeight * 0.01
                    : ScreenSizeHandler.screenHeight * 0.005),
            child: GestureDetector(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Avatar(
                    avatar: image,
                    radius: ScreenSizeHandler.bigger * 0.025,
                    defaultImg: isSubreddit
                        ? "assets/images/planet3.png"
                        : "assets/images/redditAvata2.png",
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: ScreenSizeHandler.screenWidth * 0.02),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          isSubreddit ? 'r/$title' : 'u/$title',
                          style: TextStyle(
                            fontSize: ScreenSizeHandler.bigger * 0.0165,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          isSubreddit ? '$description members' : description,
                          style: TextStyle(
                              fontSize: ScreenSizeHandler.bigger * 0.014,
                              color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      if (isSubreddit) {
                        // join subreddit
                      } else {
                        // follow user
                      }
                    },
                    child: Container(
                      height: ScreenSizeHandler.bigger * 0.035,
                      width: isSubreddit
                          ? ScreenSizeHandler.bigger * 0.055
                          : ScreenSizeHandler.bigger * 0.07,
                      decoration: BoxDecoration(
                        color: kSwitchOnColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: Text(
                          isSubreddit ? 'Join' : 'Follow',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: ScreenSizeHandler.bigger * 0.0148,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Divider(
            color: Colors.grey[700],
            thickness: 0.5,
          )
        ],
      ),
    );
  }
}
