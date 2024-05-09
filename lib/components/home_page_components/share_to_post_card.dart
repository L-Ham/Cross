import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:reddit_bel_ham/components/home_page_components/post_card.dart';
import 'package:reddit_bel_ham/constants.dart';
import 'package:reddit_bel_ham/utilities/screen_size_handler.dart';

class sharetoPostCard extends StatelessWidget {
  final Post post;
  sharetoPostCard({required this.post});

  @override
  Widget build(BuildContext context) {
    return buildShareToPostCard(context, post);
  }
}

buildShareToPostCard(BuildContext context, Post post) {
  return Container(
    margin: EdgeInsets.only(
      top: ScreenSizeHandler.screenHeight * 0.01,
      bottom: ScreenSizeHandler.screenHeight * 0.01,
    ),
    decoration: BoxDecoration(
      color: kBackgroundColor,
      borderRadius: BorderRadius.circular(ScreenSizeHandler.screenWidth * 0.05),
      border: Border.all(color: Color.fromARGB(255, 72, 71, 71)),
    ),
    height: ScreenSizeHandler.screenHeight * 0.15,
    width: ScreenSizeHandler.screenWidth * 0.9,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(
            left: ScreenSizeHandler.screenWidth * 0.025,
            right: ScreenSizeHandler.screenWidth * 0.025,
            top: post.type == 'image'
                ? ScreenSizeHandler.screenWidth * 0.025
                : ScreenSizeHandler.screenWidth * 0.04,
          ),
          child: Text(
            post.subredditName,
            style: TextStyle(
              color: const Color.fromARGB(255, 151, 150, 150),
              fontSize: ScreenSizeHandler.screenWidth * 0.028,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(
              post.type == 'image' ? 7 : ScreenSizeHandler.screenWidth * 0.025),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  post.contentTitle,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: ScreenSizeHandler.screenWidth * 0.035,
                  ),
                  overflow: TextOverflow.visible,
                ),
              ),
              if (post.type == 'image')
                Container(
                  width: ScreenSizeHandler.smaller * 0.18,
                  height: ScreenSizeHandler.screenHeight * 0.07,
                  child: Image.asset(
                    post.image[0],
                    fit: BoxFit.fitHeight,
                  ),
                ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: ScreenSizeHandler.screenWidth * 0.025),
          child: Text(
            "${post.upvotes} upvotes . ${post.comments} comments",
            style: TextStyle(
              color: const Color.fromARGB(255, 151, 150, 150),
              fontSize: ScreenSizeHandler.screenWidth * 0.028,
            ),
          ),
        ),
      ],
    ),
  );
}
