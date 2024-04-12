import 'package:flutter/material.dart';
import 'package:reddit_bel_ham/constants.dart';
import 'package:reddit_bel_ham/components/home_page_components/share_to_post_card.dart';
import 'package:reddit_bel_ham/components/home_page_components/post_card.dart';
import 'package:clipboard/clipboard.dart';
import 'package:reddit_bel_ham/utilities/screen_size_handler.dart';

Widget buildMoreModalBottomSheet(BuildContext context, Post post) {
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
            Padding(
              padding: EdgeInsets.only(bottom: ScreenSizeHandler.screenHeight * 0.005),
              child: Text(
                "More actions...",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: ScreenSizeHandler.screenWidth * 0.035, 
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: ScreenSizeHandler.screenHeight * 0.01), 
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: ScreenSizeHandler.screenWidth * 0.025),
                      child: Icon(Icons.bookmark_border_outlined, color: Colors.white,size:ScreenSizeHandler.screenWidth * 0.055),
                    ),
                    Text('Save', style: TextStyle(color: Colors.white)),
                  ],
                ),
                SizedBox(height: ScreenSizeHandler.screenHeight * 0.02), 
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: ScreenSizeHandler.screenWidth * 0.025),
                      child: Icon(Icons.copy_rounded, color: Colors.white,size:ScreenSizeHandler.screenWidth * 0.055),
                    ),
                    Text('Copy text', style: TextStyle(color: Colors.white)),
                  ],
                ),
                SizedBox(height: ScreenSizeHandler.screenHeight * 0.02),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: ScreenSizeHandler.screenWidth * 0.025),
                      child: Icon(Icons.groups_2_outlined, color: Colors.white,size:ScreenSizeHandler.screenWidth * 0.055),
                    ),
                    Text('Crosspost to a community', style: TextStyle(color: Colors.white)),
                  ],
                ),
                SizedBox(height: ScreenSizeHandler.screenHeight * 0.02),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: ScreenSizeHandler.screenWidth * 0.025),
                      child: Icon(Icons.outlined_flag_outlined,color: Color.fromARGB(255, 204, 90, 90),size:ScreenSizeHandler.screenWidth * 0.055),
                    ),
                    Text('Report', style: TextStyle(color: Color.fromARGB(255, 204, 90, 90))),
                  ],
                ),
                SizedBox(height: ScreenSizeHandler.screenHeight * 0.02),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: ScreenSizeHandler.screenWidth * 0.025),
                      child: Icon(Icons.block, color:  Color.fromARGB(255, 204, 90, 90),size:ScreenSizeHandler.screenWidth * 0.055),
                    ),
                    Text('Block account', style: TextStyle(color: Color.fromARGB(255, 204, 90, 90))),
                  ],
                ),
                SizedBox(height: ScreenSizeHandler.screenHeight * 0.02),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: ScreenSizeHandler.screenWidth * 0.025),
                      child: Icon(Icons.remove_red_eye_outlined, color: Colors.white,size:ScreenSizeHandler.screenWidth * 0.055),
                    ),
                    Text('Hide', style: TextStyle(color: Colors.white)),
                  ],
                ),
                
              ],
            ),
          ],
        ),
      ),
    ),
  );
}

