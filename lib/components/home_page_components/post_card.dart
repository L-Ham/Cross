import 'package:any_link_preview/any_link_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_link_previewer/flutter_link_previewer.dart';
import 'package:reddit_bel_ham/components/home_page_components/more_bottom_sheet.dart';
import 'package:reddit_bel_ham/components/home_page_components/poll_post_card.dart';
import 'package:reddit_bel_ham/components/home_page_components/share_bottom_sheet.dart';
import 'package:reddit_bel_ham/components/home_page_components/video_player.dart';
import 'package:reddit_bel_ham/constants.dart';
import 'package:reddit_bel_ham/utilities/screen_size_handler.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';
import 'package:reddit_bel_ham/utilities/post_voting.dart';

class Post {
  final String username;
  final String content;
  final String contentTitle;
  final String type;
  final String link;
  final String video;
  final List<String> image;
  int upvotes;
  int comments;
  bool isUpvoted = false;
  bool isDownvoted = false;
  int? pollVotes = 0;
  var previewData;

  Post(
      {required this.username,
      required this.contentTitle,
      required this.content,
      required this.upvotes,
      required this.comments,
      required this.type,
      required this.link,
      required this.image,
      required this.video});

  static fromJson(json) {}
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
    final isTypePoll = widget.post.type == 'poll';
    final isOwner = widget.post.username == 'r/DanielAdel';
    final isTypeVideo = widget.post.type == 'video';
    return buildPostCard(widget.post, isTypeImage, isTypeText, isTypeLink,
        isOwner, isTypePoll, context);
  }

  Future<void> _launchURL(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw 'Could not launch $url';
    }
  }

  bool isExpanded = false;


  Widget buildPostCard(Post post, bool isTypeImage, bool isTypeText,
      bool isTypePoll, bool isTypeLink, bool isOwner, BuildContext context) {
    return Container(
      color: kPostColor,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      left: ScreenSizeHandler.screenWidth * 0.04),
                  child: CircleAvatar(
                    radius: ScreenSizeHandler.screenWidth * 0.03,
                    backgroundImage:
                        const AssetImage('assets/images/avatarDaniel.png'),
                  ),
                ),
                SizedBox(width: ScreenSizeHandler.screenWidth * 0.02),
                Expanded(
                  child: Text(
                    '${post.username}   7h',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: ScreenSizeHandler.screenWidth * 0.025,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      right: ScreenSizeHandler.screenWidth * 0.02),
                  child: GestureDetector(
                    onTap: () => showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) =>
                          buildMoreModalBottomSheet(context, widget.post),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(
                          right: ScreenSizeHandler.screenWidth * 0.04),
                      child: Icon(
                        Icons.more_horiz_outlined,
                        color: const Color.fromARGB(255, 191, 188, 188),
                        size: ScreenSizeHandler.screenWidth * 0.05,
                      ),
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.only(
                right: ScreenSizeHandler.screenWidth * 0.01,
                left: ScreenSizeHandler.screenWidth * 0.04,
                top: ScreenSizeHandler.screenWidth * 0.01,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          post.contentTitle,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: ScreenSizeHandler.screenWidth * 0.038,
                          ),
                          softWrap: true,
                        ),
                      ),
                      if (post.type == 'link')
                        GestureDetector(
                          onTap: () => {
                            _launchURL(post.link),
                          },
                          child: LinkPreview(
                            padding: EdgeInsets.only(
                                bottom: ScreenSizeHandler.screenHeight * 0.05,
                                right: ScreenSizeHandler.screenWidth * 0.02),
                            metadataTextStyle:
                                const TextStyle(fontSize: 0, height: 0),
                            metadataTitleStyle:
                                const TextStyle(fontSize: 0, height: 0),
                            textStyle: const TextStyle(fontSize: 0, height: 0),
                            enableAnimation: true,
                            onPreviewDataFetched: (data) {
                              setState(() {
                                post.previewData = data;
                              });
                            },
                            previewData: post.previewData,
                            text: post.link,
                            width: ScreenSizeHandler.screenWidth * 0.25,
                          ),
                        ),
                    ],
                  ),
                  if (widget.post.type == 'text')
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isExpanded = !isExpanded;
                        });
                      },
                      child: Text(
                        post.content,
                        maxLines: isExpanded ? 100 : 3,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: const Color.fromARGB(255, 133, 132, 132),
                            fontWeight: FontWeight.normal,
                            fontSize: ScreenSizeHandler.screenWidth * 0.026),
                      ),
                    ),
                  if (widget.post.type == 'image') ...[
                    SizedBox(
                      height: ScreenSizeHandler.screenHeight *
                          0.6, // Adjust the height as needed
                      child: PageView.builder(
                        itemCount: post.image.length,
                        itemBuilder: (context, index) {
                          return Image.asset(
                            post.image[index],
                            fit: BoxFit.cover,
                          );
                        },
                      ),
                    ),
                  ],
                  if (widget.post.type == 'poll') PollPost(post: post),
                  if (widget.post.type == 'video') ...[
                    VideoPlayerWidget(videoPath: post.video),
                  ],
                ],
              ),
            ),
            Padding(
              padding:
                  EdgeInsets.only(left: ScreenSizeHandler.screenWidth * 0.015),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            left: ScreenSizeHandler.screenWidth * 0.02),
                        child: Container(
                          decoration: BoxDecoration(
                            color: kPostColor,
                            borderRadius: BorderRadius.circular(
                                ScreenSizeHandler.screenWidth * 0.05),
                            border: Border.all(
                              color: kFillingColor,
                            ),
                          ),
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    upVoteHandler(post);
                                  });
                                },
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      left:
                                          ScreenSizeHandler.screenWidth * 0.02,
                                      right:
                                          ScreenSizeHandler.screenWidth * 0.02,
                                      top:
                                          ScreenSizeHandler.screenWidth * 0.001,
                                      bottom: ScreenSizeHandler.screenWidth *
                                          0.001),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.arrow_upward,
                                        color: post.isUpvoted
                                            ? Colors.red
                                            : Colors.white,
                                        size: ScreenSizeHandler.screenWidth *
                                            0.04,
                                      ),
                                      Text(
                                        post.upvotes.toString(),
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize:
                                                ScreenSizeHandler.screenWidth *
                                                    0.025),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: ScreenSizeHandler.bigger *
                                                0.01),
                                        child: Container(
                                          width:
                                              ScreenSizeHandler.bigger * 0.001,
                                          height:
                                              ScreenSizeHandler.bigger * 0.02,
                                          color: const Color.fromARGB(
                                              102, 127, 126, 126),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    downVoteHandler(post);
                                  });
                                },
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      bottom:
                                          ScreenSizeHandler.screenWidth * 0.01,
                                      top: ScreenSizeHandler.screenWidth * 0.01,
                                      right:
                                          ScreenSizeHandler.screenWidth * 0.01,
                                      left: ScreenSizeHandler.screenWidth *
                                          0.001),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.arrow_downward,
                                        color: post.isDownvoted
                                            ? const Color.fromARGB(
                                                255, 110, 85, 114)
                                            : Colors.white,
                                        size: ScreenSizeHandler.screenWidth *
                                            0.04,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
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
                                        color: kPostColor,
                                        borderRadius: BorderRadius.circular(
                                            ScreenSizeHandler.screenWidth *
                                                0.05),
                                        border: Border.all(
                                          color: kFillingColor,
                                        ),
                                      ),
                                      child: Row(children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                            top: ScreenSizeHandler.screenWidth *
                                                0.015,
                                            bottom:
                                                ScreenSizeHandler.screenWidth *
                                                    0.015,
                                            left:
                                                ScreenSizeHandler.screenWidth *
                                                    0.012,
                                            right:
                                                ScreenSizeHandler.screenWidth *
                                                    0.012,
                                          ),
                                          child: Icon(
                                            Icons.mode_comment_outlined,
                                            size:
                                                ScreenSizeHandler.screenWidth *
                                                    0.036,
                                            color: Colors.white,
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: ScreenSizeHandler
                                                      .screenWidth *
                                                  0.01,
                                              right: ScreenSizeHandler
                                                      .screenWidth *
                                                  0.02),
                                          child: Text(
                                            post.comments.toString(),
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: ScreenSizeHandler
                                                        .screenWidth *
                                                    0.025),
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
                    child: Padding(
                      padding: EdgeInsets.only(
                          right: ScreenSizeHandler.screenWidth * 0.04),
                      child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(18.0),
                            border: Border.all(
                              color: kFillingColor,
                            ),
                          ),
                          child: Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                  top: ScreenSizeHandler.screenWidth * 0.015,
                                  bottom: ScreenSizeHandler.screenWidth * 0.015,
                                  left: ScreenSizeHandler.screenWidth * 0.012,
                                  right: ScreenSizeHandler.screenWidth * 0.012,
                                ),
                                child: Icon(
                                  Icons.share,
                                  size: ScreenSizeHandler.screenWidth * 0.037,
                                  color: Colors.white,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: ScreenSizeHandler.screenWidth * 0.01,
                                    right: ScreenSizeHandler.screenWidth * 0.02,
                                    top: ScreenSizeHandler.screenWidth * 0.01,
                                    bottom:
                                        ScreenSizeHandler.screenWidth * 0.01),
                                child: Text("147",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize:
                                          ScreenSizeHandler.screenWidth * 0.025,
                                    )),
                              ),
                            ],
                          )),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(
              color: kFillingColor,
              thickness: 1,
            ),
          ],
        ),
      ),
    );
  }
}
