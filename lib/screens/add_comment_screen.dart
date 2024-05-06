import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:reddit_bel_ham/components/add_post_components/add_post_text_field.dart';
import 'package:reddit_bel_ham/components/general_components/interactive_text.dart';
import 'package:reddit_bel_ham/components/general_components/rounded_button.dart';
import 'package:reddit_bel_ham/constants.dart';
import 'package:reddit_bel_ham/utilities/is_valid_url.dart';
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

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              onTap: () {
                //TODO: ADD COMENT HERE
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
                                        child: Text(
                                          replyString,
                                          style: TextStyle(
                                            fontSize: ScreenSizeHandler.bigger *
                                                0.016,
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
    );
  }
}
