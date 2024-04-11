import 'package:flutter/material.dart';
import 'package:reddit_bel_ham/components/general_components/interactive_text.dart';
import 'package:reddit_bel_ham/constants.dart';

import '../utilities/screen_size_handler.dart';

class PostToScreen extends StatefulWidget {
  const PostToScreen({super.key});

  static const String id = 'post_to_screen';

  @override
  State<PostToScreen> createState() => _PostToScreenState();
}

class _PostToScreenState extends State<PostToScreen> {
  FocusNode searchFocus = FocusNode();
  bool isSearchFocused = false;

  @override
  void initState() {
    super.initState();
    searchFocus.addListener(() {
      setState(() {
        isSearchFocused = searchFocus.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    searchFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        toolbarHeight:
            ScreenSizeHandler.bigger * (isSearchFocused ? 0.06 : 0.12),
        automaticallyImplyLeading: false,
        leading: null,
        elevation: 0,
        backgroundColor: kBackgroundColor,
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (!isSearchFocused)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.clear_sharp,
                      size:
                          ScreenSizeHandler.bigger * kCancelAppbarIconSizeRatio,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  Text(
                    "Post to",
                    style: TextStyle(
                        fontSize: ScreenSizeHandler.smaller *
                            kAppBarTitleSmallerFontRatio,
                        fontWeight: FontWeight.w500),
                  ),
                  Container(
                    width: ScreenSizeHandler.screenWidth * 0.13,
                  ),
                ],
              ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: ScreenSizeHandler.screenWidth * 0.015),
              child: Row(
                children: [
                  Expanded(
                    child: SearchBar(isSearchFocused: searchFocus),
                  ),
                  if (isSearchFocused)
                    Padding(
                      padding: EdgeInsets.only(
                          left: ScreenSizeHandler.screenWidth * 0.03),
                      child: InteractiveText(
                        onTap: () {
                          searchFocus.unfocus();
                        },
                        text: "Cancel",
                        fontSizeRatio: 0.02,
                        isUnderlined: true,
                      ),
                    )
                ],
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: ScreenSizeHandler.screenWidth * 0.05),
          child: Column(
            children: [SizedBox(height: ScreenSizeHandler.screenHeight*0.018,),PostToSubredditTile(), PostToSubredditTile()],
          ),
        ),
      ),
    );
  }
}

class PostToSubredditTile extends StatelessWidget {
  const PostToSubredditTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: ScreenSizeHandler.screenHeight * 0.013),
      child: Row(
        children: [
          CircleAvatar(
            radius: ScreenSizeHandler.bigger * 0.032,
            backgroundColor: Colors.grey,
          ),
          Padding(
            padding:
                EdgeInsets.only(left: ScreenSizeHandler.screenWidth * 0.02),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "r/redditBelHam",
                  style: TextStyle(
                      fontSize: ScreenSizeHandler.bigger * 0.02,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                Text(
                  "5 online",
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: ScreenSizeHandler.bigger * 0.016),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SearchBar extends StatelessWidget {
  const SearchBar({
    super.key,
    required this.isSearchFocused,
  });

  final FocusNode isSearchFocused;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: ScreenSizeHandler.bigger * 0.055,
      child: TextField(
        focusNode: isSearchFocused,
        cursorColor: Colors.blue,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          fillColor: Colors.grey[800],
          filled: true,
          hintText: 'Search for a community',
          hintStyle: TextStyle(
            color: Colors.grey,
            fontSize: ScreenSizeHandler.bigger * 0.018,
          ),
          prefixIcon: Icon(
            Icons.search,
            color: Colors.grey,
            size: ScreenSizeHandler.bigger * 0.03,
          ),
        ),
      ),
    );
  }
}
