import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:reddit_bel_ham/components/home_page_components/profile_icon_with_indicator.dart';
import 'package:reddit_bel_ham/constants.dart';
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

  @override
  void didChangeDependencies() {
    pushedPost = ModalRoute.of(context)!.settings.arguments as Post;
    super.didChangeDependencies();
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
              child: ProfileIconWithIndicator(isOnline: true, radius: 15),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                PostCard(
                  post: pushedPost,
                ),
                Divider(
                  color: Colors.black,
                  thickness: ScreenSizeHandler.screenHeight * 0.015,
                )
                //TODO: PUT COMMENTS HERE YA PETER
              ],
            ),
          ),
        ],
      ),
    );
  }
}
