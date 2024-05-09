import 'package:flutter/material.dart';
import 'package:reddit_bel_ham/components/general_components/share_profile.dart';
import 'package:reddit_bel_ham/constants.dart';

import 'package:clipboard/clipboard.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:reddit_bel_ham/utilities/screen_size_handler.dart';
import 'package:share/share.dart';

Widget buildProfileModalBottomSheet(
    BuildContext context, String username,String avatarImage, String postKarma) {
  return SafeArea(
    child: Container(
      height: ScreenSizeHandler.screenHeight * 0.5,
      decoration: BoxDecoration(
        color: kBackgroundColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
      padding: EdgeInsets.symmetric(
        vertical: ScreenSizeHandler.screenHeight * 0.01,
        horizontal: ScreenSizeHandler.screenWidth * 0.05,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
              top: ScreenSizeHandler.screenHeight * 0.035,
              bottom: ScreenSizeHandler.screenHeight * 0.006,
            ),
            child: Text(
              "Share to...",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: ScreenSizeHandler.bigger * 0.023,
                color: Colors.white,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 12.0, bottom: .0),
            child: ShareToProfile(username: username, avatarImage: avatarImage, postKarma: postKarma),
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
                  FlutterClipboard.copy('https://reddit-bylham.me/user/$username').then((result) {
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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: ScreenSizeHandler.bigger * 0.025,
                      backgroundColor: Color.fromARGB(87, 158, 158, 158),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.copy_outlined, color: Colors.white),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: ScreenSizeHandler.screenHeight * 0.008,
                    ),
                    Text(
                      'Copy Link',
                      style: TextStyle(
                          color: kDisabledButtonColor,
                          fontSize: ScreenSizeHandler.bigger * 0.016),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: ScreenSizeHandler.screenWidth * 0.05),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context); 
                    Share.share('https://reddit-bylham.me/user/$username');
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: ScreenSizeHandler.bigger * 0.025,
                        backgroundColor: Color.fromARGB(87, 158, 158, 158),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(FontAwesomeIcons.ellipsis,
                                color: Colors.white),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: ScreenSizeHandler.screenHeight * 0.008,
                      ),
                      Text(
                        'More',
                        style: TextStyle(
                            color: kDisabledButtonColor,
                            fontSize: ScreenSizeHandler.bigger * 0.016),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
