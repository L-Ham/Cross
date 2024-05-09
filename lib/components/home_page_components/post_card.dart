import 'package:flutter/material.dart';
import 'package:flutter_link_previewer/flutter_link_previewer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:reddit_bel_ham/components/general_components/avatar.dart';
import 'package:reddit_bel_ham/components/home_page_components/more_bottom_sheet.dart';
import 'package:reddit_bel_ham/components/home_page_components/poll_post_card.dart';
import 'package:reddit_bel_ham/components/home_page_components/share_bottom_sheet.dart';
import 'package:reddit_bel_ham/components/home_page_components/video_player.dart';
import 'package:reddit_bel_ham/constants.dart';
import 'package:reddit_bel_ham/utilities/screen_size_handler.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:reddit_bel_ham/components/subreddit_components/moderator_post_bottom_sheet.dart';

import 'package:reddit_bel_ham/utilities/post_voting.dart';

class Post {
  String postId;
  String userId;
  String userName;
  List<String> options = [];
  List<int> numOfVotersPerOption = [];
  bool isPollVoted = false;
  String? selectedPollOption;
  DateTime? startTime;
  DateTime? endTime;
  String subredditName;
  String avatarImage = 'assets/images/redditAvata2.png';
  String content;
  String contentTitle;
  String type;
  String link;
  String video;
  String subredditId;
  List<String> image;
  String createdFrom;
  int upvotes;
  int comments;
  int spamCount = 0;
  bool isUpvoted = false;
  bool isDownvoted = false;
  bool isNSFW = false;
  bool isSpoiler = false;
  bool isLocked = false;
  bool isApproved = false;
  bool isDisapproved = false;
  bool isOwner = false;
  bool isSaved = false;
  int? pollVotes = 0;

  var previewData;

  Post({
    required this.postId,
    required this.subredditName,
    //required this.userAvatarImage,
    required this.contentTitle,
    required this.content,
    required this.upvotes,
    required this.comments,
    required this.type,
    required this.link,
    required this.image,
    required this.video,
    required this.createdFrom,
    required this.userId,
    this.subredditId = "",
    this.userName = "",
    this.options = const [],
    this.numOfVotersPerOption = const [],
    this.isPollVoted = false,
    this.selectedPollOption,
    this.startTime,
    this.endTime,
    this.spamCount = 0,
    this.isUpvoted = false,
    this.isDownvoted = false,
    this.isNSFW = false,
    this.isSpoiler = false,
    this.isLocked = false,
    this.isApproved = false,
    this.isDisapproved = false,
    this.pollVotes = 0,
    this.avatarImage = 'assets/images/planet3.png',
    this.isOwner = false,
    this.isSaved = false
  });

  static fromJson(json) {}
}

class PostCard extends StatefulWidget {
  final Post post;
  final bool isModertor;
  final bool isExpanded;

  const PostCard(
      {required this.post, this.isModertor = false, this.isExpanded = false});

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
    final isOwner = widget.post.subredditName == 'r/DanielAdel';
    final isTypeVideo = widget.post.type == 'video';
    return buildPostCard(widget.post, isTypeImage, isTypeText, isTypeLink,
        isOwner, isTypePoll, context);
  }

  Future<void> _launchURL(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw 'Could not launch $url';
    }
  }

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
                  child: Avatar(
                    avatar: post.avatarImage,
                    radius: 15,
                  ),
                ),
                SizedBox(width: ScreenSizeHandler.screenWidth * 0.02),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.isExpanded
                            ? "r/${post.subredditName}"
                            : 'r/${post.subredditName} • ${post.createdFrom}',
                        style: TextStyle(
                            height: 0.8,
                            color: Colors.white,
                            fontSize: ScreenSizeHandler.bigger * 0.017,
                            fontWeight: FontWeight.w500),
                      ),
                      if (widget.isExpanded)
                        Row(
                          children: [
                            Text(
                              'u/${post.userName} ',
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: ScreenSizeHandler.bigger * 0.017,
                                  fontWeight: FontWeight.w400),
                            ),
                            Text(
                              '• ${post.createdFrom}',
                              style: TextStyle(
                                  color: Colors.grey[400],
                                  fontSize: ScreenSizeHandler.bigger * 0.017,
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
                if (post.isLocked)
                  Padding(
                    padding: EdgeInsets.only(
                        right: ScreenSizeHandler.screenWidth * 0.02),
                    child: Icon(
                      FontAwesomeIcons.lock,
                      color: Colors.amber[400],
                      size: ScreenSizeHandler.screenWidth * 0.03,
                    ),
                  ),
                if (post.isApproved && widget.isModertor)
                  Padding(
                    padding: EdgeInsets.only(
                        right: ScreenSizeHandler.screenWidth * 0.02),
                    child: Icon(
                      Icons.check,
                      color: kOnlineStatusColor,
                      size: ScreenSizeHandler.screenWidth * 0.05,
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
                  left: ScreenSizeHandler.screenWidth * 0.04,
                  top: ScreenSizeHandler.screenWidth * 0.01),
              child: Row(
                children: [
                  if (post.isNSFW)
                    Icon(
                      Icons.eighteen_up_rating,
                      color: Colors.pink,
                      size: ScreenSizeHandler.screenWidth * 0.055,
                    ),
                  if (post.isNSFW)
                    Text(
                      'NSFW',
                      style: TextStyle(
                        color: Colors.pink,
                        fontSize: ScreenSizeHandler.screenWidth * 0.035,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  SizedBox(width: ScreenSizeHandler.screenWidth * 0.01),
                  if (post.isSpoiler)
                    Icon(
                      FontAwesomeIcons.circleExclamation,
                      color: Colors.white,
                      size: ScreenSizeHandler.screenWidth * 0.04,
                    ),
                  if (post.isSpoiler)
                    Text(
                      ' SPOILER',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: ScreenSizeHandler.screenWidth * 0.035,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                ],
              ),
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
                        child: Padding(
                          padding: EdgeInsets.only(
                              right: ScreenSizeHandler.screenWidth * 0.02),
                          child: Text(
                            post.contentTitle,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: widget.isExpanded
                                  ? ScreenSizeHandler.bigger * 0.024
                                  : ScreenSizeHandler.bigger * 0.022,
                            ),
                            softWrap: true,
                          ),
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
                  if (widget.post.type == 'image') ...[
                    SizedBox(
                      height: ScreenSizeHandler.screenHeight *
                          0.6, // Adjust the height as needed
                      child: PageView.builder(
                        itemCount: post.image.length,
                        itemBuilder: (context, index) {
                          return widget.post.image[index].startsWith("http")
                              ? Image.network(
                                  post.image[index],
                                  fit: BoxFit.cover,
                                )
                              : Image.asset(
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
                  if (widget.post.type == 'text' || widget.isExpanded)
                    Padding(
                      padding: EdgeInsets.only(
                          top: widget.isExpanded
                              ? ScreenSizeHandler.screenHeight * 0.02
                              : ScreenSizeHandler.screenHeight * 0.005,
                          right: ScreenSizeHandler.screenWidth * 0.02,
                          bottom: ScreenSizeHandler.screenHeight * 0.015),
                      child: Text(
                        post.content,
                        maxLines: widget.isExpanded ? 100 : 3,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            height: 1.1,
                            color: widget.isExpanded
                                ? Colors.white
                                : const Color.fromARGB(255, 133, 132, 132),
                            fontWeight: FontWeight.normal,
                            fontSize: widget.isExpanded
                                ? ScreenSizeHandler.bigger * 0.02
                                : ScreenSizeHandler.bigger * 0.017),
                      ),
                    ),
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
                                        size: ScreenSizeHandler.bigger * 0.023,
                                      ),
                                      Text(
                                        post.upvotes.toString(),
                                        style: TextStyle(
                                            color: post.isUpvoted
                                                ? Colors.red
                                                : post.isDownvoted
                                                    ? const Color.fromARGB(
                                                        255, 110, 85, 114)
                                                    : Colors.white,
                                            fontSize: ScreenSizeHandler.bigger *
                                                0.020),
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
                                        size: ScreenSizeHandler.bigger * 0.023,
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
                                            size: ScreenSizeHandler.bigger *
                                                0.023,
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
                                                fontSize:
                                                    ScreenSizeHandler.bigger *
                                                        0.020),
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
                  if (!widget.isModertor)
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
                                    bottom:
                                        ScreenSizeHandler.screenWidth * 0.015,
                                    left: ScreenSizeHandler.screenWidth * 0.012,
                                    right:
                                        ScreenSizeHandler.screenWidth * 0.012,
                                  ),
                                  child: Icon(
                                    Icons.share,
                                    size: ScreenSizeHandler.bigger * 0.023,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            )),
                      ),
                    )
                  else
                    GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) =>
                              ModeratorPostBottomSheet(post: post),
                        );
                      },
                      child: Padding(
                        padding: EdgeInsets.only(
                            right: ScreenSizeHandler.screenWidth * 0.04),
                        child: Container(
                          width: ScreenSizeHandler.screenWidth * 0.1,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(18.0),
                            border: Border.all(
                              color: kFillingColor,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                  top: ScreenSizeHandler.screenWidth * 0.015,
                                  bottom: ScreenSizeHandler.screenWidth * 0.015,
                                  left: ScreenSizeHandler.screenWidth * 0.012,
                                  right: ScreenSizeHandler.screenWidth * 0.012,
                                ),
                                child: Icon(
                                  Icons.shield_outlined,
                                  size: ScreenSizeHandler.screenWidth * 0.037,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
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
