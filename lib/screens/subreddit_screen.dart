import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:reddit_bel_ham/utilities/screen_size_handler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:reddit_bel_ham/components/home_page_components/post_card.dart';
import 'package:reddit_bel_ham/components/subreddit_components/subreddit_navbar_icon.dart';

import '../constants.dart';

class SubredditScreen extends StatefulWidget {
  const SubredditScreen({Key? key}) : super(key: key);

  static const String id = 'subreddit_screen';
  @override
  State<SubredditScreen> createState() => _SubredditScreenState();
}

class _SubredditScreenState extends State<SubredditScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _showTitleInAppBar = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_updateAppBarText);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _updateAppBarText() {
    setState(() {
      _showTitleInAppBar =
          _scrollController.offset > ScreenSizeHandler.screenHeight * 0.05;
    });
  }

  final List<Post> posts = [
    Post(
      username: "r/DanielAdel",
      contentTitle: "Foodie Instagrammers, Let's Talk Strategy!",
      content:
          "Hey fellow food lovers! I've been diving deep into the world of food photography on Instagram lately, and I wanted to pick your brains about strategies for making our food posts stand out. It's incredible how much competition there is out there, right? I mean, everyone's snapping pics of their avocado toast and artisanal burgers. So, what are your go-to tips for making our food shots pop? Do you swear by natural lighting or do you have some secret editing tricks up your sleeve? And let's talk about captions too! I'm always struggling to strike the right balance between informative and witty. Let's share some wisdom and help each other elevate our Instagram game to the next level! 🍕✨",
      upvotes: 78,
      comments: 141,
      type: "text",
      image: "",
      link: "https://www.instagram.com/p/CJ9J9J1h7Zz/",
    ),
    Post(
      username: "r/AnnieBakesCakes",
      contentTitle: "Curating Culinary Moments on Instagram: Tips & Tricks!",
      content:
          "Hey foodies! I've been pondering tellow fthe world of food photography on Instagram lately, and I wanted to pick your brains about strategies for making our food posts stand out. It's incredible how much competition there is out there, right? I mean, everyone's snapping pics of their avocado toast and artisanal burgers. So, what are your go-to tips for making our food shots pop? Dood lovers! I've been diving deep into the world of food photography on Instagram lately, and I wanted to pick your brains about strategies for making our food posts stand out. Ihe art of curating culinary moments on Instagram latelto learn from your experien",
      upvotes: 20,
      comments: 35,
      type: "text",
      image: "",
      link: "",
    ),
    Post(
      username: "r/JohannaDoesYoga",
      contentTitle:
          "Is instagram buggering up for anyone else? I can't post anything",
      content: "Check this page for more details",
      upvotes: 90,
      comments: 35,
      type: "text",
      image: "",
      link: "",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverAppBar(
            title: _showTitleInAppBar
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'r/AskEngineers',
                        style: TextStyle(
                            fontSize: ScreenSizeHandler.bigger *
                                kPageSubtitleFontSizeHeightRatio,
                            fontWeight: FontWeight.bold),
                      ),
                      Row(
                        children: [
                          CircleAvatar(
                            radius: ScreenSizeHandler.bigger * 0.004,
                            backgroundColor: kOnlineStatusColor,
                          ),
                          SizedBox(
                              width: ScreenSizeHandler.screenWidth * 0.005),
                          Text(
                            '106 online',
                            style: TextStyle(
                              fontSize: ScreenSizeHandler.bigger * 0.015,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      )
                    ],
                  )
                : null,
            leading: Padding(
              padding: EdgeInsets.only(left: ScreenSizeHandler.bigger * 0.013),
              child: CircleAvatar(
                backgroundColor: Color.fromARGB(140, 0, 0, 0),
                child: IconButton(
                  iconSize: ScreenSizeHandler.bigger * 0.035,
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
            expandedHeight: ScreenSizeHandler.screenHeight * 0.002,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
                background:
                    Image.asset('assets/images/blue2.jpg', fit: BoxFit.cover)),
            actions: [
              SubredditNavbarIcon(
                iconSize: 0.025,
                icon: FaIcon(FontAwesomeIcons.magnifyingGlass),
                onPressed: () {},
              ),
              SubredditNavbarIcon(
                iconSize: 0.023,
                icon: FaIcon(FontAwesomeIcons.share),
                onPressed: () {},
              ),
              SubredditNavbarIcon(
                iconSize: 0.025,
                icon: FaIcon(FontAwesomeIcons.ellipsis),
                onPressed: () {},
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: ScreenSizeHandler.screenWidth * 0.033,
                  vertical: ScreenSizeHandler.screenHeight * 0.011),
              child: Column(
                children: [
                  Row(
                    children: [
                      Column(
                        children: [
                          SizedBox(
                            height: ScreenSizeHandler.bigger * 0.01,
                          ),
                          CircleAvatar(
                            radius: ScreenSizeHandler.bigger * 0.027,
                            foregroundImage:
                                AssetImage('assets/images/planet3.png'),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: ScreenSizeHandler.screenWidth * 0.035,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            textAlign: TextAlign.left,
                            'r/AskEngineers',
                            style: TextStyle(
                              fontSize: ScreenSizeHandler.bigger * 0.023,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: ScreenSizeHandler.screenHeight * 0.006,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '1,194,127 members',
                                style: TextStyle(
                                  fontSize: ScreenSizeHandler.bigger * 0.015,
                                  color: kDisabledButtonColor,
                                ),
                              ),
                              SizedBox(
                                  width: ScreenSizeHandler.screenWidth * 0.03),
                              Row(
                                children: [
                                  CircleAvatar(
                                    radius: ScreenSizeHandler.bigger * 0.0039,
                                    backgroundColor: kOnlineStatusColor,
                                  ),
                                  SizedBox(
                                      width: ScreenSizeHandler.screenWidth *
                                          0.005),
                                  Text(
                                    '106 online',
                                    style: TextStyle(
                                      fontSize:
                                          ScreenSizeHandler.bigger * 0.015,
                                      color: kDisabledButtonColor,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        width: ScreenSizeHandler.screenWidth * 0.05,
                      ),
                      SizedBox(
                        height: ScreenSizeHandler.screenHeight * 0.04,
                        width: ScreenSizeHandler.screenWidth * 0.228,
                        child: OutlinedButton(
                          onPressed: () {
                            setState(() {});
                          },
                          style: ButtonStyle(
                            side: MaterialStateBorderSide.resolveWith((states) {
                              return BorderSide(
                                  color: kSubredditJoinedColor,
                                  width: ScreenSizeHandler.screenWidth * 0.004);
                            }),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(
                                ScreenSizeHandler.bigger * 0.0000001),
                            child: Text(
                              'Joined',
                              style: TextStyle(
                                  color: kSubredditJoinedColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: ScreenSizeHandler.bigger * 0.0165),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: ScreenSizeHandler.bigger * 0.02,
                  ),
                  Text(
                      'Engineers apply the knowledge of math & science to design and manufacture maintainable systems used to...'),
                  SizedBox(
                    height: ScreenSizeHandler.bigger * 0.015,
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        child: Text(
                          'See more',
                          style: TextStyle(
                            color: kSubredditJoinedColor,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: ScreenSizeHandler.screenWidth * 0.02,
                      ),
                      Container(
                        width: ScreenSizeHandler.bigger * 0.001,
                        height: ScreenSizeHandler.bigger * 0.02,
                        color: kFillingColor,
                      ),
                      SizedBox(
                        width: ScreenSizeHandler.screenWidth * 0.02,
                      ),
                      GestureDetector(
                        child: Text(
                          '#3 in Engineering',
                          style: TextStyle(
                            color: kSubredditJoinedColor,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          for (var post in posts)
            SliverToBoxAdapter(
              child: PostCard(
                post: post,
              ),
            ),
        ],
      ),
    );
  }
}
