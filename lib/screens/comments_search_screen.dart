import 'package:flutter/material.dart';
import 'package:reddit_bel_ham/components/empty_dog.dart';
import 'package:reddit_bel_ham/components/general_components/avatar.dart';
import 'package:reddit_bel_ham/components/general_components/interactive_text.dart';
import 'package:reddit_bel_ham/screens/comments_screen.dart';
import 'package:reddit_bel_ham/screens/searching_screen.dart';
import 'package:reddit_bel_ham/screens/subreddit_screen.dart';
import 'package:reddit_bel_ham/utilities/screen_size_handler.dart';

class CommentsSearchScreen extends StatefulWidget {
  const CommentsSearchScreen({super.key, required this.commentSearchCards});

  final List<CommentSearchCard> commentSearchCards;

  @override
  State<CommentsSearchScreen> createState() => _CommentsSearchScreenState();
}

class _CommentsSearchScreenState extends State<CommentsSearchScreen> {
  @override
  Widget build(BuildContext context) {
    return widget.commentSearchCards.isEmpty
        ? const EmptyDog()
        : Padding(
            padding:
                EdgeInsets.only(top: ScreenSizeHandler.screenHeight * 0.02),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  for (int i = 0; i < widget.commentSearchCards.length; i++)
                    CommentSearchCardTile(
                      commentSearchCard: widget.commentSearchCards[i],
                    )
                ],
              ),
            ),
          );
  }
}

class CommentSearchCardTile extends StatelessWidget {
  const CommentSearchCardTile({super.key, required this.commentSearchCard});

  final CommentSearchCard commentSearchCard;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, CommentsScreen.id,
            arguments: {"postId": commentSearchCard.postId});
      },
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: ScreenSizeHandler.screenWidth * 0.03),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (commentSearchCard.subredditName != "")
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, SubredditScreen.id,
                          arguments: commentSearchCard.subredditName);
                    },
                    child: Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              right: ScreenSizeHandler.screenWidth * 0.01),
                          child: Avatar(
                              avatar: commentSearchCard.subredditImage,
                              radius: 14),
                        ),
                        Text(
                          "r/${commentSearchCard.subredditName} ",
                          style: TextStyle(
                              fontSize: ScreenSizeHandler.bigger * 0.016,
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                              decorationColor: Colors.grey),
                        ),
                        Text(
                          " • ${commentSearchCard.postCreationDate}",
                          style: TextStyle(
                              fontSize: ScreenSizeHandler.bigger * 0.016,
                              color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: ScreenSizeHandler.screenHeight * 0.005),
                  child: Text(
                    commentSearchCard.postTitle,
                    style: TextStyle(
                      fontSize: ScreenSizeHandler.bigger * 0.018,
                      color: Colors.grey[200],
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(ScreenSizeHandler.bigger * 0.008),
                  width: ScreenSizeHandler.screenWidth,
                  color: Colors.grey[800],
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                right: ScreenSizeHandler.screenWidth * 0.01),
                            child: Avatar(
                              avatar: commentSearchCard.userAvatarImage,
                              radius: 10,
                              defaultImg: 'assets/images/redditAvata2.png',
                            ),
                          ),
                          Text(
                            commentSearchCard.userName,
                            style: TextStyle(
                                fontSize: ScreenSizeHandler.bigger * 0.016,
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                                decorationColor: Colors.grey),
                          ),
                          Text(
                            " • ${commentSearchCard.commentCreationDate}",
                            style: TextStyle(
                                fontSize: ScreenSizeHandler.bigger * 0.016,
                                color: Colors.grey),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: ScreenSizeHandler.screenHeight * 0.002),
                        child: Text(
                          commentSearchCard.commentText,
                          maxLines: 6,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: ScreenSizeHandler.bigger * 0.018,
                            color: Colors.grey[200],
                          ),
                        ),
                      ),
                      Text(
                        "${commentSearchCard.commentUpvotes} upvotes",
                        style: TextStyle(
                          fontSize: ScreenSizeHandler.bigger * 0.016,
                          color: Colors.grey[400],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: ScreenSizeHandler.screenHeight * 0.006),
                  child: InteractiveText(
                    text: "Go to Comments",
                    onTap: () {},
                    isUnderlined: true,
                    fontSizeRatio: 0.017,
                  ),
                ),
                Text(
                  "${commentSearchCard.postUpvotes} upvotes • 15 comments",
                  style: TextStyle(
                      fontSize: ScreenSizeHandler.bigger * 0.016,
                      color: Colors.grey[400]),
                ),
              ],
            ),
          ),
          Divider(
            color: Colors.grey[800],
            thickness: 0.5,
          )
        ],
      ),
    );
  }
}
