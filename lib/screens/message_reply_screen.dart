import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:reddit_bel_ham/components/messaging_components/message_reply_tile.dart';
import 'package:reddit_bel_ham/constants.dart';
import 'package:reddit_bel_ham/screens/new_message_screen.dart';
import 'package:reddit_bel_ham/utilities/screen_size_handler.dart';
import 'package:reddit_bel_ham/utilities/token_decoder.dart';

import '../utilities/time_ago.dart';

class MessageReplyScreen extends StatefulWidget {
  const MessageReplyScreen({super.key});

  static const id = "message_reply_screen";

  @override
  State<MessageReplyScreen> createState() => _MessageReplyScreenState();
}

class _MessageReplyScreenState extends State<MessageReplyScreen> {
  late String subject;
  late String to;
  late List<dynamic> replies;
  bool isExpanded = true;
  String message = "Mnawar w 5osh (hena)[https://www.google.com]";
  String userName = "Daniel_Gebraiel";
  String parentMessageId = "";
  String publishedFrom = "7d";
  late Function ontap;

  @override
  void didChangeDependencies() {
    Map<String, dynamic> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    subject = args["subject"];
    to = args["to"];
    replies = args["replies"];
    ontap = args["onTap"];
    parentMessageId = args["parentMessageId"];
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: kBackgroundColor,
        automaticallyImplyLeading: true,
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(
                horizontal: ScreenSizeHandler.screenWidth * 0.045),
            width: ScreenSizeHandler.screenWidth,
            color: kBackgroundColor,
            child: Text(
              subject,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: ScreenSizeHandler.bigger * 0.0175,
                  fontWeight: FontWeight.w600),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: replies.length,
              itemBuilder: (context, i) {
                if (replies[i] != []) {
                  return MessageReplyTile(
                    userName: replies[i]["sender"],
                    publishedFrom: timeAgo(replies[i]["createdAt"]),
                    message: replies[i]["message"],
                  );
                } else {
                  return Container(); // return an empty container when replies[i] is empty
                }
              },
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, NewMessageScreen.id, arguments: {
                "isReply": true,
                "userName": to,
                "subject": subject,
                "parentMessageId": parentMessageId
              }).then((msg) {
                if (msg != null) {
                  setState(() {
                    replies.add({
                      "sender": TokenDecoder.username,
                      "createdAt": DateTime.now().toString(),
                      "message": msg
                    });
                  });
                  print(replies);
                }
              });
            },
            child: Container(
              width: ScreenSizeHandler.screenWidth,
              height: ScreenSizeHandler.screenHeight * 0.06,
              padding: EdgeInsets.only(
                  top: ScreenSizeHandler.screenHeight * 0.01,
                  left: ScreenSizeHandler.screenWidth * 0.03),
              color: kBackgroundColor,
              child: Text(
                "Reply to the Message",
                style: TextStyle(
                    color: Colors.grey[700],
                    fontWeight: FontWeight.w400,
                    fontSize: ScreenSizeHandler.bigger * 0.017),
              ),
            ),
          )
        ],
      ),
    );
  }
}
