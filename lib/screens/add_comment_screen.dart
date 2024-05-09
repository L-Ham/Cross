import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:reddit_bel_ham/components/add_post_components/add_post_text_field.dart';
import 'package:reddit_bel_ham/components/general_components/interactive_text.dart';
import 'package:reddit_bel_ham/components/general_components/reddit_loading_indicator.dart';
import 'package:reddit_bel_ham/components/subreddit_components/subreddit_ellipsis_bottom_sheet.dart';
import 'package:reddit_bel_ham/constants.dart';
import 'package:reddit_bel_ham/utilities/screen_size_handler.dart';

import '../components/general_components/insert_link_popup.dart';

class AddCommentScreen extends StatefulWidget {
  const AddCommentScreen({super.key});

  static const id = "add_comment_screen";

  @override
  State<AddCommentScreen> createState() => _AddCommentScreenState();
}

class _AddCommentScreenState extends State<AddCommentScreen> {
  TextEditingController commentController = TextEditingController();
  late String postTitle;
  late String postContent;
  String postType = "";
  late bool isReply;
  String userName = "Gintoki1204";
  String commentTime = "2h";
  String replyString =
      "Brother come ti India 70% of all goat college seats are reserved for peiple who didn't earn it";
  late String postId;
  late String? parentCommentId;
  bool isLoading = false;

  void showSnackBar(String snackBarText) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Center(child: Text(snackBarText)),
          backgroundColor: Colors.white,
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.only(
            left: ScreenSizeHandler.screenWidth * kButtonWidthRatio,
            right: ScreenSizeHandler.screenWidth * kButtonWidthRatio,
            bottom: ScreenSizeHandler.screenHeight * 0.05,
          ),
          duration: const Duration(seconds: 3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
        ),
      );
    });
  }

  @override
  void didChangeDependencies() {
    final Map<String, dynamic> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    isReply = args['isReply']! as bool;
    if (isReply) {
      userName = args['userName']!;
      commentTime = args['postTime']!;
      replyString = args['replyString']!;
    } else {
      postTitle = args['postTitle']!;
      postContent = args['postContent']!;
      postType = args['postType']!;
    }
    postId = args['postId'];
    parentCommentId = args['parentCommentId'];
    print(parentCommentId);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      progressIndicator: const RedditLoadingIndicator(),
      opacity: 0.5,
      color: Colors.black,
      child: Scaffold(
        backgroundColor: kBackgroundColor,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: kBackgroundColor,
          leading: IconButton(
            icon: Icon(
              Icons.clear_sharp,
              size: ScreenSizeHandler.screenHeight * kCancelAppbarIconSizeRatio,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(
            isReply ? "Reply" : "Add comment",
            style: TextStyle(
                fontSize: ScreenSizeHandler.smaller *
                    kAppBarTitleSmallerFontRatio *
                    1.2,
                fontWeight: FontWeight.w500),
          ),
          actions: [
            Padding(
              padding:
                  EdgeInsets.only(right: ScreenSizeHandler.screenWidth * 0.04),
              child: InteractiveText(
                text: "Post",
                onTap: () async {
                  //TODO: ADD COMENT HERE
                  if (commentController.text.isEmpty) {
                    setState(() {
                      showSnackBar("Please enter text");
                    });
                  } else {
                    setState(() {
                      isLoading = true;
                    });
                    var response = await apiService.addComment({
                      "postId": postId,
                      "parentCommentId": parentCommentId,
                      "text": commentController.text,
                      "isHidden": false,
                      "type": "text"
                    });
                    setState(() {
                      isLoading = false;
                    });
                    if (response['message'] ==
                            "Comment Created successfully & Notification Sent" ||
                        response['message'] == "Comment Created successfully") {
                      Navigator.pop(context);
                    } else {
                      setState(() {
                        showSnackBar(response['message']);
                      });
                    }
                  }
                },
              ),
            )
          ],
        ),
        body: Padding(
          padding: EdgeInsets.only(
            top: ScreenSizeHandler.screenHeight * 0.015,
          ),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: ScreenSizeHandler.screenWidth * 0.04),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: isReply
                                  ? Column(
                                      children: [
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            userName + " • " + commentTime,
                                            style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: ScreenSizeHandler.bigger *
                                                  0.015,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top:
                                                  ScreenSizeHandler.screenHeight *
                                                      0.02),
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              replyString,
                                              style: TextStyle(
                                                fontSize:
                                                    ScreenSizeHandler.bigger *
                                                        0.016,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  : Text(postTitle),
                            ),
                            if (postType == "text")
                              GestureDetector(
                                onTap: () {
                                  showModalBottomSheet(
                                    context: context,
                                    backgroundColor: Colors.transparent,
                                    builder: (BuildContext context) {
                                      return SingleChildScrollView(
                                        child: Container(
                                          height: null,
                                          width: ScreenSizeHandler.screenWidth,
                                          color: kFillingColor,
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: ScreenSizeHandler
                                                        .screenWidth *
                                                    0.04,
                                                vertical: ScreenSizeHandler
                                                        .screenHeight *
                                                    0.02),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'ORIGINAL POST',
                                                  style: TextStyle(
                                                    color: Colors.grey,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize:
                                                        ScreenSizeHandler.bigger *
                                                            0.013,
                                                  ),
                                                ),
                                                const Divider(
                                                  color: Colors.grey,
                                                  thickness: 0.1,
                                                ),
                                                Text(
                                                  postContent,
                                                  style: TextStyle(
                                                    fontSize:
                                                        ScreenSizeHandler.bigger *
                                                            0.016,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                                child: Icon(
                                  Icons.keyboard_arrow_down,
                                  color: Colors.grey,
                                  size: ScreenSizeHandler.bigger * 0.04,
                                ),
                              ),
                          ],
                        ),
                        const Divider(
                          color: Colors.grey,
                          thickness: 0.25,
                        ),
                        AddPostTextField(
                          controller: commentController,
                          hintText: isReply ? "Your Reply" : "Your comment",
                          fontSizeRatio: 0.018,
                          maxLines: null,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const Divider(
                color: Colors.grey,
                thickness: 0.25,
              ),
              Padding(
                padding: EdgeInsets.only(
                    bottom: ScreenSizeHandler.screenHeight * 0.01),
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          left: ScreenSizeHandler.screenWidth * 0.04),
                      child: GestureDetector(
                        onTap: () {
                          final result = showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return const InsertLinkPopUp();
                            },
                          );
                          result.then(
                            (value) {
                              if (value != null) {
                                commentController.text = commentController.text +
                                    "[" +
                                    value['name'] +
                                    "]" +
                                    "(" +
                                    value['link'] +
                                    ")";
                              }
                            },
                          );
                        },
                        child: Icon(
                          FontAwesomeIcons.link,
                          size: ScreenSizeHandler.bigger * 0.028,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
