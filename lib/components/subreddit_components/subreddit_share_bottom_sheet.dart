import 'package:flutter/material.dart';
import 'package:reddit_bel_ham/constants.dart';

import 'package:clipboard/clipboard.dart';
import 'package:reddit_bel_ham/utilities/screen_size_handler.dart';
import 'package:reddit_bel_ham/components/subreddit_components/subreddit.dart';
import 'package:reddit_bel_ham/components/subreddit_components/share_subreddit.dart';

Widget buildSubredditModalBottomSheet(
    BuildContext context, Subreddit subreddit) {
  return SafeArea(
    child: Container(
      height: ScreenSizeHandler.screenHeight * 0.41,
      decoration: BoxDecoration(
        color: kBackgroundColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Share to...",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: ScreenSizeHandler.bigger * 0.023,
              color: Colors.white,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 12.0, bottom: .0),
            child: sharetoSubreddit(subreddit: subreddit),
          ),
          Container(
            width: ScreenSizeHandler.screenWidth * 0.9,
            child: Divider(
              color: Color.fromARGB(255, 72, 71, 71),
              thickness: 1.0,
            ),
          ),
          SizedBox(height: ScreenSizeHandler.screenHeight * 0.01),
          Text(
            "Your username stays hidden when you share outside of Reddit.",
            style: TextStyle(
              color: Color.fromARGB(255, 173, 164, 164),
              fontSize: ScreenSizeHandler.screenWidth * 0.035,
            ),
          ),
          SizedBox(height: ScreenSizeHandler.screenHeight * 0.02),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  FlutterClipboard.copy(subreddit.link).then((result) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Link copied to clipboard!',
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                ScreenSizeHandler.screenWidth * 0.05)),
                      ),
                    );
                  });
                },
                child: Column(
                  children: [
                    Icon(Icons.copy_outlined, color: Colors.white),
                    Text(
                      'Copy Link',
                      style: TextStyle(color: Colors.white, fontSize: 10.0),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
