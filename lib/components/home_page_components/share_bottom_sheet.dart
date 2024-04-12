import 'package:flutter/material.dart';
import 'package:reddit_bel_ham/constants.dart';
import 'package:reddit_bel_ham/components/home_page_components/share_to_post_card.dart';
import 'package:reddit_bel_ham/components/home_page_components/post_card.dart';
import 'package:clipboard/clipboard.dart';
import 'package:reddit_bel_ham/utilities/screen_size_handler.dart';

Widget buildPostModalBottomSheet(BuildContext context, Post post) {
  return SafeArea(
    child: Container(
      decoration: BoxDecoration(
        color: kBackgroundColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
      padding: EdgeInsets.all(16.0),
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.35,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Share to...",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18.0,
              color: Colors.white,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 12.0, bottom: .0),
            child: sharetoPostCard(post: post),
          ),
          Container(
            width: ScreenSizeHandler.screenWidth * 0.9,
            child: Divider(
              color: Color.fromARGB(255, 72, 71, 71),
              thickness: 1.0,
            ),
          ),
          SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: Column(
                  children: [
                    Icon(Icons.account_circle_outlined, color: Colors.white),
                    Text(
                      'Profile',
                      style: TextStyle(color: Colors.white, fontSize: 10.0),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Icon(Icons.groups_2_outlined, color: Colors.white),
                    Text(
                      'Community',
                      style: TextStyle(color: Colors.white, fontSize: 10.0),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Icon(Icons.folder_copy_outlined, color: Colors.white),
                    Text(
                      'Save',
                      style: TextStyle(color: Colors.white, fontSize: 10.0),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  FlutterClipboard.copy(post.link).then((result) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Container(
                            padding: EdgeInsets.symmetric(horizontal: 10.0),
                            child: Text(
                              'Link copied to clipboard',
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50.0),
                            )),
                      ),
                    );

                  });
                },
                child: Column(
                  children: [
                    Icon(Icons.copy_outlined, color: Colors.white),
                    Text(
                      'Copy Link',
                      style: TextStyle(color: Colors.white, fontSize: 10.0),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Icon(Icons.more_horiz, color: Colors.white),
                    Text(
                      'More',
                      style: TextStyle(color: Colors.white, fontSize: 10.0),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
