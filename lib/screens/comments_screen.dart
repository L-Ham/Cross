import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:reddit_bel_ham/components/add_post_components/add_post_text_field.dart';
import 'package:reddit_bel_ham/components/general_components/interactive_text.dart';
import 'package:reddit_bel_ham/components/general_components/rounded_button.dart';
import 'package:reddit_bel_ham/components/home_page_components/profile_icon_with_indicator.dart';
import 'package:reddit_bel_ham/constants.dart';
import 'package:reddit_bel_ham/screens/add_comment_screen.dart';
import 'package:reddit_bel_ham/utilities/screen_size_handler.dart';
import 'package:reddit_bel_ham/components/home_page_components/post_card.dart';

class CommentsScreen extends StatefulWidget {
  static const id = 'comments_screen';

  const CommentsScreen({Key? key}) : super(key: key);

  @override
  _CommentsScreenState createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {
  late Post pushedPost;
  FocusNode commentFocusNode = FocusNode();
  FocusNode textFieldFocusNode = FocusNode();
  bool isCommenting = false;
  TextEditingController commentController = TextEditingController();
  int? maxLines;

  @override
  void didChangeDependencies() {
    pushedPost = ModalRoute.of(context)!.settings.arguments as Post;
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
              child: const ProfileIconWithIndicator(isOnline: true, radius: 15),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  PostCard(
                    post: pushedPost,
                  ),
                  Divider(
                    color: Colors.black,
                    thickness: ScreenSizeHandler.screenHeight * 0.015,
                  ),
                  //TODO: PUT COMMENTS HERE YA PETER
                ],
              ),
            ),
          ),
          if (!commentFocusNode.hasFocus)
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
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          AddCommentScreen.id,
                          arguments: {
                            'postTitle': pushedPost.contentTitle,
                            'postContent': pushedPost.content,
                            'postType': pushedPost.type,
                            'isReply': false
                          },
                        );
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
          // if (commentFocusNode.hasFocus || isCommenting)
          //   GestureDetector(
          //     onVerticalDragStart: (details) {
          //       if (maxLines == 16) {
          //         setState(() {
          //           maxLines = 1;
          //         });
          //       } else {
          //         FocusScope.of(context).unfocus();
          //       }
          //     },
          //     onVerticalDragEnd: (details) {
          //       setState(() {
          //         FocusScope.of(context).requestFocus();
          //         maxLines = 16;
          //       });
          //     },
          //     child: Container(
          //       width: ScreenSizeHandler.screenWidth,
          //       color: kPostColor,
          //       child: Column(
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         children: [
          //           SingleChildScrollView(
          //             child: Column(
          //               children: [
          //                 Align(
          //                   alignment: Alignment.center,
          //                   child: Padding(
          //                     padding: EdgeInsets.only(
          //                         top: 6,
          //                         bottom:
          //                             ScreenSizeHandler.screenHeight * 0.012),
          //                     child: Container(
          //                       height: 3.5,
          //                       width: ScreenSizeHandler.screenWidth * 0.1,
          //                       decoration: BoxDecoration(
          //                         color: Colors.grey[700],
          //                         borderRadius: BorderRadius.circular(
          //                             2.0), // Set the borderRadius
          //                       ),
          //                     ),
          //                   ),
          //                 ),
          //                 Align(
          //                   alignment: Alignment.centerLeft,
          //                   child: Padding(
          //                     padding: EdgeInsets.symmetric(
          //                         horizontal:
          //                             ScreenSizeHandler.screenWidth * 0.028),
          //                     child: InteractiveText(
          //                       text:
          //                           "Please follow community rules when commenting",
          //                       onTap: () {
          //                         //TODO: Push the community rules screen
          //                       },
          //                       fontSizeRatio: 0.0145,
          //                       fontWeight: FontWeight.normal,
          //                       isUnderlined: true,
          //                     ),
          //                   ),
          //                 ),
          //                 Padding(
          //                   padding: EdgeInsets.symmetric(
          //                       horizontal:
          //                           ScreenSizeHandler.screenWidth * 0.028),
          //                   child: AddPostTextField(
          //                     controller: commentController,
          //                     hintText: "Add a comment",
          //                     fontSizeRatio: 0.017,
          //                     focusNode: textFieldFocusNode,
          //                     maxLines: maxLines,
          //                   ),
          //                 ),
          //               ],
          //             ),
          //           ),
          //           const Divider(
          //             color: kFillingColor,
          //             thickness: 0.5,
          //           ),
          //           Padding(
          //             padding: EdgeInsets.symmetric(
          //                 horizontal: ScreenSizeHandler.screenWidth * 0.01),
          //             child: Row(
          //               children: [
          //                 Padding(
          //                   padding: EdgeInsets.symmetric(
          //                       horizontal:
          //                           ScreenSizeHandler.screenWidth * 0.017),
          //                   child: Icon(
          //                     FontAwesomeIcons.keyboard,
          //                     color: Colors.grey,
          //                     size: ScreenSizeHandler.bigger * 0.025,
          //                   ),
          //                 ),
          //                 Padding(
          //                   padding: EdgeInsets.symmetric(
          //                       horizontal:
          //                           ScreenSizeHandler.screenWidth * 0.017),
          //                   child: Icon(
          //                     FontAwesomeIcons.link,
          //                     color: Colors.grey,
          //                     size: ScreenSizeHandler.bigger * 0.025,
          //                   ),
          //                 ),
          //                 Padding(
          //                   padding: EdgeInsets.symmetric(
          //                       horizontal:
          //                           ScreenSizeHandler.screenWidth * 0.017),
          //                   child: Icon(
          //                     FontAwesomeIcons.image,
          //                     color: Colors.grey,
          //                     size: ScreenSizeHandler.bigger * 0.025,
          //                   ),
          //                 ),
          //                 const Spacer(),
          //                 RoundedThinButton(
          //                     commentController: commentController)
          //               ],
          //             ),
          //           ),
          //         ],
          //       ),
          //     ),
          //   )
        ],
      ),
    );
  }
}

class RoundedThinButton extends StatelessWidget {
  const RoundedThinButton({
    super.key,
    required this.commentController,
  });

  final TextEditingController commentController;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: commentController,
      builder: (BuildContext context, TextEditingValue value, Widget? child) {
        return GestureDetector(
          onTap: () {
            //TODO: Implement the comment functionality
          },
          child: Container(
            height: ScreenSizeHandler.bigger * 0.036,
            width: ScreenSizeHandler.smaller * 0.15,
            decoration: BoxDecoration(
              color: commentController.text.isNotEmpty
                  ? const Color.fromARGB(255, 150, 144, 233)
                  : const Color.fromARGB(120, 150, 144, 233),
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Center(
              child: Text(
                'Reply',
                style: TextStyle(
                  color: commentController.text.isNotEmpty
                      ? Colors.white
                      : Colors.grey[500],
                  fontWeight: FontWeight.w500,
                  fontSize: ScreenSizeHandler.bigger * 0.015,
                  decoration: TextDecoration.underline,
                  decorationThickness: 2.5,
                  decorationColor: commentController.text.isNotEmpty
                      ? Colors.white
                      : Colors.grey[500],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
