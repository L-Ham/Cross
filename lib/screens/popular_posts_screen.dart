import 'package:flutter/material.dart';
import 'package:reddit_bel_ham/screens/settings_screen.dart';
import 'package:reddit_bel_ham/components/home_page_components/post_card.dart';
import 'package:reddit_bel_ham/components/home_page_components/profile_icon_with_indicator.dart';
import 'package:reddit_bel_ham/components/settings_components/settings_tile.dart';
import 'package:reddit_bel_ham/components/settings_components/settings_tile_leading_icon.dart';
import 'package:reddit_bel_ham/constants.dart';
import 'package:reddit_bel_ham/screens/home_page_seach_screen.dart';
import 'package:reddit_bel_ham/utilities/screen_size_handler.dart';
import 'package:reddit_bel_ham/screens/home_page_screen.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class PopularPostsScreen extends StatefulWidget {
  const PopularPostsScreen({super.key});
  static const id = 'popular_posts_screen';

  @override
  State<PopularPostsScreen> createState() => _PopularPostsScreenState();
}

class _PopularPostsScreenState extends State<PopularPostsScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String username = "peter_ashraf";
  String onlineStatusString = "On";
  bool onlineStatusToggle = true;
  Color onlineStatusColor = kOnlineStatusColor;
  double onlineStatusWidth = ScreenSizeHandler.smaller * 0.42;

  String selectedMenuItem = "Popular";
  final List<String> menuItems = ['Home', 'Popular', 'Latest'];
  final List<Post> posts = [
    Post(
      username: "r/NardoTheFish",
      contentTitle:
          "Is instagram buggering up for anyone else? I can't post anything",
      content: "Check this page for more details",
      upvotes: 90,
      comments: 35,
      type: "text",
      image: "",
      link: "",
    ),
    Post(
      username: "r/DaveTheDude",
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
      username: "r/PeterThePenguin",
      contentTitle: "Curating Culinary Moments on Instagram: Tips & Tricks!",
      content:
          "Hey foodies! I've been pondering tellow fthe world of food photography on Instagram lately, and I wanted to pick your brains about strategies for making our food posts stand out. It's incredible how much competition there is out there, right? I mean, everyone's snapping pics of their avocado toast and artisanal burgers. So, what are your go-to tips for making our food shots pop? Dood lovers! I've been diving deep into the world of food photography on Instagram lately, and I wanted to pick your brains about strategies for making our food posts stand out. Ihe art of curating culinary moments on Instagram latelto learn from your experien",
      upvotes: 20,
      comments: 35,
      type: "text",
      image: "",
      link: "",
    ),
  ];

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
                _scaffoldKey.currentState?.openDrawer();
              },
              child: const Icon(
                Icons.menu,
                size: 30,
                color: Colors.white,
              ),
            ),
          ),
          title: DropdownButtonHideUnderline(
            child: DropdownButton2(
              items: menuItems.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  selectedMenuItem = newValue!;
                });
                if (selectedMenuItem == "Home") {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HomePageScreen()));
                }
              },
              value: selectedMenuItem,
              underline: null,
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
                height: ScreenSizeHandler.screenHeight * 0.05,
              ),
              isExpanded: true,
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),

              
            ),
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
              child: const Padding(
                padding: EdgeInsets.all(2.0),
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

  Widget buildPostCard(Post post) {
    return Container(
      color: kBackgroundColor,
      child: Column(
        children: [
          ListTile(
            leading: const CircleAvatar(radius: 15),
            title: Text(post.username,
                style: const TextStyle(color: Colors.white)),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  post.contentTitle,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
                const SizedBox(height: 8.0),
                Text(
                  post.content,
                  style: const TextStyle(color: Colors.white),
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
                                  style: const TextStyle(
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
                                      const Padding(
                                        padding: EdgeInsets.all(8.0),
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
                                          style: const TextStyle(
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
                          decoration: const BoxDecoration(
                            color: kBackgroundColor,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20.0),
                              topRight: Radius.circular(20.0),
                            ),
                          ),
                          padding: const EdgeInsets.all(16.0),
                          constraints: BoxConstraints(
                            maxHeight:
                                MediaQuery.of(context).size.height * 0.35,
                          ),
                          child: Expanded(
                            child: ListView.builder(
                              itemCount: 1,
                              itemBuilder: (BuildContext context, int index) {
                                return const Column(
                                  // mainAxisSize: MainAxisSize.max,
                                  // crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      "Share to..me.",
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
                                        Icon(Icons.facebook,
                                            color: Colors.white),
                                        Icon(Icons.copy, color: Colors.white),
                                        Icon(Icons.email, color: Colors.white),
                                        Icon(Icons.more_horiz,
                                            color: Colors.white),
                                      ],
                                    ),
                                  ],
                                );
                              },
                            ),
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
                    child: const Padding(
                      padding: EdgeInsets.all(3.0),
                      child: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(3.0),
                            child: Icon(
                              Icons.share,
                              size: 12,
                              color: Colors.white,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(5.0),
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
