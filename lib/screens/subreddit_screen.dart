import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:reddit_bel_ham/components/general_components/reddit_loading_indicator.dart';
import 'package:reddit_bel_ham/screens/about_you_screen.dart';
import 'package:reddit_bel_ham/utilities/screen_size_handler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:reddit_bel_ham/components/home_page_components/post_card.dart';
import 'package:reddit_bel_ham/components/subreddit_components/subreddit_navbar_icon.dart';
import 'package:reddit_bel_ham/screens/subreddit_search_screen.dart';
import 'package:reddit_bel_ham/utilities/token_decoder.dart';
import '../constants.dart';
import 'package:reddit_bel_ham/services/api_service.dart';
import 'package:reddit_bel_ham/components/subreddit_components/subreddit.dart';
import 'package:reddit_bel_ham/components/subreddit_components/subreddit_share_bottom_sheet.dart';
import 'package:reddit_bel_ham/components/subreddit_components/subreddit_ellipsis_bottom_sheet.dart';
import 'package:reddit_bel_ham/screens/subreddit_seemore_screen.dart';
import 'package:reddit_bel_ham/screens/add_post_screen.dart';

class SubredditScreen extends StatefulWidget {
  const SubredditScreen({Key? key}) : super(key: key);

  static const String id = 'subreddit_screen';
  @override
  State<SubredditScreen> createState() => _SubredditScreenState();
}

class _SubredditScreenState extends State<SubredditScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _showTitleInAppBar = false;
  String subredditName = 'AskEngineers';
  String subredditDescription =
      'Engineers apply the knowledge of math & science to design and manufacture maintainable systems used to solve specific problems. AskEngineers is a forum for questions about the technologies, standards, and processes used to design & build these systems, as well as for questions about the engineering profession and its many disciplines.';
  String subredditMembersCount = '999';
  String subredditMembersNickname = 'members';
  String subredditOnlineCount = '106';
  String subredditOnlineNickname = 'online';
  String subredditBannerImage = 'assets/images/blue2.jpg';
  String subredditAvatarImage = 'assets/images/planet3.png';
  String subredditID = '';
  late Subreddit subreddit;
  bool _isJoined = true;
  bool isMuted = false;
  String subredditLink = '';
  var moderators = [];
  bool isModerator = false;
  ApiService apiService = ApiService(TokenDecoder.token);

  int navigationBarIndex = 0;
  int oldIndex = 0;
  String selectedMenuItem = "Home";
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

  bool isLoading = true;

  Future<void> getCommunityData() async {
    Map<String, dynamic> data =
        (await apiService.getCommunityDetails(subredditName)) ?? {};
    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
    if (mounted) {
      setState(() {
        subredditMembersCount =
            data['communityDetails']['membersCount'].toString();
        subredditOnlineCount =
            data['communityDetails']['currentlyViewingCount'].toString();
        _isJoined = data['communityDetails']['isMember'];
        subredditAvatarImage =
            data['communityDetails']['avatarImage'] ?? subredditAvatarImage;
        subredditBannerImage =
            data['communityDetails']['bannerImage'] ?? subredditBannerImage;
        subredditDescription = data['communityDetails']['description']
            .trim()
            .replaceAll(RegExp(r'\s+'), ' ');
        subredditMembersNickname = data['communityDetails']['membersNickname'];
        subredditOnlineNickname =
            data['communityDetails']['currentlyViewingNickname'];
        subredditID = data['communityDetails']['subredditId'];
        _isJoined = data['communityDetails']['isMember'];
        isMuted = data['communityDetails']['isMuted'];
        subredditLink = "http://https://reddit-bylham.me/r/${subredditName}";
        print(TokenDecoder.token);
      });

      subreddit = Subreddit(
          name: subredditName,
          description: subredditDescription,
          avatarImage: subredditAvatarImage,
          bannerImage: subredditBannerImage,
          followersCount: subredditMembersCount,
          onlineCount: subredditOnlineCount,
          link: subredditLink,
          isMuted: isMuted,
          isJoined: _isJoined,
          onlineNickname: subredditOnlineNickname,
          id: subredditID);
    }
  }

  Future<void> joinCommunity(String subredditID) async {
    await apiService.joinCommunity(subredditID);
    getCommunityData();
  }

  Future<void> leaveCommunity(String subredditID) async {
    await apiService.leaveCommunity(subredditID);
  }

  Future<void> getCommunityModerators() async {
    Map<String, dynamic> data =
        (await apiService.getCommunityModerators(subredditName)) ?? {};
    setState(() {
      moderators = data['moderators'];
      for (var moderator in moderators) {
        if (moderator['userName'] == TokenDecoder.username) {
          isModerator = true;
        }
      }
    });
  }

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

  @override
  void didChangeDependencies() {
    subredditName =
        ModalRoute.of(context)!.settings.arguments as String? ?? 'Dragon Oath';
    getCommunityData();
    getCommunityModerators();

    super.didChangeDependencies();
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
      image: [""],
      link: "",
      video: "",
    ),
    Post(
      username: "r/AnnieBakesCakes",
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
      username: "r/JohannaDoesYoga",
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
      username: "r/JohannaDoesYoga",
      contentTitle: "instagram",
      content: "Check this page for more details",
      upvotes: 90,
      comments: 35,
      type: "poll",
      image: [""],
      link: "",
      video: "",
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        backgroundColor: kBackgroundColor,
        body: ModalProgressHUD(
          inAsyncCall: isLoading,
          color: Colors.black,
          opacity: 0.5,
          progressIndicator: const RedditLoadingIndicator(),
          child: CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverAppBar(
                title: _showTitleInAppBar
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'r/$subredditName',
                            style: TextStyle(
                                fontSize: ScreenSizeHandler.bigger * 0.022,
                                fontWeight: FontWeight.bold),
                          ),
                          Row(
                            children: [
                              CircleAvatar(
                                radius: ScreenSizeHandler.bigger * 0.005,
                                backgroundColor: kOnlineStatusColor,
                              ),
                              SizedBox(
                                  width: ScreenSizeHandler.screenWidth * 0.007),
                              Container(
                                width: ScreenSizeHandler.screenWidth * 0.22,
                                child: Text(
                                  '$subredditOnlineCount $subredditOnlineNickname',
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: ScreenSizeHandler.bigger * 0.015,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      )
                    : null,
                leading: Padding(
                  padding:
                      EdgeInsets.only(left: ScreenSizeHandler.bigger * 0.013),
                  child: CircleAvatar(
                    backgroundColor: Color.fromARGB(155, 0, 0, 0),
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
                  background: _showTitleInAppBar
                      ? ImageFiltered(
                          imageFilter:
                              ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                          child:
                              subredditBannerImage != 'assets/images/blue2.jpg'
                                  ? Image.network(subredditBannerImage,
                                      fit: BoxFit.cover)
                                  : Image.asset(
                                      'assets/images/blue2.jpg',
                                      fit: BoxFit.cover,
                                    ),
                        )
                      : subredditBannerImage != 'assets/images/blue2.jpg'
                          ? Image.network(subredditBannerImage,
                              fit: BoxFit.cover)
                          : Image.asset(
                              'assets/images/blue2.jpg',
                              fit: BoxFit.cover,
                            ),
                ),
                actions: [
                  if (isModerator && _showTitleInAppBar)
                    SizedBox(
                      width: 0,
                      height: 0,
                    )
                  else
                    SubredditNavbarIcon(
                      iconSize: 0.025,
                      icon: FaIcon(FontAwesomeIcons.magnifyingGlass),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SubredditSearchScreen(
                              subredditName: subredditName,
                              subredditAvatarImage: subredditAvatarImage,
                            ),
                          ),
                        );
                      },
                    ),
                  if (isModerator && _showTitleInAppBar)
                    SizedBox(
                      width: 0,
                      height: 0,
                    )
                  else
                    SubredditNavbarIcon(
                      iconSize: 0.023,
                      icon: FaIcon(FontAwesomeIcons.share),
                      onPressed: () {
                        showModalBottomSheet(
                          isScrollControlled: true,
                          context: context,
                          builder: (BuildContext context) =>
                              buildSubredditModalBottomSheet(
                                  context, subreddit),
                        );
                      },
                    ),
                  if ((!isModerator && _isJoined) ||
                      (!isModerator && !_isJoined && !_showTitleInAppBar) ||
                      (isModerator && !_showTitleInAppBar))
                    SubredditNavbarIcon(
                      iconSize: 0.025,
                      icon: FaIcon(FontAwesomeIcons.ellipsis),
                      onPressed: () {
                        showModalBottomSheet(
                          isScrollControlled: true,
                          context: context,
                          builder: (BuildContext context) =>
                              buildSubredditEllipsisModalBottomSheet(
                                  context, subreddit),
                        ).then((value) {
                          if (value != null) {
                            if (value) {
                              getCommunityData();
                            }
                          }
                        });
                      },
                    )
                  else if (!isModerator && _showTitleInAppBar && !_isJoined)
                    Padding(
                      padding: EdgeInsets.only(
                          right: ScreenSizeHandler.bigger * 0.013),
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            joinCommunity(subredditID);
                          });
                        },
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all(EdgeInsets.zero),
                          minimumSize: MaterialStateProperty.all(Size.zero),
                          fixedSize: MaterialStateProperty.all(Size(
                            ScreenSizeHandler.screenWidth * 0.21,
                            ScreenSizeHandler.screenHeight * 0.05,
                          )),
                          backgroundColor:
                              MaterialStateProperty.resolveWith<Color?>(
                            (states) => Color.fromARGB(155, 0, 0, 0),
                          ),
                        ),
                        child: Text(
                          'Join',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: ScreenSizeHandler.bigger * 0.019,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    )
                  else if (isModerator && _showTitleInAppBar)
                    Padding(
                      padding: EdgeInsets.only(
                          right: ScreenSizeHandler.bigger * 0.025),
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all(EdgeInsets.zero),
                          minimumSize: MaterialStateProperty.all(Size.zero),
                          fixedSize: MaterialStateProperty.all(Size(
                            ScreenSizeHandler.screenWidth * 0.25,
                            ScreenSizeHandler.screenHeight * 0.043,
                          )),
                          backgroundColor:
                              MaterialStateProperty.resolveWith<Color?>(
                            (states) => Color.fromARGB(155, 0, 0, 0),
                          ),
                        ),
                        child: Text(
                          'Mod Tools',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: ScreenSizeHandler.bigger * 0.017,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
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
                                foregroundImage: subredditAvatarImage !=
                                        'assets/images/planet3.png'
                                    ? NetworkImage(subredditAvatarImage)
                                    : Image.asset('assets/images/planet3.png')
                                        .image,
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
                                'r/$subredditName',
                                style: TextStyle(
                                  fontSize: ScreenSizeHandler.bigger * 0.024,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              if (!_isJoined && !isModerator)
                                SizedBox(
                                  height:
                                      ScreenSizeHandler.screenHeight * 0.003,
                                )
                              else
                                SizedBox(
                                  height:
                                      ScreenSizeHandler.screenHeight * 0.002,
                                ),
                              if (!_isJoined && !isModerator)
                                LayoutBuilder(
                                  builder: (context, constraints) {
                                    if (constraints.maxWidth >
                                        ScreenSizeHandler.screenWidth * 0.6) {
                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '$subredditMembersCount $subredditMembersNickname',
                                            style: TextStyle(
                                              fontSize:
                                                  ScreenSizeHandler.bigger *
                                                      0.016,
                                              color: kDisabledButtonColor,
                                            ),
                                          ),
                                          SizedBox(
                                              width: ScreenSizeHandler
                                                      .screenWidth *
                                                  0.03),
                                          Row(
                                            children: [
                                              CircleAvatar(
                                                radius:
                                                    ScreenSizeHandler.bigger *
                                                        0.0043,
                                                backgroundColor:
                                                    kOnlineStatusColor,
                                              ),
                                              SizedBox(
                                                  width: ScreenSizeHandler
                                                          .screenWidth *
                                                      0.007),
                                              Text(
                                                  '$subredditOnlineCount $subredditOnlineNickname',
                                                  style: TextStyle(
                                                    fontSize: ScreenSizeHandler
                                                            .bigger *
                                                        0.016,
                                                    color: kDisabledButtonColor,
                                                  ))
                                            ],
                                          ),
                                        ],
                                      );
                                    } else {
                                      return Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            '$subredditMembersCount $subredditMembersNickname',
                                            style: TextStyle(
                                              fontSize:
                                                  ScreenSizeHandler.bigger *
                                                      0.016,
                                              color: kDisabledButtonColor,
                                            ),
                                          ),
                                          SizedBox(
                                              width: ScreenSizeHandler
                                                      .screenWidth *
                                                  0.03),
                                          Row(
                                            children: [
                                              CircleAvatar(
                                                radius:
                                                    ScreenSizeHandler.bigger *
                                                        0.005,
                                                backgroundColor:
                                                    kOnlineStatusColor,
                                              ),
                                              SizedBox(
                                                  width: ScreenSizeHandler
                                                          .screenWidth *
                                                      0.01),
                                              Text(
                                                '$subredditOnlineCount $subredditOnlineNickname',
                                                style: TextStyle(
                                                  fontSize:
                                                      ScreenSizeHandler.bigger *
                                                          0.016,
                                                  color: kDisabledButtonColor,
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      );
                                    }
                                  },
                                )
                              else
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '$subredditMembersCount $subredditMembersNickname',
                                      style: TextStyle(
                                        fontSize:
                                            ScreenSizeHandler.bigger * 0.016,
                                        color: kDisabledButtonColor,
                                      ),
                                    ),
                                    SizedBox(
                                        width: ScreenSizeHandler.screenWidth *
                                            0.03),
                                    Row(
                                      children: [
                                        CircleAvatar(
                                          radius:
                                              ScreenSizeHandler.bigger * 0.0043,
                                          backgroundColor: kOnlineStatusColor,
                                        ),
                                        SizedBox(
                                            width:
                                                ScreenSizeHandler.screenWidth *
                                                    0.007),
                                        Text(
                                          '$subredditOnlineCount $subredditOnlineNickname',
                                          style: TextStyle(
                                            fontSize: ScreenSizeHandler.bigger *
                                                0.016,
                                            color: kDisabledButtonColor,
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                )
                            ],
                          ),
                          if (_isJoined) Spacer() else Spacer(),
                          if (isModerator)
                            ElevatedButton(
                              onPressed: () {},
                              style: ButtonStyle(
                                padding:
                                    MaterialStateProperty.all(EdgeInsets.zero),
                                minimumSize:
                                    MaterialStateProperty.all(Size.zero),
                                fixedSize: MaterialStateProperty.all(Size(
                                  ScreenSizeHandler.screenWidth * 0.28,
                                  ScreenSizeHandler.screenHeight * 0.05,
                                )),
                                backgroundColor:
                                    MaterialStateProperty.resolveWith<Color?>(
                                  (states) => Color.fromARGB(255, 20, 89, 200),
                                ),
                              ),
                              child: Text(
                                'Mod Tools',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: ScreenSizeHandler.bigger * 0.019,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            )
                          else if (_isJoined)
                            SizedBox(
                              height: ScreenSizeHandler.screenHeight * 0.04,
                              child: Semantics(
                                identifier: "subreddit_screen_joined_button",
                                child: OutlinedButton(
                                  onPressed: () {
                                    setState(() {
                                      showModalBottomSheet(
                                          isScrollControlled: true,
                                          backgroundColor:
                                              Color.fromARGB(255, 10, 10, 10),
                                          context: context,
                                          builder: (BuildContext bc) {
                                            return ClipRRect(
                                              borderRadius:
                                                  const BorderRadius.vertical(
                                                top: Radius.circular(20.0),
                                              ),
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal:
                                                        ScreenSizeHandler
                                                                .screenWidth *
                                                            0.05,
                                                    vertical: ScreenSizeHandler
                                                            .screenHeight *
                                                        0.03),
                                                child: GestureDetector(
                                                  onTap: () async {
                                                    await leaveCommunity(
                                                        subredditID);
                                                    setState(() {
                                                      getCommunityData();
                                                    });
                                                    Navigator.pop(context);
                                                  },
                                                  child: Row(
                                                    children: [
                                                      FaIcon(
                                                        FontAwesomeIcons
                                                            .circleMinus,
                                                        color: Colors.white,
                                                      ),
                                                      SizedBox(
                                                        width: ScreenSizeHandler
                                                                .screenWidth *
                                                            0.03,
                                                      ),
                                                      Text(
                                                        'Leave',
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize:
                                                              ScreenSizeHandler
                                                                      .bigger *
                                                                  0.018,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                          });
                                    });
                                  },
                                  style: ButtonStyle(
                                    side: MaterialStateBorderSide.resolveWith(
                                        (states) {
                                      return BorderSide(
                                          color: kSubredditJoinedColor,
                                          width: ScreenSizeHandler.screenWidth *
                                              0.0034);
                                    }),
                                    padding: MaterialStateProperty.all(
                                        EdgeInsets.zero),
                                    minimumSize:
                                        MaterialStateProperty.all(Size.zero),
                                    fixedSize: MaterialStateProperty.all(Size(
                                      ScreenSizeHandler.screenWidth * 0.18,
                                      ScreenSizeHandler.screenHeight * 0.04,
                                    )),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(
                                        ScreenSizeHandler.bigger * 0.0000001),
                                    child: Text(
                                      'Joined',
                                      style: TextStyle(
                                          color: kSubredditJoinedColor,
                                          fontWeight: FontWeight.w600,
                                          fontSize:
                                              ScreenSizeHandler.bigger * 0.017),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          else
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  joinCommunity(subredditID);
                                });
                              },
                              style: ButtonStyle(
                                padding:
                                    MaterialStateProperty.all(EdgeInsets.zero),
                                minimumSize:
                                    MaterialStateProperty.all(Size.zero),
                                fixedSize: MaterialStateProperty.all(Size(
                                  ScreenSizeHandler.screenWidth * 0.14,
                                  ScreenSizeHandler.screenHeight * 0.04,
                                )),
                                backgroundColor:
                                    MaterialStateProperty.resolveWith<Color?>(
                                  (states) => Color.fromARGB(255, 20, 89, 200),
                                ),
                              ),
                              child: Text(
                                'Join',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: ScreenSizeHandler.bigger * 0.0165,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                        ],
                      ),
                      SizedBox(
                        height: ScreenSizeHandler.bigger * 0.015,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              subredditDescription,
                              textAlign: TextAlign.left,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: ScreenSizeHandler.bigger * 0.016,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: ScreenSizeHandler.bigger * 0.01,
                          ),
                        ],
                      ),
                      if (isModerator)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            GestureDetector(
                              child: Text(
                                'See community info',
                                style: TextStyle(
                                  color: kSubredditJoinedColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        SubredditSeeMoreScreen(
                                      subreddit: subreddit,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        )
                      else
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            GestureDetector(
                              child: Text(
                                'See more',
                                style: TextStyle(
                                  color: kSubredditJoinedColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        SubredditSeeMoreScreen(
                                      subreddit: subreddit,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
              ),
              for (var post in posts)
                SliverToBoxAdapter(
                  child: PostCard(
                    post: post,
                    isModertor: isModerator,
                  ),
                ),
            ],
          ),
        ));
  }
}
