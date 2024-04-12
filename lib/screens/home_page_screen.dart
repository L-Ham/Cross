import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:reddit_bel_ham/components/home_page_components/post_card.dart';
import 'package:reddit_bel_ham/components/home_page_components/profile_icon_with_indicator.dart';
import 'package:reddit_bel_ham/components/settings_components/settings_tile.dart';
import 'package:reddit_bel_ham/components/settings_components/settings_tile_leading_icon.dart';
import 'package:reddit_bel_ham/constants.dart';
import 'package:reddit_bel_ham/screens/home_page_seach_screen.dart';
import 'package:reddit_bel_ham/utilities/screen_size_handler.dart';
import 'package:reddit_bel_ham/utilities/token_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:reddit_bel_ham/screens/settings_screen.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({super.key});
  static const id = 'home_page_screen';

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String username = "peter_ashraf";
  String onlineStatusString = "On";
  bool onlineStatusToggle = true;
  Color onlineStatusColor = kOnlineStatusColor;
  double onlineStatusWidth = ScreenSizeHandler.smaller * 0.42;
  late String email;
  @override
  void initState() {
    super.initState();
    username = TokenDecoder.username;
    email = TokenDecoder.email;
  }

  String selectedMenuItem = "Home";
  final List<String> menuItems = ['Home', 'Popular', 'Latest News'];
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
      link: "",
    ),
    Post(
      username: "r/AnnieBakesCakes",
      contentTitle: "Curating Culinary Moments on Instagram: Tips & Tricks!",
      content:
          "Hey foodies! I've been pondering tellow fthe world of food photography on Instagram lately, and I wanted to pick your brains about strategies for making our food posts stand out. It's incredible how much competition there is out there, right? I mean, everyone's snapping pics of their avocado toast and artisanal burgers. So, what are your go-to tips for making our food shots pop? Dood lovers! I've been diving deep into the world of food photography on Instagram lately, and I wanted to pick your brains about strategies for making our food posts stand out. Ihe art of curating culinary moments on Instagram latelto learn from your experien",
      upvotes: 20,
      comments: 35,
      type: "image",
      image: "assets/images/elham_logo.png",
      link: "",
    ),
    Post(
      username: "r/JohannaDoesYoga",
      contentTitle:
          "Is instagram buggering up for anyone else? I can't post anything",
      content:
          "Check this page for more detailsjrhgshejaiajirjsijijfiarjgiajeijgiohgijaerigjiorhgiqjarigvja",
      upvotes: 90,
      comments: 35,
      type: "link",
      image: "",
      link: "https://www.instagram.com",
    ),
    Post(
      username: "r/JohannaDoesYoga",
      contentTitle: "instagram",
      content: "Check this page for more details",
      upvotes: 90,
      comments: 35,
      type: "poll",
      image: "",
      link: "",
    )
  ];

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          leading: Row(
            children: [
              Padding(
                padding: EdgeInsets.only(
                    left: ScreenSizeHandler.screenWidth * 0.018,
                    right: ScreenSizeHandler.screenWidth * 0.02),
                child: GestureDetector(
                  onTap: () {
                    _scaffoldKey.currentState?.openDrawer();
                  },
                  child: Icon(
                    Icons.menu,
                    size: 30,
                    color: Colors.white,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                    left: ScreenSizeHandler.screenWidth * 0.02,
                    top: ScreenSizeHandler.screenWidth * 0.006,
                    bottom: ScreenSizeHandler.screenWidth * 0.006,
                    right: ScreenSizeHandler.screenWidth * 0.01),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(
                      255, 55, 55, 55), // Set the background color
                  borderRadius: BorderRadius.circular(
                      5.0), // Adjust border radius as needed
                ),
                child: Row(
                  children: [
                    Text(
                      selectedMenuItem,
                      style: TextStyle(
                        fontSize: ScreenSizeHandler.screenWidth * 0.03,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Icon(
                      Icons.keyboard_arrow_down,
                      size: ScreenSizeHandler.screenWidth * 0.06,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ],
          ),
          backgroundColor: Colors.black,
          actions: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SearchScreen()),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Icon(
                  Icons.search,
                  size: 35,
                  color: Colors.white,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: GestureDetector(
                onTap: () {
                  _scaffoldKey.currentState?.openEndDrawer();
                },
                child: ProfileIconWithIndicator(isOnline: onlineStatusToggle),
              ),
            ),
          ],
        ),
        body: ListView.builder(
          itemCount: posts.length,
          itemBuilder: (context, index) {
            return PostCard(post: posts[index]);
          },
        ),
        drawer: Drawer(),
        endDrawer: Drawer(
          backgroundColor: kBackgroundColor,
          child: SafeArea(
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.close,
                      color: Colors.white,
                      size:
                          ScreenSizeHandler.bigger * kSideBarCloseIconSizeRatio,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      bottom: ScreenSizeHandler.screenHeight * 0.02),
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Text('A'),
                    radius: ScreenSizeHandler.bigger *
                        kSideBarCircleAvatarRadiusRatio,
                    foregroundImage:
                        AssetImage('assets/images/reddit_logo.png'),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      bottom: ScreenSizeHandler.screenHeight * 0.015),
                  child: Text('u/$username',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: ScreenSizeHandler.bigger * 0.026,
                          fontWeight: FontWeight.bold)),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      onlineStatusToggle = !onlineStatusToggle;
                      if (onlineStatusToggle) {
                        onlineStatusString = "On";
                        onlineStatusColor = Color.fromARGB(255, 0, 204, 120);
                        onlineStatusWidth = ScreenSizeHandler.smaller * 0.42;
                      } else {
                        onlineStatusString = "Off";
                        onlineStatusColor = Colors.grey;
                        onlineStatusWidth =
                            ScreenSizeHandler.screenWidth * 0.38;
                      }
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 15.0),
                    child: Container(
                      height: ScreenSizeHandler.bigger * 0.04,
                      width: onlineStatusWidth,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                            20), // adjust the radius as needed
                        border: Border.all(
                          color: onlineStatusColor, // set border color
                          width: ScreenSizeHandler.smaller *
                              0.006, // set border width
                        ),
                      ),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (onlineStatusToggle)
                              Icon(
                                Icons.circle,
                                color: onlineStatusColor,
                                size: kOnlineStatusIconSize,
                              ),
                            Text(
                              'Online Status: $onlineStatusString',
                              style: TextStyle(
                                  color: onlineStatusColor,
                                  fontSize: ScreenSizeHandler.smaller *
                                      kOnlineStatusFontSizeRatio,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView(
                    scrollDirection: Axis.vertical,
                    children: [
                      SettingsTile(
                        leadingIcon: const SettingsTileLeadingIcon(
                          leadingIcon: Icons.account_circle_outlined,
                        ),
                        titleText: "Profile",
                        onTap: () {},
                      ),
                      SettingsTile(
                        leadingIcon: const SettingsTileLeadingIcon(
                          leadingIcon: Icons.groups_rounded,
                        ),
                        titleText: "Create a community",
                        onTap: () {
                          Navigator.pushNamed(
                              context, 'create_community_screen');
                        },
                      ),
                      SettingsTile(
                        leadingIcon: const SettingsTileLeadingIcon(
                          leadingIcon: Icons.bookmarks_outlined,
                        ),
                        titleText: "Saved",
                        onTap: () {},
                      ),
                      SettingsTile(
                        leadingIcon: const SettingsTileLeadingIcon(
                          leadingIcon: Icons.access_time_rounded,
                        ),
                        titleText: "History",
                        onTap: () {},
                      ),
                    ],
                  ),
                ),
                SettingsTile(
                  leadingIcon: const SettingsTileLeadingIcon(
                    leadingIcon: Icons.settings_outlined,
                  ),
                  titleText: "Settings",
                  trailingWidget: Icon(Icons.nights_stay_sharp, size: 25),
                  onTap: () {
                    Navigator.pushNamed(context, SettingsScreen.id);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}