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
import 'package:reddit_bel_ham/utilities/token_decoder.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:reddit_bel_ham/components/subreddit_components/moderator_post_bottom_sheet.dart';
import 'package:reddit_bel_ham/utilities/time_ago.dart';
import 'package:reddit_bel_ham/services/api_service.dart';
import 'package:reddit_bel_ham/utilities/post_voting.dart';

class Post {
  String postId;
  String userId;
  String userAvatarImage;
  String userName;
  List<String> options = [];
  List<int> numOfVotersPerOption = [];
  bool isPollVoted = false;
  String? selectedPollOption;
  DateTime? startTime;
  DateTime? endTime;
  String subredditName = "";
  String avatarImage = 'assets/images/redditAvata2.png';
  String content;
  String contentTitle;
  String type;
  String link;
  String video;
  String subredditId;
  List<String> image = [];
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

  Post(
      {required this.postId,
      this.subredditName = "Dragon Oath",
      this.userAvatarImage = "assets/images/avatarDaniel.png",
      this.userName = "thekey119",
      required this.contentTitle,
      required this.content,
      required this.upvotes,
      required this.comments,
      required this.type,
      required this.link,
      this.image = const [],
      required this.video,
      required this.createdFrom,
      required this.userId,
      this.subredditId = "",
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
      this.isSaved = false});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      postId: json['_id'] ?? '',
      userId: json['user'] ?? '',
      userAvatarImage:
          json['creatorAvatarImage'] ?? "assets/images/avatarDaniel.png",
      userName: json['creatorUsername'] ?? 'thekey119',
      subredditName: json['subredditName'] ?? '',
      options: json['poll'] != null && json['poll']['options'] != null
          ? (json['poll']['options'] as List)
              .map((option) => option['option'] as String)
              .toList()
          : [],
      numOfVotersPerOption:
          json['poll'] != null && json['poll']['options'] != null
              ? (json['poll']['options'] as List)
                  .map((option) => (option['voters'] as List).length)
                  .toList()
              : [],
      selectedPollOption: json['poll']['options'].firstWhere(
          (option) =>
              (option['voters'] as List<dynamic>).contains(TokenDecoder.id),
          orElse: () => {"option": null})['option'],
      isPollVoted: json['poll'] == null ||
              json['poll']['options'] == null ||
              json['poll']['options'].isEmpty
          ? false
          : (json['poll']['options'] as List).any((option) =>
              option['voters'] == null
                  ? false
                  : (option['voters'] as List).contains(TokenDecoder.id)),
      startTime: json['poll'] == null || json['poll']['startTime'] == null
          ? null
          : DateTime.parse(json['poll']['startTime']),
      endTime: json['poll'] == null || json['poll']['endTime'] == null
          ? null
          : DateTime.parse(json['poll']['endTime']),
      content: json['text'] ?? '',
      contentTitle: json['title'] ?? '',
      type: json['type'] ?? '',
      link: json['url'] ?? '',
      video: json['video'] ?? '',
      image: json['imageUrls'] != null
          ? (json['imageUrls'] as List).map((image) => image as String).toList()
          : [],
      createdFrom: timeAgo(json['createdAt']) ?? '',
      upvotes: json['upvotes'] ?? 0,
      comments: json['commentCount'] ?? 0,
      spamCount: json['spamCount'] ?? 0,
      isUpvoted: json['isUpvoted'] ?? false,
      isDownvoted: json['isDownvoted'] ?? false,
      isNSFW: json['isNSFW'] ?? false,
      isSpoiler: json['isSpoiler'] ?? false,
      isLocked: json['isLocked'] ?? false,
      isApproved: json['approved'] ?? false,
      isDisapproved: json['disapproved'] ?? false,
      isOwner: TokenDecoder.id == (json['user'] ?? ''),
    );
  }
}

class PostCard extends StatefulWidget {
  final Post post;
  final bool isModertor;
  final bool isExpanded;
  final bool isCommunityFeed;

  const PostCard(
      {required this.post,
      this.isModertor = false,
      this.isExpanded = false,
      this.isCommunityFeed = false});

  @override
  _PostCardState createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  late Post post;
  bool isTypeImage = false;
  bool isTypeText = false;
  bool isTypeLink = false;
  bool isTypePoll = false;
  bool isTypeVideo = false;
  bool isSpamed = false;
  ApiService apiService = ApiService(TokenDecoder.token);

  Future<void> _launchURL(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw 'Could not launch $url';
    }
  }

  Future<void> getPostById(String postId) async {
    Map<String, dynamic> data = (await apiService.getPostFromId(postId)) ?? {};
    if (data.containsKey('post')) {
      dynamic json = data['post'];
      setState(() {
        post = Post.fromJson(json);
        print(post.isLocked);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    post = widget.post;
    isTypeImage = widget.post.type == 'image';
    isTypeText = widget.post.type == 'text';
    isTypeLink = widget.post.type == 'link';
    isTypePoll = widget.post.type == 'poll';
    isTypeVideo = widget.post.type == 'video';
  }

  @override
  Widget build(BuildContext context) {
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
                    backgroundImage: widget.isCommunityFeed
                        ? post.userAvatarImage !=
                                "assets/images/avatarDaniel.png"
                            ? NetworkImage(post.userAvatarImage)
                            : AssetImage(post.userAvatarImage)
                                as ImageProvider<Object>?
                        : widget.isExpanded
                            ? post.userAvatarImage !=
                                    "assets/images/avatarDaniel.png"
                                ? NetworkImage(post.userAvatarImage)
                                : AssetImage(post.userAvatarImage)
                                    as ImageProvider<Object>?
                            : post.avatarImage != "assets/images/planet3.png"
                                ? NetworkImage(post.avatarImage)
                                : AssetImage(post.avatarImage)
                                    as ImageProvider<Object>?,
                  ),
                ),
                SizedBox(width: ScreenSizeHandler.screenWidth * 0.02),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.isExpanded
                            ? widget.post.subredditName == ""
                                ? "u/${post.userName}"
                                : "r/${post.subredditName}"
                            : widget.isCommunityFeed
                                ? '${post.userName} • ${post.createdFrom}'
                                : 'r/${post.subredditName} • ${post.createdFrom}',
                        style: TextStyle(
                            height: 0.8,
                            color: Colors.white,
                            fontSize: ScreenSizeHandler.bigger * 0.014,
                            fontWeight: FontWeight.w500),
                      ),
                      if (widget.isExpanded)
                        Row(
                          children: [
                            Text(
                              'u/${post.userName} ',
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: ScreenSizeHandler.bigger * 0.014,
                                  fontWeight: FontWeight.w400),
                            ),
                            Text(
                              '• ${post.createdFrom}',
                              style: TextStyle(
                                  color: const Color.fromARGB(255, 100, 100, 100),
                                  fontSize: ScreenSizeHandler.bigger * 0.012,
                                  ),
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
                if (isSpamed && widget.isModertor)
                  Padding(
                    padding: EdgeInsets.only(
                        right: ScreenSizeHandler.screenWidth * 0.02),
                    child: Icon(
                      FontAwesomeIcons.calendarXmark,
                      color: Colors.red,
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
                      size: ScreenSizeHandler.screenWidth * 0.042,
                    ),
                  if (post.isNSFW)
                    Text(
                      'NSFW',
                      style: TextStyle(
                        color: Colors.pink,
                        fontSize: ScreenSizeHandler.screenWidth * 0.032,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  SizedBox(width: ScreenSizeHandler.screenWidth * 0.01),
                  if (post.isSpoiler)
                    Icon(
                      FontAwesomeIcons.circleExclamation,
                      color: Colors.white,
                      size: ScreenSizeHandler.screenWidth * 0.035,
                    ),
                  if (post.isSpoiler)
                    Text(
                      ' SPOILER',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: ScreenSizeHandler.screenWidth * 0.032,
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
                                  ? ScreenSizeHandler.bigger * 0.022
                                  : ScreenSizeHandler.bigger * 0.019,
                            ),
                            softWrap: true,
                          ),
                        ),
                      ),
                      if (widget.post.type == 'link')
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
                            text: widget.post.link,
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
                                ? ScreenSizeHandler.bigger * 0.017
                                : ScreenSizeHandler.bigger * 0.015),
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
                                        size: ScreenSizeHandler.bigger * 0.018,
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
                                                0.015),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: ScreenSizeHandler.screenWidth *
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
                                        size: ScreenSizeHandler.bigger * 0.018,
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
                                            size: ScreenSizeHandler.screenWidth *
                                                0.03,
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
                                                    ScreenSizeHandler.screenWidth *
                                                        0.03),
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
                                    left: ScreenSizeHandler.screenWidth * 0.03,
                                    right:
                                        ScreenSizeHandler.screenWidth * 0.03,
                                  ),
                                  child: Icon(
                                    Icons.share,
                                    size: ScreenSizeHandler.screenWidth *
                                                0.03,
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
                        ).then((value) {
                          if (value != null) {
                            if (value) {
                              setState(() {
                                getPostById(post.postId);
                              });
                            } else {
                              setState(() {
                                isSpamed = true;
                              });
                            }
                          }
                        });
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
