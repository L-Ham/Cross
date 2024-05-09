import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:reddit_bel_ham/components/general_components/continue_button.dart';
import 'package:reddit_bel_ham/components/general_components/reddit_loading_indicator.dart';
import 'package:reddit_bel_ham/components/home_page_components/drawer_one.dart';
import 'package:reddit_bel_ham/components/home_page_components/drawer_two.dart';
import 'package:reddit_bel_ham/components/home_page_components/end_Drawer.dart';
import 'package:reddit_bel_ham/components/home_page_components/mark_all_as_read.dart';
import 'package:reddit_bel_ham/components/home_page_components/post_card.dart';
import 'package:reddit_bel_ham/components/home_page_components/profile_icon_with_indicator.dart';
import 'package:reddit_bel_ham/components/settings_components/settings_tile.dart';
import 'package:reddit_bel_ham/components/settings_components/settings_tile_leading_icon.dart';
import 'package:reddit_bel_ham/components/subreddit_components/subreddit_ellipsis_bottom_sheet.dart';
import 'package:reddit_bel_ham/constants.dart';
import 'package:reddit_bel_ham/screens/add_post_screen.dart';
import 'package:reddit_bel_ham/screens/comments_screen.dart';
import 'package:reddit_bel_ham/screens/communities_screen.dart';
import 'package:reddit_bel_ham/screens/community_rules_screen.dart';
import 'package:reddit_bel_ham/screens/home_page_seach_screen.dart';
import 'package:reddit_bel_ham/screens/inbox_messages.dart';
import 'package:reddit_bel_ham/screens/about_you_screen.dart';
import 'package:reddit_bel_ham/screens/home_page_seach_screen.dart';
import 'package:reddit_bel_ham/screens/login_screen.dart';
import 'package:reddit_bel_ham/screens/notifications_settings_screen.dart';

import 'package:reddit_bel_ham/utilities/screen_size_handler.dart';
import 'package:reddit_bel_ham/services/api_service.dart';
import 'package:reddit_bel_ham/utilities/subreddit_store.dart';
import 'package:reddit_bel_ham/utilities/token_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:reddit_bel_ham/screens/settings_screen.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:reddit_bel_ham/components/home_page_components/trending_posts.dart';

import '../components/messaging_components/inbox_bottom_sheet.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({super.key});
  static const id = 'home_page_screen';

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  PageController controller = PageController();
  String username = "peter_ashraf";
  String onlineStatusString = "On";
  bool onlineStatusToggle = true;
  Color onlineStatusColor = kOnlineStatusColor;
  double onlineStatusWidth = ScreenSizeHandler.smaller * 0.5;

  ApiService apiService = ApiService(TokenDecoder.token);

  Future<void> logout() async {
    await apiService.logout();
  }

  @override
  void initState() {
    super.initState();
    username = TokenDecoder.username;
    email = TokenDecoder.email;
  }

  bool isRecentlyVisitedDrawerVisible = false;
  void setIsRecentlyVisitedDrawerVisibleCbk(bool value) {
    setState(() {
      isRecentlyVisitedDrawerVisible = value;
    });
  }

  bool isMarkingAllAsRead = false;

  late String email;

  int navigationBarIndex = 0;
  int oldIndex = 0;

  String selectedMenuItem = "Home";

  final List<DropdownMenuItem<String>> dropdownItems = [
    DropdownMenuItem<String>(
      value: 'Home',
      child: Row(
        children: [
          const Icon(Icons.home),
          SizedBox(
              width: ScreenSizeHandler.screenWidth *
                  0.05), // Adjust the spacing as needed
          const Text('Home'),
        ],
      ),
    ),
    DropdownMenuItem<String>(
      value: 'Popular',
      child: Row(
        children: [
          const Icon(Icons.arrow_outward_outlined),
          SizedBox(
              width: ScreenSizeHandler.screenWidth *
                  0.05), // Adjust the spacing as needed
          const Text('Popular'),
        ],
      ),
    ),
    DropdownMenuItem<String>(
      value: 'Latest',
      child: Row(
        children: [
          const Icon(Icons.settings),
          SizedBox(
              width: ScreenSizeHandler.screenWidth *
                  0.05), // Adjust the spacing as needed
          const Text('Latest'),
        ],
      ),
    )
  ];

  final List<Post> posts = [
    Post(
      userId: "1",
      postId: "1",
      createdFrom: "1h",
      subredditName: "r/DanielAdel",
      contentTitle: "Foodie Instagrammers, Let's Talk Strategy!",
      content:
          "Hey fellow food lovers! I've been diving deep into the world of food photography on Instagram lately, and I wanted to pick your brains about strategies for making our food posts stand out. It's incredible how much competition there is out there, right? I mean, everyone's snapping pics of their avocado toast and artisanal burgers. So, what are your go-to tips for making our food shots pop? Do you swear by natural lighting or do you have some secret editing tricks up your sleeve? And let's talk about captions too! I'm always struggling to strike the right balance between informative and witty. Let's share some wisdom and help each other elevate our Instagram game to the next level! 🍕✨",
      upvotes: 78,
      comments: 141,
      type: "text",
      image: [""],
      link: "",
      video: "",
    ),
    Post(
      userId: "1",
      postId: "2",
      createdFrom: "1h",
      subredditName: "r/AnnieBakesCakes",
      contentTitle: "Curating Culinary Moments on Instagram: Tips & Tricks!",
      content:
          "Hey foodies! I've been pondering tellow fthe world of food photography on Instagram lately, and I wanted to pick your brains about strategies for making our food posts stand out. It's incredible how much competition there is out there, right? I mean, everyone's snapping pics of their avocado toast and artisanal burgers. So, what are your go-to tips for making our food shots pop? Dood lovers! I've been diving deep into the world of food photography on Instagram lately, and I wanted to pick your brains about strategies for making our food posts stand out. Ihe art of curating culinary moments on Instagram latelto learn from your experien",
      upvotes: 20,
      comments: 35,
      type: "image",
      image: [
        "assets/images/elham_logo.png",
        "assets/images/redditAvata2.png",
        "assets/images/peter_nayem.png"
      ],
      link: "",
      video: "",
    ),
    Post(
      userId: "1",
      postId: "3",
      createdFrom: "7d",
      subredditName: "r/JohannaDoesYoga",
      contentTitle:
          "Is instagram buggering up for anyone else? I can't post anything",
      content:
          "Check this page for more detailsjrhgshejaiajirjsijijfiarjgiajeijgiohgijaerigjiorhgiqjarigvja",
      upvotes: 90,
      comments: 35,
      type: "link",
      image: [""],
      link: "https://www.instagram.com",
      video: "",
    ),
    Post(
      userId: "1",
      postId: '4',
      createdFrom: "4d",
      subredditName: "r/JohannaDoesYoga",
      contentTitle: "instagram",
      content: "Check this page for more details",
      upvotes: 90,
      comments: 35,
      type: "poll",
      image: [""],
      link: "",
      video: "",
      isPollVoted: false,
      numOfVotersPerOption: [10, 20, 30],
      options: ["Ziko", "Dani", "Mahmoud"],
    ),
    // Post(
    //   username: "r/JohannaDoesYoga",
    //   contentTitle: "this is a video",
    //   content: "enjoy",
    //   upvotes: 90,
    //   comments: 35,
    //   type: "video",
    //   image: [""],
    //   link: "",
    //   video: "assets/videos/video.mp4",
    // )
  ];
  final List<TrendingPost> trending = [
    TrendingPost(
      contentTitle: "Peter nayem 3al ard",
      // content: "Check this page for more details",
      image: const AssetImage('assets/images/peter_nayem.png'),
    ),
    TrendingPost(
      contentTitle: "Habouba nayma",
      // content: "Check this page for more details",
      image: const AssetImage('assets/images/habouba_nayma.png'),
    ),
    TrendingPost(
      contentTitle: "David nayem",
      // content: "Check this page for more details",
      image: const AssetImage('assets/images/david_nayem.png'),
    ),
    TrendingPost(
      contentTitle: "Nardo nayma",
      // content: "Check this page for more details",
      image: const AssetImage('assets/images/nardo_nayma.png'),
    ),
    TrendingPost(
      contentTitle: "Daniel haymawetna",
      // content: "Check this page for more details",
      image: const AssetImage('assets/images/daniel_haymawetna.png'),
    )
  ];
  void _onItemTapped(int index) {
    setState(() {
      oldIndex = navigationBarIndex;
      navigationBarIndex = index;
    });
    if (index == 2) {
      Navigator.pushNamed(context, AddPostScreen.id);
      setState(() {
        navigationBarIndex = oldIndex;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        bottomNavigationBar: Theme(
          data: ThemeData(
            splashColor: kBackgroundColor,
            highlightColor: kBackgroundColor,
          ),
          child: BottomNavigationBar(
            selectedFontSize: kAcknowledgeTextSmallerFontRatio *
                ScreenSizeHandler.smaller *
                0.9,
            unselectedFontSize: kAcknowledgeTextSmallerFontRatio *
                ScreenSizeHandler.smaller *
                0.9,
            type: BottomNavigationBarType.fixed,
            backgroundColor: kBackgroundColor,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
                // backgroundColor: Colors.black,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.group_outlined),
                label: 'Communities',

                // backgroundColor: Colors.black,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.add_outlined),
                label: 'Create',
                // backgroundColor: Colors.black,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.messenger_outline_sharp),
                label: 'Chat',
                // backgroundColor: Colors.black,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.notifications_none_rounded),
                label: 'Inbox',

                // backgroundColor: Colors.black,
              ),
            ],
            currentIndex: navigationBarIndex,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.grey,
            unselectedLabelStyle: TextStyle(color: Colors.grey),
            showUnselectedLabels: true,
            onTap: _onItemTapped,
          ),
        ),
        key: _scaffoldKey,
        appBar: AppBar(
          leading: Padding(
            padding: EdgeInsets.only(
                left: ScreenSizeHandler.screenWidth * 0.018,
                right: ScreenSizeHandler.screenWidth * 0.02),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  isRecentlyVisitedDrawerVisible = false;
                });
                _scaffoldKey.currentState?.openDrawer();
              },
              child: Icon(
                Icons.menu,
                size: ScreenSizeHandler.smaller * 0.085,
                color: Colors.white,
              ),
            ),
          ),
          title: navigationBarIndex == 0
              ? DropdownButtonHideUnderline(
                  child: DropdownButton2(
                    items: dropdownItems,
                    onChanged: (String? newValue) {
                      if (newValue != "Latest") {
                        setState(() {
                          selectedMenuItem = newValue!;
                        });
                        if (selectedMenuItem == "Home") {
                          controller.jumpToPage(0);
                        }
                        if (selectedMenuItem == "Popular") {
                          controller.jumpToPage(1);
                        }
                      }
                    },
                    value: selectedMenuItem,
                    selectedItemBuilder: (BuildContext context) {
                      return dropdownItems
                          .map<Widget>((DropdownMenuItem<String> item) {
                        return Text(item.value!);
                      }).toList();
                    },
                    dropdownStyleData: DropdownStyleData(
                      width: ScreenSizeHandler.screenWidth,
                    ),
                    underline: null,
                    isDense: true,
                    iconStyleData: IconStyleData(
                        icon: Icon(Icons.keyboard_arrow_down_outlined,
                            color: Colors.white,
                            size: ScreenSizeHandler.smaller * 0.045)),
                    buttonStyleData: ButtonStyleData(
                      padding: EdgeInsets.symmetric(
                        vertical: ScreenSizeHandler.screenHeight * 0.01,
                        horizontal: ScreenSizeHandler.screenWidth * 0.02,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey[800],
                        borderRadius: BorderRadius.circular(7),
                      ),
                      width: ScreenSizeHandler.screenWidth * 0.25,
                      height: ScreenSizeHandler.bigger * 0.041,
                    ),
                    isExpanded: true,
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                )
              : navigationBarIndex == 1
                  ? Padding(
                      padding: EdgeInsets.only(
                        left: ScreenSizeHandler.screenWidth * 0.15,
                      ),
                      child: Center(
                        child: Text(
                          'Communities',
                          style: TextStyle(
                              fontSize: ScreenSizeHandler.smaller *
                                  kButtonSmallerFontRatio *
                                  1.1,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    )
                  : navigationBarIndex == 3
                      ? Padding(
                          padding: EdgeInsets.only(
                            left: ScreenSizeHandler.screenWidth * 0.05,
                          ),
                          child: Center(
                            child: Text(
                              'Chat',
                              style: TextStyle(
                                  fontSize: ScreenSizeHandler.smaller *
                                      kButtonSmallerFontRatio *
                                      1.1,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        )
                      : navigationBarIndex == 4
                          ? Padding(
                              padding: EdgeInsets.only(
                                left: ScreenSizeHandler.screenWidth * 0.05,
                              ),
                              child: Center(
                                child: Text(
                                  'Inbox',
                                  style: TextStyle(
                                      fontSize: ScreenSizeHandler.smaller *
                                          kButtonSmallerFontRatio *
                                          1.1,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            )
                          : Center(
                              child: Text(''),
                            ),
          backgroundColor: Colors.black,
          actions: [
            Visibility(
              visible: navigationBarIndex == 0 || navigationBarIndex == 1,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SearchScreen()),
                  );
                },
                child: Padding(
                  padding: EdgeInsets.all(ScreenSizeHandler.smaller * 0.01),
                  child: Icon(
                    Icons.search,
                    size: ScreenSizeHandler.smaller * 0.095,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Visibility(
              visible: navigationBarIndex == 4,
              child: GestureDetector(
                onTap: () async {
                  var choice = await showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return const InboxBottomSheet();
                    },
                  );
                  if (choice == 2) {
                    Provider.of<MarkAllAsRead>(context, listen: false).notify();
                  }
                },
                child: Icon(
                  Icons.more_horiz,
                  color: Colors.white,
                  size: ScreenSizeHandler.bigger * 0.032,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(ScreenSizeHandler.smaller * 0.03),
              child: GestureDetector(
                onTap: () {
                  _scaffoldKey.currentState?.openEndDrawer();
                },
                child: ProfileIconWithIndicator(isOnline: onlineStatusToggle),
              ),
            ),
          ],
        ),
        body: navigationBarIndex == 1
            ? const CommunitiesScreen()
            : navigationBarIndex == 3
                ? Padding(
                    padding: EdgeInsets.only(
                      left: ScreenSizeHandler.screenWidth * 0.1,
                    ),
                    child: Center(
                      child: Text(
                        'Chat',
                        style: TextStyle(
                            fontSize: ScreenSizeHandler.smaller *
                                kButtonSmallerFontRatio *
                                1.1),
                      ),
                    ),
                  )
                : navigationBarIndex == 4
                    ? isMarkingAllAsRead
                        ? const Center(child: RedditLoadingIndicator())
                        : const InboxMessagesScreen()
                    : PageView(
                        controller: controller,
                        onPageChanged: (value) => setState(() {
                          if (value == 0) {
                            selectedMenuItem = "Home";
                          } else {
                            selectedMenuItem = "Popular";
                          }
                        }),
                        children: [
                          SingleChildScrollView(
                            child: ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: posts.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, CommentsScreen.id,
                                        arguments: {"post": posts[index]});
                                  },
                                  child: PostCard(
                                    post: posts[index],
                                  ),
                                );
                              },
                            ),
                          ),
                          SingleChildScrollView(
                            child: Column(
                              children: [
                                Container(
                                  height: ScreenSizeHandler.screenHeight * 0.05,
                                  color: Colors.black,
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left:
                                                ScreenSizeHandler.screenWidth *
                                                    0.02,
                                            right:
                                                ScreenSizeHandler.screenWidth *
                                                    0.02),
                                        child: Icon(
                                          Icons.trending_up_rounded,
                                          color: Colors.white,
                                          size:
                                              ScreenSizeHandler.smaller * 0.055,
                                        ),
                                      ),
                                      const Text(
                                        'Trending Today',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: kDefaultFontSize,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: trending
                                        .map((post) =>
                                            TrendingPostCard(post: post))
                                        .toList(),
                                  ),
                                ),
                                ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: posts.length,
                                  itemBuilder: (context, index) {
                                    return PostCard(post: posts[index]);
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
        drawer: Drawer(
          backgroundColor: kBackgroundColor,
          elevation: 0,
          child: isRecentlyVisitedDrawerVisible
              ? DrawerTwo(
                  setIsRecentlyVisitedDrawerVisibleCbk:
                      setIsRecentlyVisitedDrawerVisibleCbk)
              : DrawerOne(
                  setIsRecentlyVisitedDrawerVisibleCbk:
                      setIsRecentlyVisitedDrawerVisibleCbk),
        ),
        endDrawer: EndDrawer(
          username: username,
          onlineStatusToggle: onlineStatusToggle,
          onlineStatusString: onlineStatusString,
          onlineStatusColor: onlineStatusColor,
          onlineStatusWidth: onlineStatusWidth,
          toggleOnlineStatus: (p0) => setState(() {
            onlineStatusToggle = p0;
            onlineStatusString = onlineStatusToggle ? "On" : "Off";
            onlineStatusColor =
                onlineStatusToggle ? kOnlineStatusColor : kOfflineStatusColor;
            onlineStatusWidth = onlineStatusToggle
                ? ScreenSizeHandler.smaller * 0.5
                : ScreenSizeHandler.smaller * 0.42;
          }),
        ),
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
  late String username;
  @override
  void initState() {
    super.initState();
    username = TokenDecoder.username;
  }

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
              ? Semantics(
                  identifier: 'second_exit_app_button_identifier',
                  child: SettingsTile(
                    fontColor: Colors.red,
                    onTap: () async {
                      var result = await apiService.logout();
                      print(result['']);
                      Navigator.popUntil(context, ModalRoute.withName('/'));
                      Navigator.pushNamed(context, LoginScreen.id);
                      SharedPreferences.getInstance().then((prefs) {
                        prefs.remove('token');
                        SubredditStore().clearSubreddits();
                      });
                    },
                    leadingIcon: Padding(
                      padding: EdgeInsets.only(
                          right: ScreenSizeHandler.screenWidth * 0.03),
                      child: Icon(Icons.exit_to_app, color: Colors.white38),
                    ),
                    titleText: 'Logout',
                  ),
                )
              : Column(
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: ScreenSizeHandler.smaller * 0.03,
                        child: Text('P'),
                      ),
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              'u/$username',
                              softWrap: true,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: ScreenSizeHandler.smaller *
                                    kAcknowledgeTextSmallerFontRatio *
                                    1.1,
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              const Icon(Icons.check, color: Colors.blue),
                              Semantics(
                                identifier: 'first_exit_app_button_identifier',
                                child: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      isExitPressed = true;
                                    });
                                  },
                                  icon: const Icon(Icons.exit_to_app),
                                  color: Colors.white38,
                                ),
                              ),
                            ],
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
