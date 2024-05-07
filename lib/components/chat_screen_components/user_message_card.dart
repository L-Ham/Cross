import 'package:flutter/material.dart';
import 'package:reddit_bel_ham/utilities/screen_size_handler.dart';

class Message {
  final String userName;
  final String avatarUrl;
  final String message;
  final String time;

  Message(
      {required this.userName,
      required this.avatarUrl,
      required this.message,
      required this.time});
}

class UserMessageCard extends StatefulWidget {
  final Message message;
  const UserMessageCard({
    required this.message,
    Key? key,
  }) : super(key: key);

  @override
  _UserMessageCardState createState() => _UserMessageCardState();
}

class _UserMessageCardState extends State<UserMessageCard> {
  @override
  Widget build(BuildContext context) {
    return buildUserMessageCard(widget.message, context);
  }

  Widget buildUserMessageCard(Message message, BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 10),
        child: Row(
          children: [
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      left: ScreenSizeHandler.screenWidth * 0.04),
                  child: CircleAvatar(
                    radius: ScreenSizeHandler.screenWidth * 0.035,
                    backgroundImage:
                        AssetImage('assets/images/avatarDaniel.png'),
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 10),
                      child: Text(
                        "${message.userName}",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: ScreenSizeHandler.screenWidth * 0.033,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left:ScreenSizeHandler.screenWidth * 0.01),
                      child: Text(
                        "${message.time}PM",
                        style: TextStyle( 
                            color: Color.fromARGB(255, 151, 151, 160),
                            fontSize: ScreenSizeHandler.screenWidth * 0.02,
                            fontWeight: FontWeight.normal),
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(left: 10),
                  child: Text(
                    message.message,
                    style: TextStyle(
                        color: Color.fromARGB(255, 151, 151, 160),
                        fontSize: ScreenSizeHandler.screenWidth * 0.03,
                        fontWeight: FontWeight.normal),
                  ),
                ),
              ],
            ),
          ],
        ));
  }
}
