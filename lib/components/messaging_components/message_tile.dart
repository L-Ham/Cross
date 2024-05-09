import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:reddit_bel_ham/constants.dart';
import 'package:reddit_bel_ham/screens/message_reply_screen.dart';
import 'package:reddit_bel_ham/services/api_service.dart';
import 'package:reddit_bel_ham/utilities/screen_size_handler.dart';
import 'package:reddit_bel_ham/utilities/token_decoder.dart';

import '../general_components/linkified_text.dart';

class MessageTile extends StatelessWidget {
  const MessageTile(
      {super.key,
      required this.messageId,
      required this.userName,
      required this.isRead,
      required this.publishedWhen,
      required this.subject,
      required this.message,
      required this.replies,
      required this.onTap});

  final String userName;
  final bool isRead;
  final String publishedWhen;
  final String subject;
  final String message;
  final List<dynamic> replies;
  final String messageId;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final String lastMsgId = replies.last['messageId'];
        ApiService apiService = ApiService(TokenDecoder.token);
        Navigator.pushNamed(context, MessageReplyScreen.id, arguments: {
          "subject": subject,
          "to": userName,
          "replies": replies,
          "parentMessageId": messageId,
          "onTap": onTap,
        }).then((_) async {
          await apiService.markAsRead(lastMsgId);
          await onTap();
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
                  subject == "You have been invited to moderate a subreddit"
                      ? Html(
                          data: message,
                          style: {
                            "body": Style(
                              color: isRead ? Colors.grey[600] : Colors.white,
                              fontSize:
                                  FontSize(ScreenSizeHandler.bigger * 0.017),
                            ),
                          },
                        )
                      : linkifiedText(
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
