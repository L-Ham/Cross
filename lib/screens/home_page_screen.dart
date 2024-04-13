import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:reddit_bel_ham/components/home_page_components/post_card.dart';
import 'package:reddit_bel_ham/components/home_page_components/profile_icon_with_indicator.dart';
import 'package:reddit_bel_ham/components/settings_components/settings_tile.dart';
import 'package:reddit_bel_ham/components/settings_components/settings_tile_leading_icon.dart';
import 'package:reddit_bel_ham/constants.dart';
import 'package:reddit_bel_ham/screens/add_post_screen.dart';
import 'package:reddit_bel_ham/screens/community_rules_screen.dart';
import 'package:reddit_bel_ham/screens/home_page_seach_screen.dart';
import 'package:reddit_bel_ham/screens/inbox_messages.dart';
import 'package:reddit_bel_ham/utilities/screen_size_handler.dart';
import 'package:reddit_bel_ham/utilities/token_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:reddit_bel_ham/screens/settings_screen.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:reddit_bel_ham/components/home_page_components/trending_posts.dart';

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
  double onlineStatusWidth = ScreenSizeHandler.smaller * 0.42;
  late String email;

  int navigationBarIndex=0;
  int oldIndex=0;
  @override
  void initState() {
    super.initState();
    username = TokenDecoder.username;
    email = TokenDecoder.email;
  }
  

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
      oldIndex=navigationBarIndex;
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
        bottomNavigationBar:BottomNavigationBar(
      selectedFontSize: kAcknowledgeTextSmallerFontRatio* ScreenSizeHandler.smaller*0.9,
      unselectedFontSize: kAcknowledgeTextSmallerFontRatio* ScreenSizeHandler.smaller*0.9,
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
        key: _scaffoldKey,
        appBar: AppBar(
          leading:  Padding(
            padding: EdgeInsets.only(left: ScreenSizeHandler.screenWidth * 0.018, right: ScreenSizeHandler.screenWidth * 0.02),
            child: GestureDetector(
              onTap: () {
                _scaffoldKey.currentState?.openDrawer();
              },
              child: Icon(
                Icons.menu,
                size: ScreenSizeHandler.smaller * 0.085,
                color: Colors.white,
              ),
            ),
          ),
          title: navigationBarIndex==0?
          DropdownButtonHideUnderline(
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
          : navigationBarIndex==1?
          Padding(
            padding: EdgeInsets.only(left: ScreenSizeHandler.screenWidth * 0.15, ),
            child: Center(child: Text('Communities', style: TextStyle(fontSize: ScreenSizeHandler.smaller* kButtonSmallerFontRatio*1.1),),),
          )
          :navigationBarIndex==3?
          Padding(
            padding: EdgeInsets.only(left: ScreenSizeHandler.screenWidth * 0.15, ),
            child: Center(child: Text('Chat', style: TextStyle(fontSize: ScreenSizeHandler.smaller* kButtonSmallerFontRatio*1.1),),),
          )
          :navigationBarIndex==4?
          Padding(
            padding: EdgeInsets.only(left: ScreenSizeHandler.screenWidth * 0.15, ),
            child: Center(child: Text('Inbox', style: TextStyle(fontSize: ScreenSizeHandler.smaller* kButtonSmallerFontRatio*1.1),),),
          )
          :Center(child: Text(''),),
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
                padding: EdgeInsets.all(ScreenSizeHandler.smaller * 0.01),
                child: Icon(
                  Icons.search,
                  size: ScreenSizeHandler.smaller * 0.095,
                  color: Colors.white,
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
        body: navigationBarIndex==1?
        Padding(
          padding: EdgeInsets.only(left: ScreenSizeHandler.screenWidth * 0.15, ),
          child: Center(child: Text('Communities', style: TextStyle(fontSize: ScreenSizeHandler.smaller* kButtonSmallerFontRatio*1.1),),),
        )
        :navigationBarIndex==3?
        Padding(
          padding: EdgeInsets.only(left: ScreenSizeHandler.screenWidth * 0.15, ),
          child: Center(child: Text('Chat', style: TextStyle(fontSize: ScreenSizeHandler.smaller* kButtonSmallerFontRatio*1.1),),),
        )
        :navigationBarIndex==4?
        InboxMessagesScreen()
        :
        PageView(
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
                  return PostCard(post: posts[index]);
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
                              left: ScreenSizeHandler.screenWidth * 0.02,
                              right: ScreenSizeHandler.screenWidth * 0.02),
                          child: Icon(
                            Icons.trending_up_rounded,
                            color: Colors.white,
                            size: ScreenSizeHandler.smaller * 0.055,
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
                          .map((post) => TrendingPostCard(post: post))
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
        drawer: const Drawer(),
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
                    radius: ScreenSizeHandler.bigger *
                        kSideBarCircleAvatarRadiusRatio,
                    foregroundImage:
                        const AssetImage('assets/images/reddit_logo.png'),
                    child: const Text('A'),
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
                        onlineStatusColor =
                            const Color.fromARGB(255, 0, 204, 120);
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
                  trailingWidget: Icon(Icons.nights_stay_sharp, size: ScreenSizeHandler.smaller*0.063),
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