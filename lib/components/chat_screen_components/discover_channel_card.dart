import 'package:flutter/material.dart';
import 'package:reddit_bel_ham/constants.dart';
import 'package:reddit_bel_ham/utilities/screen_size_handler.dart';

class channelCard extends StatefulWidget {
  const channelCard({Key? key}) : super(key: key);
  @override
  _channelCardState createState() => _channelCardState();
}

class _channelCardState extends State<channelCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenSizeHandler.screenWidth * 0.9,
      child: Container(
        decoration: BoxDecoration(
          borderRadius:
              BorderRadius.circular(ScreenSizeHandler.screenWidth * 0.03),
          border: Border.all(
            color: Color.fromARGB(255, 72, 71, 71),
            width: 1.0,
          ),
        ),
        margin: EdgeInsets.all(
          ScreenSizeHandler.screenHeight * 0.02,
        ),
        padding: EdgeInsets.only(
          right: ScreenSizeHandler.screenWidth * 0.01,
          left: ScreenSizeHandler.screenWidth * 0.01,
          top: ScreenSizeHandler.screenHeight * 0.01,
          bottom: ScreenSizeHandler.screenHeight * 0.01,
        ),
        child: Row(
          children: [
            Flexible(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        left: ScreenSizeHandler.screenWidth * 0.02),
                    child: CircleAvatar(
                      radius: ScreenSizeHandler.screenWidth * 0.035,
                      backgroundImage:
                          AssetImage('assets/images/avatarDaniel.png'),
                    ),
                  ),
                ],
              ),
            ),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: ScreenSizeHandler.screenWidth * 0.6,
                    ),
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                              left: ScreenSizeHandler.screenWidth * 0.02),
                          child: Text(
                            "Foodies Channel",
                            style: TextStyle(
                              fontSize: ScreenSizeHandler.screenWidth * 0.03,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        left: ScreenSizeHandler.screenWidth * 0.019),
                    child: Text(
                      "Food & Recipes . 166 recent messages",
                      style: TextStyle(
                        fontSize: ScreenSizeHandler.screenWidth * 0.025,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
