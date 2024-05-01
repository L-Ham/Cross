import 'package:flutter/material.dart';
import 'package:reddit_bel_ham/constants.dart';
import 'package:reddit_bel_ham/screens/message_reply_screen.dart';
import 'package:reddit_bel_ham/utilities/screen_size_handler.dart';

import '../general_components/linkified_text.dart';

class MessageTile extends StatelessWidget {
  const MessageTile(
      {super.key,
      required this.userName,
      required this.isRead,
      required this.publishedWhen,
      required this.subject,
      required this.message,
      required this.replies});

  final String userName;
  final bool isRead;
  final String publishedWhen;
  final String subject;
  final String message;
  final List<dynamic> replies;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, MessageReplyScreen.id, arguments: {
          "subject": subject,
          "to": userName,
          "replies": replies
        });
      },
      child: Container(
        padding: EdgeInsets.only(top: ScreenSizeHandler.screenHeight * 0.015),
        color: kBackgroundColor,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: ScreenSizeHandler.screenWidth * 0.04),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "$userName ",
                        style: TextStyle(
                            height: 0.9,
                            color: isRead ? Colors.grey[600] : Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: ScreenSizeHandler.bigger * 0.0175),
                      ),
                      Text(
                        "• $publishedWhen",
                        style: TextStyle(
                            height: 0.9,
                            color: isRead ? Colors.grey[700] : Colors.grey[600],
                            fontWeight: FontWeight.w500,
                            fontSize: ScreenSizeHandler.bigger * 0.015),
                      ),
                      const Spacer(),
                      Icon(
                        Icons.more_horiz,
                        size: ScreenSizeHandler.bigger * 0.026,
                        color: isRead ? Colors.grey[600] : Colors.grey[300],
                      ),
                    ],
                  ),
                  Text(
                    subject,
                    style: TextStyle(
                        height: 0.9,
                        color: isRead ? Colors.grey[600] : Colors.white,
                        fontSize: ScreenSizeHandler.bigger * 0.017),
                  ),
                  linkifiedText(
                    message,
                    TextStyle(
                        color: isRead ? Colors.grey[600] : Colors.white,
                        fontSize: ScreenSizeHandler.bigger * 0.017),
                    TextStyle(
                        color: isRead ? Colors.grey[600] : Colors.white,
                        fontSize: ScreenSizeHandler.bigger * 0.017),
                  ),
                ],
              ),
            ),
            Padding(
              padding:
                  EdgeInsets.only(top: ScreenSizeHandler.screenHeight * 0.015),
              child: Divider(
                color: Colors.grey[800],
                thickness: 0.5,
                height: 0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
