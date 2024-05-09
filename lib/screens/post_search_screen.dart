import 'package:flutter/material.dart';
import 'package:reddit_bel_ham/components/empty_dog.dart';
import 'package:reddit_bel_ham/components/general_components/avatar.dart';
import 'package:reddit_bel_ham/screens/comments_screen.dart';
import 'package:reddit_bel_ham/screens/searching_screen.dart';
import 'package:reddit_bel_ham/utilities/screen_size_handler.dart';

class PostSearchScreen extends StatefulWidget {
  const PostSearchScreen({super.key, required this.postSearchCards});

  final List<PostSearchCard> postSearchCards;

  @override
  State<PostSearchScreen> createState() => _PostSearchScreenState();
}

class _PostSearchScreenState extends State<PostSearchScreen> {
  @override
  Widget build(BuildContext context) {
    return widget.postSearchCards.isEmpty
        ? const Center(child: EmptyDog())
        : Padding(
            padding:
                EdgeInsets.only(top: ScreenSizeHandler.screenHeight * 0.02),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  for (int i = 0; i < widget.postSearchCards.length; i++)
                    PostSearchCardTile(
                      postSearchCard: widget.postSearchCards[i],
                    )
                ],
              ),
            ),
          );
  }
}

class PostSearchCardTile extends StatelessWidget {
  const PostSearchCardTile({
    super.key,
    required this.postSearchCard,
  });

  final PostSearchCard postSearchCard;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, CommentsScreen.id,
            arguments: {"postId": postSearchCard.postId});
      },
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: ScreenSizeHandler.screenWidth * 0.03),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                right: ScreenSizeHandler.screenWidth * 0.02),
                            child: Avatar(
                              avatar: postSearchCard.subredditName == ""
                                  ? postSearchCard.userAvatarImage
                                  : postSearchCard.avatarImageSubreddit,
                              radius: 12,
                              defaultImg: postSearchCard.subredditName == ""
                                  ? "assets/images/redditAvata2.png"
                                  : "assets/images/planet3.png",
                            ),
                          ),
                          Text(
                            postSearchCard.subredditName == ""
                                ? "u/${postSearchCard.userName}"
                                : "r/${postSearchCard.subredditName} ",
                            style: TextStyle(
                              fontSize: ScreenSizeHandler.bigger * 0.016,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey[400],
                              decoration: TextDecoration.underline,
                              decorationColor: Colors.grey[400],
                            ),
                          ),
                          Text(
                            "• ${postSearchCard.displayDate}",
                            style: TextStyle(
                              fontSize: ScreenSizeHandler.bigger * 0.016,
                              color: Colors.grey[400],
                            ),
                          )
                        ],
                      ),
                      Text(
                        postSearchCard.title,
                        style: TextStyle(
                            fontSize: ScreenSizeHandler.bigger * 0.018,
                            fontWeight: FontWeight.w500),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: ScreenSizeHandler.screenHeight * 0.015),
                        child: Text(
                          "${postSearchCard.score} upvotes • ${postSearchCard.commentCount} comments",
                          style: TextStyle(
                            fontSize: ScreenSizeHandler.bigger * 0.016,
                            color: Colors.grey[400],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                if (postSearchCard.type == "image" ||
                    postSearchCard.type == "video")
                  Padding(
                    padding: EdgeInsets.only(
                        right: ScreenSizeHandler.screenWidth * 0.025),
                    child: postSearchCard.image != ""
                        ? Image.network(
                            postSearchCard.type == "image"
                                ? postSearchCard.image.toString()
                                : postSearchCard.video.toString(),
                            width: ScreenSizeHandler.screenWidth * 0.15,
                          )
                        : null,
                  )
              ],
            ),
          ),
          Divider(
            color: Colors.grey[400],
            thickness: 0.5,
          )
        ],
      ),
    );
  }
}
