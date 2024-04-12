import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:reddit_bel_ham/components/general_components/continue_button.dart';
import 'package:reddit_bel_ham/components/home_page_components/post_card.dart';
import 'package:reddit_bel_ham/components/home_page_components/profile_icon_with_indicator.dart';
import 'package:reddit_bel_ham/components/settings_components/settings_tile.dart';
import 'package:reddit_bel_ham/components/settings_components/settings_tile_leading_icon.dart';
import 'package:reddit_bel_ham/constants.dart';
import 'package:reddit_bel_ham/screens/about_you_screen.dart';
import 'package:reddit_bel_ham/screens/home_page_seach_screen.dart';
import 'package:reddit_bel_ham/screens/login_screen.dart';
import 'package:reddit_bel_ham/utilities/screen_size_handler.dart';
import 'package:reddit_bel_ham/services/api_service.dart';

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
  bool isExitPressed = false;

  bool isRecentlyVisitedDrawerVisible = false;
  List<String> recentlyVisitedCommunities = [
    'Community 1',
    'Community 2',
    'C',
    'D',
  ];

  bool isFavoritesPressed = true;
  List<String> favoriteCommunities = [];

  bool isYourCommunitiesPressed = false;
  List<String> yourCommunities = [
    'Comm1',
    'Yourcommunity2',
    'Yourcommunity3',
    'Yourcommunity4',
  ];

  bool isModeratingPressed = false;
  List<String> moderatingCommunities = [
    'Comm1',
    'Comm2',
    'Comm3',
    'Comm4',
    'Comm5',
    'Comm6',
    'Comm7',
    'Comm8',
    'Comm9',
    'Comm10',
  ];

  Widget buildDrawerOne() {
    return SafeArea(
      child: ListView(
        children: [
          Column(
            children: [
              if (recentlyVisitedCommunities.isNotEmpty) Divider(),
              if (recentlyVisitedCommunities.isNotEmpty)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        'Recently Visited',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isRecentlyVisitedDrawerVisible =
                              !isRecentlyVisitedDrawerVisible;
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(right: 20.0),
                        child: Text(
                          'See all',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              if (recentlyVisitedCommunities.isNotEmpty)
                Container(
                  height: recentlyVisitedCommunities.length > 3
                      ? 150.0
                      : 50.0 * recentlyVisitedCommunities.length,
                  child: Column(
                    children: [
                      Flexible(
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: recentlyVisitedCommunities.length > 3
                              ? 3
                              : recentlyVisitedCommunities.length,
                          itemBuilder: (context, index) {
                            return Container(
                              height: 50,
                              child: ListTile(
                                title: Row(
                                  children: [
                                    Image(
                                      image: AssetImage(
                                          'assets/images/community_logo.png'),
                                      height: 23,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        'r/' +
                                            recentlyVisitedCommunities[index],
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              if (favoriteCommunities.isNotEmpty) Divider(),
              if (favoriteCommunities.isNotEmpty)
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isFavoritesPressed = !isFavoritesPressed;
                    });
                  },
                  child: ListTile(
                    title: Text(
                      'Favorites',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                    trailing: isFavoritesPressed
                        ? Icon(
                            Icons.keyboard_arrow_down_outlined,
                            size: 25, // REFACTOR THIS
                          )
                        : Icon(
                            Icons.arrow_forward_ios_outlined,
                            size: 15,
                          ),
                  ),
                ),
            ],
          ),
          if (favoriteCommunities.isNotEmpty)
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              height:
                  isFavoritesPressed ? 50.0 * favoriteCommunities.length : 0,
              child: Column(
                children: [
                  Flexible(
                    child: isFavoritesPressed
                        ? Container(
                            child: ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: favoriteCommunities.length,
                              itemBuilder: (context, index) {
                                favoriteCommunities
                                    .sort(); // Sort the list alphabetically
                                return SizedBox(
                                  height: 50,
                                  child: ListTile(
                                    title: Row(
                                      children: [
                                        favoriteCommunities[index] ==
                                                'Custom Feeds'
                                            ? Icon(Icons.feed_outlined)
                                            : Image(
                                                image: const AssetImage(
                                                    'assets/images/community_logo.png'),
                                                height: 23,
                                              ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            'r/${favoriteCommunities[index]}',
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 15,
                                            ),
                                          ),
                                        ),
                                        const Spacer(),
                                        IconButton(
                                          onPressed: () {
                                            setState(() {
                                              favoriteCommunities.remove(
                                                  favoriteCommunities[index]);
                                            });
                                          },
                                          icon: Icon(
                                            Icons.star_rounded,
                                            color: Colors.grey,
                                            size: 23,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          )
                        : Container(), // Provide a default widget when isFavoritesPressed is false
                  ),
                ],
              ),
            ),
          if (recentlyVisitedCommunities.isNotEmpty) Divider(),
          GestureDetector(
            onTap: () {
              setState(() {
                isModeratingPressed = !isModeratingPressed;
              });
            },
            child: ListTile(
              title: Text(
                'Moderating',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
              trailing: isModeratingPressed
                  ? Icon(
                      Icons.keyboard_arrow_down_outlined,
                      size: 25, // REFACTOR THIS
                    )
                  : const Icon(
                      Icons.arrow_forward_ios_outlined,
                      size: 15,
                    ),
            ),
          ),
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            height:
                isModeratingPressed ? 50.0 * moderatingCommunities.length : 0,
            child: Column(
              children: [
                Flexible(
                    child: isModeratingPressed
                        ? Container(
                            child: ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: 3 + moderatingCommunities.length,
                              itemBuilder: (context, index) {
                                if (index == 0)
                                  return ListTile(
                                    leading: Icon(Icons.feed_outlined),
                                    title: Text("Mod Feed"),
                                  );
                                else if (index == 1)
                                  return ListTile(
                                    leading: Icon(Icons.queue_rounded),
                                    title: Text("Queues"),
                                  );
                                else if (index == 2)
                                  return ListTile(
                                    leading: Icon(Icons.mail_outline_rounded),
                                    title: Text("Modmail"),
                                  );
                                else {
                                  return ListTile(
                                    title: Row(
                                      children: [
                                        Image(
                                          image: AssetImage(
                                              'assets/images/community_logo.png'),
                                          height: 23,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            'r/' +
                                                moderatingCommunities[
                                                    index - 3],
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15,
                                            ),
                                          ),
                                        ),
                                        Spacer(),
                                        GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              favoriteCommunities.contains(
                                                      moderatingCommunities[
                                                          index - 3])
                                                  ? favoriteCommunities.remove(
                                                      moderatingCommunities[
                                                          index - 3])
                                                  : favoriteCommunities.add(
                                                      moderatingCommunities[
                                                          index - 3]);
                                            });
                                          },
                                          child: Icon(
                                            favoriteCommunities.contains(
                                                    moderatingCommunities[
                                                        index - 3])
                                                ? Icons.star_rounded
                                                : Icons.star_border_rounded,
                                            color: Colors.grey,
                                            size: 23,
                                          ),
                                        )
                                      ],
                                    ),
                                  );
                                }
                              },
                            ),
                          )
                        : Container()),
              ],
            ),
          ),
          if (yourCommunities.isNotEmpty) Divider(),
          GestureDetector(
            onTap: () {
              setState(() {
                isYourCommunitiesPressed = !isYourCommunitiesPressed;
              });
            },
            child: ListTile(
              title: Text(
                'Your Communities',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
              trailing: isYourCommunitiesPressed
                  ? Icon(
                      Icons.keyboard_arrow_down_outlined,
                      size: 25,
                    )
                  : Icon(
                      Icons.arrow_forward_ios_outlined,
                      size: 15,
                    ),
            ),
          ),
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            height: isYourCommunitiesPressed
                ? 50.0 * (yourCommunities.length + 2)
                : 0,
            child: Column(
              children: [
                Flexible(
                  child: isYourCommunitiesPressed
                      ? Container(
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: 2 + yourCommunities.length,
                            itemBuilder: (context, index) {
                              yourCommunities.sort();
                              return SizedBox(
                                  height: 50,
                                  child: index == 0
                                      ? ListTile(
                                          leading: Icon(Icons.add),
                                          title: Text("Create a community"),
                                          onTap: () {
                                            Navigator.pushNamed(context,
                                                'create_community_screen');
                                          },
                                        )
                                      : index != 1 + yourCommunities.length
                                          ? ListTile(
                                              title: Row(
                                                children: [
                                                  Image(
                                                    image: AssetImage(
                                                        'assets/images/community_logo.png'),
                                                    height: 23,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(
                                                      'r/${yourCommunities[index - 1]}',
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 15,
                                                      ),
                                                    ),
                                                  ),
                                                  Spacer(),
                                                  GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        favoriteCommunities
                                                                .contains(
                                                                    yourCommunities[
                                                                        index -
                                                                            1])
                                                            ? favoriteCommunities
                                                                .remove(
                                                                    yourCommunities[
                                                                        index -
                                                                            1])
                                                            : favoriteCommunities
                                                                .add(
                                                                    yourCommunities[
                                                                        index -
                                                                            1]);
                                                      });
                                                    },
                                                    child: Icon(
                                                      favoriteCommunities
                                                              .contains(
                                                                  yourCommunities[
                                                                      index -
                                                                          1])
                                                          ? Icons.star_rounded
                                                          : Icons
                                                              .star_border_rounded,
                                                      color: Colors.grey,
                                                      size: 23,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            )
                                          : ListTile(
                                              title: Row(
                                                children: [
                                                  Icon(Icons.feed_outlined),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(
                                                      'Custom Feeds',
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 15,
                                                      ),
                                                    ),
                                                  ),
                                                  Spacer(),
                                                  GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        favoriteCommunities
                                                                .contains(
                                                                    'Custom Feeds')
                                                            ? favoriteCommunities
                                                                .remove(
                                                                    'Custom Feeds')
                                                            : favoriteCommunities
                                                                .add(
                                                                    'Custom Feeds');
                                                      });
                                                    },
                                                    child: Icon(
                                                      favoriteCommunities
                                                              .contains(
                                                                  'Custom Feeds')
                                                          ? Icons.star_rounded
                                                          : Icons
                                                              .star_border_rounded,
                                                      color: Colors.grey,
                                                      size: 23,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ));
                            },
                          ),
                        )
                      : Container(),
                ),
              ],
            ),
          ),
          Divider(),
          ListTile(
            title: Row(
              children: [
                Container(
                  width: 18,
                  height: 18,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white,
                      width: 1,
                    ),
                  ),
                  child: Icon(
                    Icons.bar_chart_rounded,
                    color: Colors.white,
                    size: 15,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'All',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDrawerTwo() {
    return SafeArea(
      child: Column(
        children: [
          SizedBox(height: 15), //REFACTOR THIS
          Row(
            children: [
              IconButton(
                  onPressed: () {
                    setState(() {
                      isRecentlyVisitedDrawerVisible = false;
                    });
                  },
                  icon: Icon(Icons.arrow_back)),
              Text(
                'Recently Visited',
                style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
              ),
              Spacer(),
              GestureDetector(
                onTap: () {
                  setState(() {
                    recentlyVisitedCommunities.clear();
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: Text(
                    'Clear all',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Container(
            height: 300,
            child: Column(
              children: [
                Flexible(
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: recentlyVisitedCommunities.length,
                    itemBuilder: (context, index) {
                      return Container(
                        height: 48,
                        child: ListTile(
                          leading: Image(
                            image:
                                AssetImage('assets/images/community_logo.png'),
                            height: 23,
                          ),
                          title: Text(
                            recentlyVisitedCommunities[index],
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                          trailing: IconButton(
                            onPressed: () {
                              setState(() {
                                recentlyVisitedCommunities
                                    .remove(recentlyVisitedCommunities[index]);
                              });
                            },
                            icon: Icon(
                              Icons.close,
                              color: Colors.grey,
                              size: 20,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String selectedMenuItem = "Home";
  final List<String> menuItems = ['Home', 'Popular', 'Latest News'];
  List<Post> posts = [
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

  Future<void> _refreshData() async {
    // try {
    //   var newPosts = await ApiService("https://mestanyElBackend.com").fetchPosts();
    //   setState(() {
    //     posts = newPosts;
    //   });
    // } catch (e) {
    //   print('Failed to refresh posts: $e');
    //   // Handle the error (e.g., show a message to the user)
    // }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 2.0),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  isRecentlyVisitedDrawerVisible = false;
                });
                _scaffoldKey.currentState?.openDrawer();
              },
              child: Icon(
                Icons.menu,
                size: 30,
                color: Colors.white,
              ),
            ),
          ),
          title: Row(
            children: [
              Text(
                selectedMenuItem,
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              Icon(
                Icons.arrow_drop_down,
                size: 30,
                color: Colors.white,
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
        body: RefreshIndicator(
            onRefresh: _refreshData,
            child: ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) {
                return PostCard(post: posts[index]);
              },
            )),
        drawer: Drawer(
            backgroundColor: kBackgroundColor,
            child: isRecentlyVisitedDrawerVisible
                ? buildDrawerTwo()
                : buildDrawerOne()),
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
                    child: Text('P'),
                    radius: ScreenSizeHandler.bigger *
                        kSideBarCircleAvatarRadiusRatio,
                    foregroundImage:
                        AssetImage('assets/images/reddit_logo.png'),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      bottom: ScreenSizeHandler.screenHeight * 0.015),
                  child: GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return DrawerBottomSheet();
                          // return Container(
                          //   constraints: BoxConstraints(
                          //     maxHeight: isExitPressed?ScreenSizeHandler.screenHeight * 0.2:ScreenSizeHandler.screenHeight * 0.35,
                          //   ),
                          //   color: kBackgroundColor,
                          //   child: Column(
                          //     crossAxisAlignment: CrossAxisAlignment.start,
                          //     children: [
                          //       Padding(
                          //         padding: EdgeInsets.only(
                          //             left: ScreenSizeHandler.screenWidth * 0.05,
                          //             // bottom: ScreenSizeHandler.screenHeight * 0.02,
                          //             top: ScreenSizeHandler.screenHeight * 0.01,
                          //         ),
                          //         child: Text(
                          //           isExitPressed?'u/$username':'ACCOUNTS',
                          //           style: TextStyle(
                          //             color: Colors.white38,
                          //             fontSize: ScreenSizeHandler.smaller * kAcknowledgeTextSmallerFontRatio,
                          //           ),
                          //         ),
                          //       ),
                          //        Expanded(
                          //         child: Padding(
                          //           padding: EdgeInsets.symmetric(
                          //             horizontal: ScreenSizeHandler.screenWidth * 0.05,
                          //           ),
                          //           child: const Divider(
                          //             color: Colors.white38,
                          //             thickness: 1,
                          //           ),
                          //         )
                          //       ),
                          //       isExitPressed?
                          //       ButtonBar(
                          //         alignment: MainAxisAlignment.start,

                          //         children: [
                          //           Icon(Icons.exit_to_app, color: Colors.white38),
                          //           Text(
                          //             'Logout',
                          //             style: TextStyle(
                          //               color: Colors.red,
                          //               fontSize: ScreenSizeHandler.smaller * kAcknowledgeTextSmallerFontRatio*1.1,
                          //             ),
                          //           ),
                          //         ],
                          //       )
                          //       :
                          //       Column(
                          //         children: [
                          //           ListTile(
                          //             leading: CircleAvatar(
                          //               backgroundColor: Colors.white,
                          //               child: Text('P'),
                          //               radius: ScreenSizeHandler.smaller * 0.03,
                          //             ),
                          //             title: Row(
                          //               children: [
                          //                 Text(
                          //                   'u/$username',
                          //                   style: TextStyle(
                          //                     color: Colors.white,
                          //                     fontSize: ScreenSizeHandler.smaller * kAcknowledgeTextSmallerFontRatio*1.1,
                          //                   ),
                          //                 ),
                          //                 SizedBox(width: ScreenSizeHandler.screenWidth * 0.34),
                          //                 const Icon(Icons.check, color: Colors.blue),
                          //                 IconButton(onPressed: (){
                          //                   setState(() {
                          //                     isExitPressed = true;
                          //                   });
                          //                 }, icon: const Icon(Icons.exit_to_app), color: Colors.white38,

                          //                 ),

                          //               ],
                          //             ),
                          //           ),
                          //       ListTile(
                          //         leading: CircleAvatar(
                          //           backgroundColor: Colors.white,
                          //           child: Text('A'),
                          //           radius: ScreenSizeHandler.smaller * 0.03,
                          //         ),
                          //         title: Text(
                          //           'Anonymous Browsing',
                          //           style: TextStyle(
                          //             color: Colors.white,
                          //             fontSize: ScreenSizeHandler.smaller * kAcknowledgeTextSmallerFontRatio*1.1,
                          //           ),
                          //         ),
                          //       ),
                          //       ListTile(
                          //         leading: Icon(Icons.add),
                          //         title: Text(
                          //           'Add account',
                          //           style: TextStyle(
                          //             color: Colors.white,
                          //             fontSize: ScreenSizeHandler.smaller * kAcknowledgeTextSmallerFontRatio*1.1,
                          //           ),
                          //         ),
                          //       ),
                          //         ],
                          //       ),
                          //       ContinueButton(
                          //         text: 'CLOSE',
                          //         onPress: () {
                          //           isExitPressed=false;
                          //           Navigator.pop(context);
                          //         },
                          //         textColor: kHintTextColor,
                          //       ),
                          //     ],
                          //   ),
                          // );
                        },
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('u/$username',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: ScreenSizeHandler.bigger * 0.023,
                                fontWeight: FontWeight.bold)),
                        Icon(Icons.keyboard_arrow_down_rounded),
                      ],
                    ),
                  ),
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
                      height: ScreenSizeHandler.bigger * 0.03,
                      width: onlineStatusWidth * 0.8,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: onlineStatusColor,
                          width: ScreenSizeHandler.smaller * 0.005,
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
                                  fontSize: ScreenSizeHandler.smaller * 0.027,
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
                    Navigator.pushNamed(context, 'account_settings_screen');
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildPostCard(Post post) {
    return Container(
      color: kBackgroundColor,
      child: Column(
        children: [
          ListTile(
            leading: CircleAvatar(radius: 15),
            title: Text(post.username, style: TextStyle(color: Colors.white)),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  post.contentTitle,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  post.content,
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: kBackgroundColor,
                      borderRadius: BorderRadius.circular(15.0),
                      border: Border.all(
                        color: kFillingColor,
                      ),
                    ),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              post.isUpvoted ? post.upvotes-- : post.upvotes++;
                              post.isUpvoted = !post.isUpvoted;
                              post.isDownvoted = false;
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 8.0, right: 8.0, top: 3.0, bottom: 4.0),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.arrow_upward,
                                  color: post.isUpvoted
                                      ? Colors.red
                                      : Colors.white,
                                  size: 18.0,
                                ),
                                Text(
                                  post.upvotes.toString(),
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 12.0),
                                )
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              post.isDownvoted
                                  ? post.upvotes++
                                  : post.upvotes--;
                              post.isDownvoted = !post.isDownvoted;
                              post.isUpvoted = false;
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.arrow_downward,
                                  color: post.isDownvoted
                                      ? const Color.fromARGB(255, 110, 85, 114)
                                      : Colors.white,
                                  size: 18.0,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      // Handle comment button tap
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.only(right: 10.0, left: 10.0),
                            child: Row(
                              children: [
                                Container(
                                    decoration: BoxDecoration(
                                      color: kBackgroundColor,
                                      borderRadius: BorderRadius.circular(15.0),
                                      border: Border.all(
                                        color: kFillingColor,
                                      ),
                                    ),
                                    child: Row(children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Icon(
                                          Icons.comment,
                                          size: 15,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Text(
                                          post.comments.toString(),
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12.0),
                                        ),
                                      )
                                    ])),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return SafeArea(
                        child: Container(
                          decoration: BoxDecoration(
                            color: kBackgroundColor,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20.0),
                              topRight: Radius.circular(20.0),
                            ),
                          ),
                          padding: EdgeInsets.all(16.0),
                          constraints: BoxConstraints(
                            maxHeight:
                                MediaQuery.of(context).size.height * 0.35,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Share to...",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.0,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(height: 100.0),
                              SizedBox(height: 16.0),
                              Text(
                                "Your username stays hidden when you share outside of Reddit",
                                style: TextStyle(
                                  fontSize: 12.0,
                                  color: kHintTextColor,
                                ),
                              ),
                              SizedBox(height: 16.0),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Icon(Icons.facebook, color: Colors.white),
                                  Icon(Icons.copy, color: Colors.white),
                                  Icon(Icons.email, color: Colors.white),
                                  Icon(Icons.more_horiz, color: Colors.white),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
                child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      border: Border.all(
                        color: kFillingColor,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: Icon(
                              Icons.share,
                              size: 12,
                              color: Colors.white,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Text("147",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                )),
                          ),
                        ],
                      ),
                    )),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class DrawerBottomSheet extends StatefulWidget {
  // final bool isExitPressed;
  const DrawerBottomSheet({super.key});
  @override
  State<DrawerBottomSheet> createState() => _DrawerBottomSheetState();
}

class _DrawerBottomSheetState extends State<DrawerBottomSheet> {
  String username = "peter_ashraf";
  bool isExitPressed = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: isExitPressed
            ? ScreenSizeHandler.screenHeight * 0.2
            : ScreenSizeHandler.screenHeight * 0.35,
      ),
      color: kBackgroundColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: ScreenSizeHandler.screenWidth * 0.05,
              // bottom: ScreenSizeHandler.screenHeight * 0.02,
              top: ScreenSizeHandler.screenHeight * 0.01,
            ),
            child: Text(
              isExitPressed ? 'u/$username' : 'ACCOUNTS',
              style: TextStyle(
                color: Colors.white38,
                fontSize: ScreenSizeHandler.smaller *
                    kAcknowledgeTextSmallerFontRatio,
              ),
            ),
          ),
          Expanded(
              child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: ScreenSizeHandler.screenWidth * 0.05,
            ),
            child: const Divider(
              color: Colors.white38,
              thickness: 1,
            ),
          )),
          isExitPressed
              ? GestureDetector(
                  onTap: () {
                    Navigator.popUntil(context, ModalRoute.withName('/'));
                    Navigator.pushNamed(context, LoginScreen.id);
                  },
                  child: ButtonBar(
                    alignment: MainAxisAlignment.start,
                    children: [
                      Icon(Icons.exit_to_app, color: Colors.white38),
                      Text(
                        'Logout',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: ScreenSizeHandler.smaller *
                              kAcknowledgeTextSmallerFontRatio *
                              1.1,
                        ),
                      ),
                    ],
                  ),
                )
              : Column(
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Text('P'),
                        radius: ScreenSizeHandler.smaller * 0.03,
                      ),
                      title: Row(
                        children: [
                          Text(
                            'u/$username',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: ScreenSizeHandler.smaller *
                                  kAcknowledgeTextSmallerFontRatio *
                                  1.1,
                            ),
                          ),
                          SizedBox(width: ScreenSizeHandler.screenWidth * 0.34),
                          const Icon(Icons.check, color: Colors.blue),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                isExitPressed = true;
                              });
                            },
                            icon: const Icon(Icons.exit_to_app),
                            color: Colors.white38,
                          ),
                        ],
                      ),
                    ),
                    ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Text('A'),
                        radius: ScreenSizeHandler.smaller * 0.03,
                      ),
                      title: Text(
                        'Anonymous Browsing',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: ScreenSizeHandler.smaller *
                              kAcknowledgeTextSmallerFontRatio *
                              1.1,
                        ),
                      ),
                    ),
                    ListTile(
                      leading: Icon(Icons.add),
                      title: Text(
                        'Add account',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: ScreenSizeHandler.smaller *
                              kAcknowledgeTextSmallerFontRatio *
                              1.1,
                        ),
                      ),
                    ),
                  ],
                ),
          ContinueButton(
            text: 'CLOSE',
            onPress: () {
              isExitPressed = false;
              Navigator.pop(context);
            },
            textColor: kHintTextColor,
          ),
        ],
      ),
    );
  }
}
