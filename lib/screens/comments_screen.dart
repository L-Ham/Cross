import 'package:flutter/material.dart';
import 'package:reddit_bel_ham/components/home_page_components/profile_icon_with_indicator.dart';
import 'package:reddit_bel_ham/constants.dart';
import 'package:reddit_bel_ham/screens/add_comment_screen.dart';
import 'package:reddit_bel_ham/utilities/screen_size_handler.dart';
import 'package:reddit_bel_ham/components/home_page_components/post_card.dart';

import '../components/comments_components/comment_card.dart';

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
  final List<Comment> comments = [
    Comment(
      username: "JohnnyBanana",
      submittedTime: "3d",
      content:
          "I swear by natural lighting! It makes the food look so much more appetizing. I also like to play around with the angles to get the best shot. As for editing, I usually just adjust the brightness and contrast a bit to make the colors pop. And for captions, I think it's all about finding your own voice and being authentic. People can tell when you're being genuine, so just have fun with it!",
      replies: [
        Comment(
          username: "dani",
          submittedTime: "2d",
          content:
              "I'm all about the editing tricks! I use Lightroom to enhance the colors People love to connect with the person behind the food!",
          replies: [
            Comment(
              username: "dani",
              submittedTime: "2d",
              content:
                  "I swear by natural lighting! It makes the food look so much more appetizing. I also like to play around with the angles to get the best shot. As for editing, I usually just adjust the brightness and contrast a bit to make the colors pop. And for captions, I think it's all about finding your own voice and being authentic. People can tell when you're being genuine, so just have fun with it!",
              upvotes: 12,
            ),
          ],
          upvotes: 8,
        ),
        Comment(
          submittedTime: "2d",
          username: "EmilyEats",
          content:
              "I'm a big fan of natural lighting too! It just makes everything look so much better. I also like to use props to add some visual interest to my photos. And for editing, I usually just adjust the exposure and contrast a bit to make the colors pop. As for captions, I think it's all about being authentic and sharing a bit of yourself with your followers. People love to see the person behind the food!",
          upvotes: 5,
        ),
      ],
      upvotes: 12,
    ),
    Comment(
      username: "SallySweets",
      submittedTime: "2d",
      content:
          "I'm all about the editing tricks! I use Lightroom to enhance the colors People love to connect with the person behind the food!",
      upvotes: 8,
    ),
    Comment(
      submittedTime: "1d",
      username: "EmilyEats",
      content:
          "I'm a big fan of natural lighting too! It just makes everything look so much better. I also like to use props to add some visual interest to my photos. And for editing, I usually just adjust the exposure and contrast a bit to make the colors pop. As for captions, I think it's all about being authentic and sharing a bit of yourself with your followers. People love to see the person behind the food!",
      upvotes: 5,
    ),
  ];
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
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: comments.length,
                    itemBuilder: (context, index) {
                      return CommentCard(comment: comments[index]);
                    },
                  ),
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
        ],
      ),
    );
  }
}