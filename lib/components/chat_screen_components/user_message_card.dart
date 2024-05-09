import 'dart:io';

import 'package:flutter/material.dart';
import 'package:reddit_bel_ham/components/general_components/reddit_loading_indicator.dart';
import 'package:reddit_bel_ham/utilities/screen_size_handler.dart';

class Message {
  final String userName;
  final String avatarUrl;
  final String message;
  final String time;
  final bool isImage;
  final String imageURL;

  Message(
      {required this.userName,
      required this.avatarUrl,
      required this.message,
      required this.time,
      required this.isImage,
      required this.imageURL});
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Padding(
                padding:
                    EdgeInsets.only(left: ScreenSizeHandler.screenWidth * 0.04),
                child: CircleAvatar(
                  radius: ScreenSizeHandler.screenWidth * 0.035,
                  backgroundImage: NetworkImage(message.avatarUrl),
                ),
              ),
              SizedBox(
                  width: 10), // Add some space between the avatar and the text
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${message.userName}",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: ScreenSizeHandler.screenWidth * 0.033,
                        fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: ScreenSizeHandler.screenWidth * 0.02,
                        top: ScreenSizeHandler.screenWidth * 0.015),
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
            ],
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding:
                  EdgeInsets.only(left: ScreenSizeHandler.screenWidth * 0.13),
              child: message.isImage
                  ? GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return Dialog(
                              child: Stack(
                                alignment: Alignment.topRight,
                                children: <Widget>[
                                  Image.network(
                                    message.imageURL,
                                    width: MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context).size.height,
                                    fit: BoxFit.contain,
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.close),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                      child: Image.network(
                        message.imageURL,
                        width: ScreenSizeHandler.screenWidth * 0.6,
                        height: ScreenSizeHandler.screenHeight * 0.2,
                        loadingBuilder: (BuildContext context, Widget child,
                            ImageChunkEvent? loadingProgress) {
                          if (loadingProgress == null) return child;
                          return RedditLoadingIndicator();
                        },
                      ),
                    ) // Display image from network if isImage is true
                  : Text(
                      message.message,
                      style: TextStyle(
                          color: Color.fromARGB(255, 151, 151, 160),
                          fontSize: ScreenSizeHandler.screenWidth * 0.03,
                          fontWeight: FontWeight.normal),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
