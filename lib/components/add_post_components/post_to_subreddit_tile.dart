import 'package:flutter/material.dart';

import '../../utilities/screen_size_handler.dart';

class PostToSubredditTile extends StatelessWidget {
  const PostToSubredditTile(
      {super.key,
      required this.subredditName,
      required this.selectedSubredditName,
      required this.subredditImage,
      required this.numOfOnlineUsers,
      required this.onTap});

  final String subredditName;
  final String selectedSubredditName;
  final String subredditImage;
  final int numOfOnlineUsers;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(
            vertical: ScreenSizeHandler.screenHeight * 0.013),
        child: Row(
          children: [
            CircleAvatar(
              radius: ScreenSizeHandler.bigger * 0.032,
              backgroundColor: Colors.grey,
              child: subredditImage != 'assets/images/planet3.png' &&
                      subredditImage != 'assets/images/avatarDaniel.png'
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(35),
                      child: Image.network(subredditImage, fit: BoxFit.cover),
                    )
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(35),
                      child: Image.asset(
                        subredditImage == 'assets/images/avatarDaniel.png'
                            ? 'assets/images/avatarDaniel.png'
                            : 'assets/images/planet3.png',
                        fit: BoxFit.cover,
                      ),
                    ),
            ),
            Padding(
              padding:
                  EdgeInsets.only(left: ScreenSizeHandler.screenWidth * 0.02),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "r/$subredditName",
                    style: TextStyle(
                        fontSize: ScreenSizeHandler.bigger * 0.02,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  Row(
                    children: [
                      Text(
                        "$numOfOnlineUsers online",
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: ScreenSizeHandler.bigger * 0.016),
                      ),
                      if (subredditName != selectedSubredditName)
                        Text(
                          " \u00B7 recently visited",
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: ScreenSizeHandler.bigger * 0.016),
                        ),
                    ],
                  )
                ],
              ),
            ),
            const Spacer(),
            if (subredditName == selectedSubredditName)
              Icon(
                Icons.check,
                color: Colors.green,
                size: ScreenSizeHandler.bigger * 0.0275,
              )
          ],
        ),
      ),
    );
  }
}
