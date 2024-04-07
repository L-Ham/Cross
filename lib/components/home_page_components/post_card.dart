import 'package:flutter/material.dart';
import 'package:reddit_bel_ham/components/home_page_components/share_bottom_sheet.dart';
import 'package:reddit_bel_ham/constants.dart';
import 'package:reddit_bel_ham/utilities/screen_size_handler.dart';
import 'package:url_launcher/url_launcher.dart';

class Post {
  final String username;
  final String content;
  final String contentTitle;
  final String type;
  final String link;
  final String image;
  int upvotes;
  int comments;
  bool isUpvoted = false;
  bool isDownvoted = false;

  Post({
    required this.username,
    required this.contentTitle,
    required this.content,
    required this.upvotes,
    required this.comments,
    required this.type,
    required this.link,
    required this.image,
  });
}

class PostCard extends StatefulWidget {
  final Post post;
  const PostCard({
    required this.post,
    Key? key,
  }) : super(key: key);

  @override
  _PostCardState createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  @override
  Widget build(BuildContext context) {
    final isTypeImage = widget.post.type == 'image';
    final isTypeText = widget.post.type == 'text';
    final isTypeLink = widget.post.type == 'link';
    final isOwner = widget.post.username == 'r/DanielAdel';
    return buildPostCard(
        widget.post, isTypeImage, isTypeText, isTypeLink, isOwner, context);
  }

  Future<void> _launchURL(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw 'Could not launch $url';
    }
  }

  bool isExpanded = false;

  Widget buildPostCard(Post post, bool isTypeImage, bool isTypeText,
      bool isTypeLink, bool isOwner, BuildContext context) {
    return Container(
      color: Colors.black,
      child: SingleChildScrollView(
        child: Column(
          children: [
            ListTile(
              leading: CircleAvatar(
                radius: 15,
                backgroundImage: AssetImage('assets/images/avatarDaniel.png'),
              ),
              title: Text(post.username, style: TextStyle(color: Colors.white)),
            ),
            Padding(
              padding: EdgeInsets.all(ScreenSizeHandler.screenWidth * 0.01),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    post.contentTitle,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                  SizedBox(height: ScreenSizeHandler.screenHeight * 0.02),
                  if (isTypeText)
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isExpanded = !isExpanded;
                        });
                      },
                      child: Text(
                        post.content,
                        maxLines: isExpanded ? 100:3,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: const Color.fromARGB(255, 133, 132, 132),
                            fontWeight: FontWeight.normal),
                      ),
                    ),
                  if (isTypeImage) Image.asset(post.image),
                  if (isTypeLink)
                    GestureDetector(
                        onTap: () {
                          _launchURL(post.link);
                        },
                        child: Text(
                          post.link,
                          style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.normal),
                        )),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(18.0),
                        border: Border.all(
                          color: kFillingColor,
                        ),
                      ),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                if (post.isUpvoted) {
                                  post.upvotes--;
                                  post.isUpvoted = !post.isUpvoted;
                                  post.isDownvoted = false;
                                } else if (post.isDownvoted) {
                                  post.upvotes += 2;
                                  post.isUpvoted = true;
                                  post.isDownvoted = false;
                                } else {
                                  post.upvotes++;
                                  post.isUpvoted = !post.isUpvoted;
                                }
                              });
                            },
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left: ScreenSizeHandler.screenWidth * 0.02,
                                  right: ScreenSizeHandler.screenWidth * 0.02,
                                  top: ScreenSizeHandler.screenWidth * 0.001,
                                  bottom:
                                      ScreenSizeHandler.screenWidth * 0.001),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.arrow_upward,
                                    color: post.isUpvoted
                                        ? Colors.red
                                        : Colors.white,
                                    size: 18.0,
                                  ),
                                  Text(
                                    post.upvotes.toString(),
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 12.0),
                                  )
                                ],
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                if (post.isDownvoted) {
                                  post.upvotes++;
                                  post.isDownvoted = !post.isDownvoted;
                                } else if (post.isUpvoted) {
                                  post.upvotes -= 2;
                                  post.isDownvoted = true;
                                  post.isUpvoted = false;
                                } else {
                                  post.upvotes--;
                                  post.isDownvoted = !post.isDownvoted;
                                }
                              });
                            },
                            child: Padding(
                              padding: EdgeInsets.all(
                                  ScreenSizeHandler.screenWidth * 0.01),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.arrow_downward,
                                    color: post.isDownvoted
                                        ? const Color.fromARGB(
                                            255, 110, 85, 114)
                                        : Colors.white,
                                    size: 18.0,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                right: ScreenSizeHandler.screenWidth * 0.02,
                                left: ScreenSizeHandler.screenWidth * 0.02),
                            child: Row(
                              children: [
                                Container(
                                    decoration: BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.circular(18.0),
                                      border: Border.all(
                                        color: kFillingColor,
                                      ),
                                    ),
                                    child: Row(children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Icon(
                                          Icons.mode_comment_outlined,
                                          size: 15,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left:
                                                ScreenSizeHandler.screenWidth *
                                                    0.01,
                                            right:
                                                ScreenSizeHandler.screenWidth *
                                                    0.02),
                                        child: Text(
                                          post.comments.toString(),
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12.0),
                                        ),
                                      )
                                    ])),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) =>
                          buildPostModalBottomSheet(context, widget.post),
                    );
                  },
                  child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18.0),
                        border: Border.all(
                          color: kFillingColor,
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(
                            ScreenSizeHandler.screenWidth * 0.007),
                        child: Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(
                                  ScreenSizeHandler.screenWidth * 0.006),
                              child: Icon(
                                Icons.share,
                                size: 12,
                                color: Colors.white,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(
                                  ScreenSizeHandler.screenWidth * 0.01),
                              child: Text("147",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  )),
                            ),
                          ],
                        ),
                      )),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
