import 'package:flutter/material.dart';
import 'package:reddit_bel_ham/constants.dart';
import 'package:reddit_bel_ham/components/home_page_components/share_to_post_card.dart';
import 'package:reddit_bel_ham/components/home_page_components/post_card.dart';
import 'package:clipboard/clipboard.dart';
import 'package:reddit_bel_ham/utilities/screen_size_handler.dart';

Widget buildMoreModalBottomSheetinbox(BuildContext context) {
  return SafeArea(
    child: SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
          color: kBackgroundColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
        ),
        padding: EdgeInsets.all(ScreenSizeHandler.screenWidth * 0.05),
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: ScreenSizeHandler.screenHeight * 0.01),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          right: ScreenSizeHandler.screenWidth * 0.025),
                      child: Icon(Icons.message_rounded,
                          color: Colors.white,
                          size: ScreenSizeHandler.screenWidth * 0.055),
                    ),
                    Text('New message', style: TextStyle(color: Colors.white)),
                  ],
                ),
                SizedBox(height: ScreenSizeHandler.screenHeight * 0.02),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          right: ScreenSizeHandler.screenWidth * 0.025),
                      child: Icon(Icons.mark_email_read_outlined,
                          color: Colors.white,
                          size: ScreenSizeHandler.screenWidth * 0.055),
                    ),
                    Text('Mark all inbox tabs as read',
                        style: TextStyle(color: Colors.white)),
                  ],
                ),
                SizedBox(height: ScreenSizeHandler.screenHeight * 0.02),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          right: ScreenSizeHandler.screenWidth * 0.025),
                      child: Icon(Icons.settings,
                          color: Colors.white,
                          size: ScreenSizeHandler.screenWidth * 0.055),
                    ),
                    Text('Edit notifications settings',
                        style: TextStyle(color: Colors.white)),
                  ],
                ),
                SizedBox(height: ScreenSizeHandler.screenHeight * 0.02),
                Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 30, 30, 30),
                    ),
                    child: Text('Close', style: TextStyle(color: Colors.white)),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
