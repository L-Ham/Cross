import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:reddit_bel_ham/utilities/screen_size_handler.dart';

import '../../constants.dart';
import '../general_components/linkified_text.dart';

class MessageReplyTile extends StatefulWidget {
  const MessageReplyTile(
      {super.key,
      required this.userName,
      required this.publishedFrom,
      required this.message,
      required this.subject});

  final String userName;
  final String publishedFrom;
  final String message;
  final String subject;

  @override
  State<MessageReplyTile> createState() => _MessageReplyTileState();
}

class _MessageReplyTileState extends State<MessageReplyTile> {
  bool isExpanded = true;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isExpanded = !isExpanded;
        });
      },
      child: Container(
        padding: EdgeInsets.only(
            top: ScreenSizeHandler.screenHeight * 0.017,
            bottom: ScreenSizeHandler.screenHeight * 0.01,
            left: ScreenSizeHandler.screenWidth * 0.045,
            right: ScreenSizeHandler.screenWidth * 0.045),
        color: kBackgroundColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  isExpanded
                      ? Icons.keyboard_arrow_down
                      : Icons.keyboard_arrow_right,
                  color: Colors.grey,
                  size: ScreenSizeHandler.bigger * 0.026,
                ),
                Text(
                  '  ${widget.userName} • ${widget.publishedFrom}',
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: ScreenSizeHandler.bigger * 0.015),
                ),
                const Spacer(),
                Icon(
                  Icons.more_horiz,
                  size: ScreenSizeHandler.bigger * 0.026,
                  color: Colors.grey[500],
                ),
              ],
            ),
            if (isExpanded)
              Padding(
                padding: EdgeInsets.only(
                    top: ScreenSizeHandler.screenHeight * 0.012),
                child: widget.subject ==
                        "You have been invited to moderate a subreddit"
                    ? GestureDetector(
                        onTap: () {
                          print('bala7');
                        },
                        child: Html(
                          data: widget.message,
                          style: {
                            "body": Style(
                              color: Colors.white,
                              fontSize:
                                  FontSize(ScreenSizeHandler.bigger * 0.017),
                            ),
                          },
                        ),
                      )
                    : linkifiedText(
                        widget.message,
                        TextStyle(
                            color: Colors.white,
                            fontSize: ScreenSizeHandler.bigger * 0.017),
                        TextStyle(
                            color: Colors.blue,
                            fontSize: ScreenSizeHandler.bigger * 0.017),
                      ),
              )
          ],
        ),
      ),
    );
  }
}
