import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:reddit_bel_ham/components/home_page_components/post_card.dart';
import 'package:reddit_bel_ham/constants.dart';
import 'package:reddit_bel_ham/utilities/screen_size_handler.dart';
import 'package:reddit_bel_ham/components/subreddit_components/subreddit.dart';

class ShareToProfile extends StatelessWidget {
  final username;
  final avatarImage;
  final postKarma;
  ShareToProfile({required this.username, required this.avatarImage, required this.postKarma});
  @override
  Widget build(BuildContext context) {
    return buildSharetoProfile(context, username, avatarImage, postKarma);
  }
}

buildSharetoProfile(BuildContext context, String username,String avatarImage, String postKarma) {
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
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Padding(
            padding: EdgeInsets.only(
              left: ScreenSizeHandler.screenWidth * 0.025,
              right: ScreenSizeHandler.screenWidth * 0.025,
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: ScreenSizeHandler.bigger * 0.013,
                  foregroundImage:
                      avatarImage != 'assets/images/planet3.png'
                          ? NetworkImage(avatarImage)
                          : Image.asset('assets/images/planet3.png').image,
                ),
                SizedBox(
                  width: ScreenSizeHandler.screenWidth * 0.01,
                ),
                Text(
                  "u/${username}",
                  style: TextStyle(
                    color: Color.fromARGB(255, 173, 164, 164),
                    fontSize: ScreenSizeHandler.screenWidth * 0.036,
                  ),
                ),
              ],
            )),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: ScreenSizeHandler.screenWidth * 0.025,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  'Check out this profile on Reddit',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: ScreenSizeHandler.screenWidth * 0.045,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            left: ScreenSizeHandler.screenWidth * 0.025,
          ),
          child: Text(
            "$postKarma karma",
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
