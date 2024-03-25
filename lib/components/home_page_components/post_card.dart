import 'package:flutter/material.dart';
import 'package:reddit_bel_ham/constants.dart';
import 'package:reddit_bel_ham/components/home_page_components/share_to_post_card.dart';

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
              padding: EdgeInsets.all(8.0),
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
                  SizedBox(height: 8.0),
                  if (isTypeText)
                    Text(
                      post.content,
                      style: TextStyle(
                          color: const Color.fromARGB(255, 133, 132, 132),
                          fontWeight: FontWeight.normal),
                    ),
                  if (isTypeImage) Image.asset('assets/images/${post.image}'),
                  if (isTypeLink)
                    GestureDetector(
                        onTap: () {},
                        child: Text(post.link,
                            style: TextStyle(color: Colors.white)))
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
                              padding: const EdgeInsets.only(
                                  left: 8.0, right: 8.0, top: 2.0, bottom: 2.0),
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
                                if (post.isDownvoted){
                                  post.upvotes++;
                                  post.isDownvoted = !post.isDownvoted;
                                } else if (post.isUpvoted){
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
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.arrow_downward,
                                    color: post.isDownvoted
                                        ? const Color.fromARGB(255, 110, 85, 114)
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
                      onTap: () {
                  
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(right: 10.0, left: 10.0),
                              child: Row(
                                children: [
                                  Container(
                                      decoration: BoxDecoration(
                                        color: Colors.black,
                                        borderRadius: BorderRadius.circular(15.0),
                                        border: Border.all(
                                          color: kFillingColor,
                                        ),
                                      ),
                                      child: Row(children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Icon(
                                            Icons.comment,
                                            size: 15,
                                            color: Colors.white,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(4.0),
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
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
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
                              maxHeight:
                                  MediaQuery.of(context).size.height * 0.35,
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
                                  padding: const EdgeInsets.only(
                                      top: 12.0, bottom: .0),
                                  child: sharetoPostCard(post: post),
                                ), // Use the widget here
                                Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.9,
                                    child: Divider(
                                      color: Color.fromARGB(255, 72, 71, 71),
                                      thickness: 1.0,
                                    )),
        
                                SizedBox(height: 16.0),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        children: [
                                          Icon(Icons.account_circle_outlined,
                                              color: Colors.white),
                                          Text('Profile',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 10.0)),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        children: [
                                          Icon(Icons.groups_2_outlined,
                                              color: Colors.white),
                                          Text('Community',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 10.0)),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        children: [
                                          Icon(Icons.folder_copy_outlined,
                                              color: Colors.white),
                                          Text('Save',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 10.0)),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        children: [
                                          Icon(Icons.more_horiz,
                                              color: Colors.white),
                                          Text('More',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 10.0)),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                  child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        border: Border.all(
                          color: kFillingColor,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: Icon(
                                Icons.share,
                                size: 12,
                                color: Colors.white,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
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