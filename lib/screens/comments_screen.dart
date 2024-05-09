import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:reddit_bel_ham/components/general_components/reddit_loading_indicator.dart';
import 'package:reddit_bel_ham/components/home_page_components/profile_icon_with_indicator.dart';
import 'package:reddit_bel_ham/constants.dart';
import 'package:reddit_bel_ham/screens/add_comment_screen.dart';
import 'package:reddit_bel_ham/services/api_service.dart';
import 'package:reddit_bel_ham/utilities/screen_size_handler.dart';
import 'package:reddit_bel_ham/components/home_page_components/post_card.dart';
import 'package:reddit_bel_ham/utilities/token_decoder.dart';

import '../components/comments_components/comment_card.dart';
import '../utilities/time_ago.dart';

class CommentsScreen extends StatefulWidget {
  static const id = 'comments_screen';
  const CommentsScreen({Key? key}) : super(key: key);

  @override
  _CommentsScreenState createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {
  ScrollController _scrollController = ScrollController();
  ApiService apiService = ApiService(TokenDecoder.token);
  bool isLoading = false;
  bool isCommentLoading = false;

  String avatarImageReturned = '';

  bool refreshComments = false;
  bool firstTime = true;
  int pageNum = 1;
  Post pushedPost = Post(
      userId: "",
      postId: "",
      subredditName: "",
      contentTitle: "",
      content: "",
      upvotes: 0,
      comments: 0,
      type: "text",
      link: "",
      image: [],
      video: "",
      createdFrom: "");

  void getPostFromId(String postId) async {
    setState(() {
      isLoading = true;
    });
    await apiService.getPostFromId(postId).then((value) {
      value = value['post'];
      setState(() {
        String userId = value['user'];
        String subredditId = value['subReddit'];
        bool approved = value['approved'];
        bool disapproved = value['disapproved'];
        bool isNSFW = value['isNSFW'];
        bool isSpoiler = value['isSpoiler'];
        bool isLocked = value['isLocked'];
        String avatarImage =
            value['creatorAvatar'] ?? "assets/images/planet3.png";
        String userName = value['creatorName'];
        String createdFrom = timeAgo(value['createdAt']);
        String contentTitle = value['title'];
        String content = value['text'] ?? "";
        List<dynamic> images = value['images'];
        List<String> imageUrls =
            images.map((image) => image['url'] as String).toList();
        List<dynamic> videos = value['videos'] as List<dynamic>;
        String video = videos.isEmpty ? "" : videos[0];
        String link = value['url'];
        String type = value['type'];
        int upvotes = value['upvotes'] - value['downvotes'];
        int comments = value['commentCount'];
        String username = value['subRedditName'] ?? "";
        List<dynamic> upvotedUsers = value['upvotedUsers'];
        List<dynamic> downvotedUsers = value['downvotedUsers'];
        bool isUpvoted = upvotedUsers.contains(TokenDecoder.id);
        bool isDownvoted = downvotedUsers.contains(TokenDecoder.id);
        bool isOwner = TokenDecoder.id == userId;
        List<dynamic> poll = [];
        List<String> pollOptions = [];
        List<int> votersCount = [];
        bool isVoted = false;
        String? votedOption = "";
        DateTime pollEnd = DateTime.now();
        if (value['poll']['options'].isNotEmpty) {
          poll = value['poll']['options'];
          pollOptions =
              poll.map((option) => option['option'] as String).toList();
          votersCount = poll
              .map((option) => (option['voters'] as List<dynamic>).length)
              .toList();
          isVoted = poll.any((option) =>
              (option['voters'] as List<dynamic>).contains(TokenDecoder.id));
          votedOption = poll.firstWhere(
              (option) =>
                  (option['voters'] as List<dynamic>).contains(TokenDecoder.id),
              orElse: () => {"option": null})['option'];
          pollEnd = DateTime.parse(value['poll']['endTime']);
        }

        setState(() {
          isLoading = false;
        });
        pushedPost = Post(
            userId: userId,
            postId: postId,
            createdFrom: createdFrom,
            contentTitle: contentTitle,
            content: content,
            image: imageUrls,
            video: video,
            link: link,
            type: type,
            upvotes: upvotes,
            comments: comments,
            subredditName: username);
        pushedPost.isUpvoted = isUpvoted;
        pushedPost.isDownvoted = isDownvoted;
        pushedPost.isNSFW = isNSFW;
        pushedPost.isSpoiler = isSpoiler;
        pushedPost.isLocked = isLocked;
        pushedPost.isApproved = approved;
        pushedPost.isDisapproved = disapproved;
        pushedPost.avatarImage = avatarImage;
        pushedPost.userName = userName;
        pushedPost.options = pollOptions;
        pushedPost.numOfVotersPerOption = votersCount;
        pushedPost.isPollVoted = isVoted;
        pushedPost.selectedPollOption = votedOption;
        pushedPost.endTime = pollEnd;
        pushedPost.subredditId = subredditId;
        pushedPost.numOfVotersPerOption = votersCount;
        pushedPost.isOwner = isOwner;
      });
    });
    setState(() {
      getAllCommentsFromPostId();
    });
  }

  void getAllCommentsFromPostId() async {
    setState(() {
      isCommentLoading = true;
    });
    var response = await apiService.getCommentsFromPostId({
      "postId": pushedPost.postId,
      "page": pageNum.toString(),
      "limit": 10.toString()
    });
    List<dynamic> commentsData = response["comments"] ?? [];
    if (mounted) {}
    setState(() {
      comments = parseComments(commentsData)
          .where((comment) => comment.repliedId == null)
          .toList();
    });
    setState(() {
      isCommentLoading = false;
    });
  }

  List<Comment> parseComments(List<dynamic> commentsData) {
    List<Comment> comments = [];
    for (var comment in commentsData) {
      String userId = comment['userId'];
      String commentId = comment['commentId'];
      String? parentCommentId = comment['repliedId'];
      String content = comment['text'];
      String createdFrom = timeAgo(comment['createdAt']);
      int upvotes = comment['score'];
      bool isUpvoted = comment['isUpvoted'];
      bool isDownvoted = comment['isDownvoted'];
      List<dynamic> repliesData = comment['replies'];
      List<Comment> repliesList =
          repliesData.isNotEmpty ? parseComments(repliesData) : [];

      Comment commentData = Comment(
          username: "peter",
          userId: userId,
          commentId: commentId,
          content: content,
          submittedTime: createdFrom,
          upvotes: upvotes,
          isUpvoted: isUpvoted,
          isDownvoted: isDownvoted,
          repliedId: parentCommentId,
          postId: pushedPost.postId,
          replies: repliesList);

      comments.add(commentData);
    }
    return comments;
  }

  List<Comment> comments = [];
  FocusNode commentFocusNode = FocusNode();
  FocusNode textFieldFocusNode = FocusNode();
  bool isCommenting = false;
  TextEditingController commentController = TextEditingController();
  int? maxLines;
  // final List<Comment> comments = [
  //   Comment(
  //     username: "JohnnyBanana",
  //     submittedTime: "3d",
  //     content:
  //         "I swear by natural lighting! It makes the food look so much more appetizing. I also like to play around with the angles to get the best shot. As for editing, I usually just adjust the brightness and contrast a bit to make the colors pop. And for captions, I think it's all about finding your own voice and being authentic. People can tell when you're being genuine, so just have fun with it!",
  //     replies: [
  //       Comment(
  //         username: "dani",
  //         submittedTime: "2d",
  //         content:
  //             "I'm all about the editing tricks! I use Lightroom to enhance the colors People love to connect with the person behind the food!",
  //         replies: [
  //           Comment(
  //             username: "dani",
  //             submittedTime: "2d",
  //             content:
  //                 "I swear by natural lighting! It makes the food look so much more appetizing. I also like to play around with the angles to get the best shot. As for editing, I usually just adjust the brightness and contrast a bit to make the colors pop. And for captions, I think it's all about finding your own voice and being authentic. People can tell when you're being genuine, so just have fun with it!",
  //             upvotes: 12,
  //           ),
  //         ],
  //         upvotes: 8,
  //       ),
  //       Comment(
  //         submittedTime: "2d",
  //         username: "EmilyEats",
  //         content:
  //             "I'm a big fan of natural lighting too! It just makes everything look so much better. I also like to use props to add some visual interest to my photos. And for editing, I usually just adjust the exposure and contrast a bit to make the colors pop. As for captions, I think it's all about being authentic and sharing a bit of yourself with your followers. People love to see the person behind the food!",
  //         upvotes: 5,
  //       ),
  //     ],
  //     upvotes: 12,
  //   ),
  //   Comment(
  //     username: "SallySweets",
  //     submittedTime: "2d",
  //     content:
  //         "I'm all about the editing tricks! I use Lightroom to enhance the colors People love to connect with the person behind the food!",
  //     upvotes: 8,
  //   ),
  //   Comment(
  //     submittedTime: "1d",
  //     username: "EmilyEats",
  //     content:
  //         "I'm a big fan of natural lighting too! It just makes everything look so much better. I also like to use props to add some visual interest to my photos. And for editing, I usually just adjust the exposure and contrast a bit to make the colors pop. As for captions, I think it's all about being authentic and sharing a bit of yourself with your followers. People love to see the person behind the food!",
  //     upvotes: 5,
  //   ),
  // ];
  @override
  void didChangeDependencies() {
    Map<String, dynamic> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    if (args.containsKey('avatar')) {
      setState(() {
        avatarImageReturned = args['avatar'] as String;
      });
    }
    if (args.containsKey('post')) {
      pushedPost = args['post'] as Post;
    } else {
      String postId = args['postId'] as String;
      if (firstTime) {
        getPostFromId(postId);
        firstTime = false;
      }
      getAllCommentsFromPostId();
    }
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
    commentFocusNode.addListener(() {
      if (commentFocusNode.hasFocus) {
        // Request focus for the TextField after the UI has been updated
        Future.delayed(const Duration(milliseconds: 50), () {
          FocusScope.of(context).requestFocus(textFieldFocusNode);
        });
      }
    });
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent - 500) {
        _getMoreComments();
      }
    });
  }

  void _getMoreComments() async {
    if (!isCommentLoading) {
      setState(() {
        isCommentLoading = true;
      });
      var response = await apiService.getCommentsFromPostId({
        "postId": pushedPost.postId,
        "page": pageNum.toString(),
        "limit": 10.toString()
      });
      if (response['message'] == "The retrieved array is empty") {
        pageNum--;
      }
      pageNum++;
      print("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa");
      print(pageNum);
      List<dynamic> commentsData = response["comments"];
      List<Comment> moreComments = parseComments(commentsData)
          .where((comment) => comment.repliedId == null)
          .toList();
      setState(() {
        comments.addAll(moreComments);
        isCommentLoading = false;
      });
    }
  }

  @override
  void dispose() {
    commentFocusNode.dispose();
    textFieldFocusNode.dispose(); // Dispose the new FocusNode
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPostColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: kPostColor,
        title: Row(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.clear,
                size: ScreenSizeHandler.bigger * 0.04,
              ),
            ),
            const Spacer(),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: ScreenSizeHandler.screenWidth * 0.016),
              child: Icon(Icons.search, size: ScreenSizeHandler.bigger * 0.035),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: ScreenSizeHandler.screenWidth * 0.016),
              child: Icon(Icons.sort, size: ScreenSizeHandler.bigger * 0.035),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: ScreenSizeHandler.screenWidth * 0.016),
              child: Icon(Icons.more_horiz,
                  size: ScreenSizeHandler.bigger * 0.035),
            ),
            Padding(
              padding:
                  EdgeInsets.only(left: ScreenSizeHandler.screenWidth * 0.016),
              child: ProfileIconWithIndicator(
                  isOnline: true, radius: 15, imageURL: avatarImageReturned),
            ),
          ],
        ),
      ),
      body: ModalProgressHUD(
        inAsyncCall: isLoading,
        progressIndicator: const RedditLoadingIndicator(),
        color: Colors.black,
        opacity: 0.5,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    PostCard(
                      post: pushedPost,
                      isExpanded: true,
                    ),
                    Divider(
                      color: Colors.black,
                      thickness: ScreenSizeHandler.screenHeight * 0.015,
                    ),
                    //TODO: PUT COMMENTS HERE YA PETER
                    if (isCommentLoading) const RedditLoadingIndicator(),
                    ListView.builder(
                      controller: _scrollController,
                      shrinkWrap: true,
                      itemCount: comments.length,
                      itemBuilder: (context, index) {
                        return CommentCard(comment: comments[index]);
                      },
                    ),
                  ],
                ),
              ),
            ),
            if (!commentFocusNode.hasFocus && pushedPost.isLocked == false)
              Container(
                height: ScreenSizeHandler.screenHeight * 0.08,
                width: ScreenSizeHandler.screenWidth,
                color: kPostColor,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: ScreenSizeHandler.screenHeight * 0.005),
                      child: GestureDetector(
                        onTap: () async {
                          await Navigator.pushNamed(
                            context,
                            AddCommentScreen.id,
                            arguments: {
                              'postTitle': pushedPost.contentTitle,
                              'postContent': pushedPost.content,
                              'postType': pushedPost.type,
                              'isReply': false,
                              'postId': pushedPost.postId,
                              'parentCommentId': null,
                            },
                          );
                          refreshComments = true;
                          print('refreshing');
                        },
                        child: Container(
                          height: ScreenSizeHandler.screenHeight * 0.04,
                          color: kFillingColor,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal:
                                    ScreenSizeHandler.screenWidth * 0.025),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    commentController.text.isEmpty
                                        ? "Add a comment"
                                        : commentController.text,
                                    style: TextStyle(
                                        color: commentController.text.isEmpty
                                            ? Colors.grey[600]
                                            : Colors.white,
                                        fontSize:
                                            ScreenSizeHandler.bigger * 0.018),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    const Divider(
                      height: 12,
                      color: kFillingColor,
                      thickness: 1,
                    )
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
