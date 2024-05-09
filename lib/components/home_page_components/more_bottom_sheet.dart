import 'package:flutter/material.dart';
import 'package:reddit_bel_ham/components/add_post_components/red_button_bottom_sheet.dart';
import 'package:reddit_bel_ham/components/subreddit_components/subreddit_ellipsis_bottom_sheet.dart';
import 'package:reddit_bel_ham/constants.dart';
import 'package:reddit_bel_ham/components/home_page_components/post_card.dart';
import 'package:reddit_bel_ham/screens/edit_post_screen.dart';
import 'package:reddit_bel_ham/services/api_service.dart';
import 'package:reddit_bel_ham/utilities/screen_size_handler.dart';
import 'package:reddit_bel_ham/utilities/token_decoder.dart';

Widget buildMoreModalBottomSheet(BuildContext context, Post post) {
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

  return SafeArea(
    child: SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
          color: kBackgroundColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
        ),
        padding: EdgeInsets.all(ScreenSizeHandler.screenWidth * 0.05),
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(
                  bottom: ScreenSizeHandler.screenHeight * 0.005),
              child: Text(
                "More actions...",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: ScreenSizeHandler.screenWidth * 0.035,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: ScreenSizeHandler.screenHeight * 0.01),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () async {
                    if (post.isSaved) {
                      var response = await apiService.unsavePost(post.postId);
                      showSnackBar(response['message']);
                      if (response['message'] == 'Post unsaved successfully') {
                        post.isSaved = false;
                      }
                      Navigator.pop(context);
                    } else {
                      var response = await apiService.savePost(post.postId);
                      showSnackBar(response['message']);
                      if (response['message'] == "Post saved successfully") {
                        post.isSaved = true;
                      }
                      Navigator.pop(context);
                    }
                  },
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            right: ScreenSizeHandler.screenWidth * 0.025),
                        child: Icon(
                            !post.isSaved
                                ? Icons.bookmark_border_outlined
                                : Icons.bookmark,
                            color: Colors.white,
                            size: ScreenSizeHandler.screenWidth * 0.055),
                      ),
                      Text('Save', style: TextStyle(color: Colors.white)),
                    ],
                  ),
                ),
                SizedBox(height: ScreenSizeHandler.screenHeight * 0.02),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          right: ScreenSizeHandler.screenWidth * 0.025),
                      child: Icon(Icons.copy_rounded,
                          color: Colors.white,
                          size: ScreenSizeHandler.screenWidth * 0.055),
                    ),
                    Text('Copy text', style: TextStyle(color: Colors.white)),
                  ],
                ),
                SizedBox(height: ScreenSizeHandler.screenHeight * 0.02),
                if (post.isOwner &&
                    post.type != "video" &&
                    post.type != "image") ...[
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, EditPostScreen.id,
                          arguments: {
                            "title": post.contentTitle,
                            "postId": post.postId,
                            "content": post.content,
                          });
                    },
                    child: Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              right: ScreenSizeHandler.screenWidth * 0.025),
                          child: Icon(Icons.edit,
                              color: Colors.white,
                              size: ScreenSizeHandler.screenWidth * 0.055),
                        ),
                        Text('Edit Post',
                            style: TextStyle(color: Colors.white)),
                      ],
                    ),
                  ),
                  SizedBox(height: ScreenSizeHandler.screenHeight * 0.02),
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            right: ScreenSizeHandler.screenWidth * 0.025),
                        child: Icon(Icons.warning_amber_outlined,
                            color: Colors.white,
                            size: ScreenSizeHandler.screenWidth * 0.055),
                      ),
                      Text('Mark spoiler',
                          style: TextStyle(
                            color: Colors.white,
                          )),
                    ],
                  ),
                  SizedBox(height: ScreenSizeHandler.screenHeight * 0.02),
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            right: ScreenSizeHandler.screenWidth * 0.025),
                        child: Icon(Icons.eighteen_up_rating_sharp,
                            color: Colors.white,
                            size: ScreenSizeHandler.screenWidth * 0.055),
                      ),
                      Text('Mark NSFW',
                          style: TextStyle(
                            color: Colors.white,
                          )),
                    ],
                  ),
                  SizedBox(height: ScreenSizeHandler.screenHeight * 0.02),
                ],
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          right: ScreenSizeHandler.screenWidth * 0.025),
                      child: Icon(Icons.groups_2_outlined,
                          color: Colors.white,
                          size: ScreenSizeHandler.screenWidth * 0.055),
                    ),
                    Text('Crosspost to a community',
                        style: TextStyle(color: Colors.white)),
                  ],
                ),
                SizedBox(height: ScreenSizeHandler.screenHeight * 0.02),
                if (post.isOwner)
                  GestureDetector(
                    onTap: () async {
                      final choice = await showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return const RedButtonBottomSheet(
                            bodyText:
                                "Once you delete this post, it can't be restored.",
                            titleText: "Delete Post?",
                            leftButtonText: "Go Back",
                            rightButtonText: "Yes, Delete",
                          );
                        },
                      );
                      if (choice == 'continue') {
                        ApiService apiService = ApiService(TokenDecoder.token);
                        apiService.deletePost(post.postId);
                        Navigator.pop(context);
                        Navigator.pop(context);
                      }
                    },
                    child: Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              right: ScreenSizeHandler.screenWidth * 0.025),
                          child: Icon(Icons.delete_outline,
                              color: Color.fromARGB(255, 204, 90, 90),
                              size: ScreenSizeHandler.screenWidth * 0.055),
                        ),
                        Text('Delete Post',
                            style: TextStyle(
                                color: Color.fromARGB(255, 204, 90, 90))),
                      ],
                    ),
                  ),
                if (post.subredditName != "r/DanielAdel") ...[
                  SizedBox(height: ScreenSizeHandler.screenHeight * 0.02),
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            right: ScreenSizeHandler.screenWidth * 0.025),
                        child: Icon(Icons.outlined_flag_outlined,
                            color: Color.fromARGB(255, 204, 90, 90),
                            size: ScreenSizeHandler.screenWidth * 0.055),
                      ),
                      Text('Report',
                          style: TextStyle(
                              color: Color.fromARGB(255, 204, 90, 90))),
                    ],
                  ),
                  SizedBox(height: ScreenSizeHandler.screenHeight * 0.02),
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            right: ScreenSizeHandler.screenWidth * 0.025),
                        child: Icon(Icons.block,
                            color: Color.fromARGB(255, 204, 90, 90),
                            size: ScreenSizeHandler.screenWidth * 0.055),
                      ),
                      Text('Block account',
                          style: TextStyle(
                              color: Color.fromARGB(255, 204, 90, 90))),
                    ],
                  ),
                  SizedBox(height: ScreenSizeHandler.screenHeight * 0.02),
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            right: ScreenSizeHandler.screenWidth * 0.025),
                        child: Icon(Icons.remove_red_eye_outlined,
                            color: Colors.white,
                            size: ScreenSizeHandler.screenWidth * 0.055),
                      ),
                      Text('Hide', style: TextStyle(color: Colors.white)),
                    ],
                  ),
                ]
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
