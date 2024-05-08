import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:reddit_bel_ham/utilities/token_decoder.dart';
import '../constants.dart';
import 'package:reddit_bel_ham/utilities/screen_size_handler.dart';
import 'package:reddit_bel_ham/components/subreddit_components/subreddit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:reddit_bel_ham/services/api_service.dart';
import 'package:reddit_bel_ham/components/subreddit_components/subreddit.dart';
import 'package:reddit_bel_ham/components/subreddit_components/subreddit_share_bottom_sheet.dart';
import 'package:reddit_bel_ham/components/subreddit_components/subreddit_ellipsis_bottom_sheet.dart';
import 'package:reddit_bel_ham/components/subreddit_components/subreddit_navbar_icon.dart';
import 'package:reddit_bel_ham/screens/subreddit_search_screen.dart';
import 'package:reddit_bel_ham/components/subreddit_components/subreddit_rules_tile.dart';
import 'package:reddit_bel_ham/screens/add_post_screen.dart';

class SubredditSeeMoreScreen extends StatefulWidget {
  Subreddit subreddit;

  SubredditSeeMoreScreen({required this.subreddit});

  @override
  State<SubredditSeeMoreScreen> createState() => _SubredditSeeMoreScreenState();
}

class _SubredditSeeMoreScreenState extends State<SubredditSeeMoreScreen> {
  var rules = [];
  var moderators = [];
  bool isModerator = false;
  int index = 1;
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

  @override
  void initState() {
    super.initState();
    index = 1;
    print(widget.subreddit.id);
  }

  @override
  void didUpdateWidget(covariant SubredditSeeMoreScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    index = 1;
  }

  @override
  void didChangeDependencies() {
    getCommunityRules();
    getCommunityModerators();
    super.didChangeDependencies();
    index = 1;
  }

  Future<void> getCommunityData() async {
    Map<String, dynamic> data =
        (await apiService.getCommunityDetails(widget.subreddit.name)) ?? {};
    if (mounted) {
      setState(() {
        widget.subreddit.onlineCount =
            data['communityDetails']['currentlyViewingCount'].toString();
        widget.subreddit.isJoined = data['communityDetails']['isMember'];
        widget.subreddit.avatarImage = data['communityDetails']
                ['avatarImage'] ??
            widget.subreddit.avatarImage;
        widget.subreddit.bannerImage = data['communityDetails']
                ['bannerImage'] ??
            widget.subreddit.bannerImage;

        widget.subreddit.onlineNickname =
            data['communityDetails']['currentlyViewingNickname'];
        widget.subreddit.isJoined = data['communityDetails']['isMember'];

        widget.subreddit.isMuted = data['communityDetails']['isMuted'];
      });
    }
  }

  Future<void> getCommunityRules() async {
    Map<String, dynamic> data =
        (await apiService.getSubredditRules(widget.subreddit.id)) ?? {};
    setState(() {
      rules = data['rules']['ruleList'];
      print(rules);
    });
  }

  Future<void> getCommunityModerators() async {
    Map<String, dynamic> data =
        (await apiService.getCommunityModerators(widget.subreddit.name)) ?? {};
    setState(() {
      moderators = data['moderators'];
      for (var moderator in moderators) {
        if (moderator['userName'] == TokenDecoder.username) {
          isModerator = true;
        }
      }
    });
  }

  Future<void> joinCommunity(String subredditID) async {
    await apiService.joinCommunity(subredditID);
    getCommunityData();
  }

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
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'r/${widget.subreddit.name}',
                  style: TextStyle(
                      fontSize: ScreenSizeHandler.bigger * 0.022,
                      fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    CircleAvatar(
                      radius: ScreenSizeHandler.bigger * 0.004,
                      backgroundColor: kOnlineStatusColor,
                    ),
                    SizedBox(width: ScreenSizeHandler.screenWidth * 0.005),
                    Container(
                      width: ScreenSizeHandler.screenWidth * 0.22,
                      child: Text(
                        '${widget.subreddit.onlineCount} ${widget.subreddit.onlineNickname}',
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
            ),
            leading: Padding(
              padding: EdgeInsets.only(left: ScreenSizeHandler.bigger * 0.013),
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
                background:
                    widget.subreddit.bannerImage != 'assets/images/blue2.jpg'
                        ? Image.network(widget.subreddit.bannerImage,
                            fit: BoxFit.cover)
                        : Image.asset(
                            'assets/images/blue2.jpg',
                            fit: BoxFit.cover,
                          )),
            actions: [
              if (!isModerator && widget.subreddit.isJoined)
                SubredditNavbarIcon(
                  iconSize: 0.025,
                  icon: FaIcon(FontAwesomeIcons.magnifyingGlass),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SubredditSearchScreen(
                          subredditName: widget.subreddit.name,
                          subredditAvatarImage: widget.subreddit.avatarImage,
                        ),
                      ),
                    );
                  },
                ),
              if (!isModerator)
                SubredditNavbarIcon(
                  iconSize: 0.023,
                  icon: FaIcon(FontAwesomeIcons.share),
                  onPressed: () {
                    showModalBottomSheet(
                      isScrollControlled: true,
                      context: context,
                      builder: (BuildContext context) =>
                          buildSubredditModalBottomSheet(
                              context, widget.subreddit),
                    );
                  },
                ),
              if (!isModerator && widget.subreddit.isJoined)
                SubredditNavbarIcon(
                  iconSize: 0.025,
                  icon: FaIcon(FontAwesomeIcons.ellipsis),
                  onPressed: () {
                    showModalBottomSheet(
                      isScrollControlled: true,
                      context: context,
                      builder: (BuildContext context) =>
                          buildSubredditEllipsisModalBottomSheet(
                              context, widget.subreddit),
                    ).then((value) {
                      getCommunityData();
                    });
                  },
                )
              else if (isModerator)
                Padding(
                  padding:
                      EdgeInsets.only(right: ScreenSizeHandler.bigger * 0.025),
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
                )
              else
                Padding(
                  padding:
                      EdgeInsets.only(right: ScreenSizeHandler.bigger * 0.013),
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        joinCommunity(widget.subreddit.id);
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
                ),
            ],
          ),
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: ScreenSizeHandler.screenHeight * 0.008),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("About",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: ScreenSizeHandler.bigger * 0.022,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
                Container(
                  width: ScreenSizeHandler.screenWidth,
                  child: Divider(
                    color: Color.fromARGB(255, 72, 71, 71),
                    thickness: 1.0,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: ScreenSizeHandler.screenHeight * 0.005,
                      horizontal: ScreenSizeHandler.screenWidth * 0.05),
                  child: Text(
                    'Description',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: ScreenSizeHandler.bigger * 0.02,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                Center(
                  child: Container(
                    width: ScreenSizeHandler.screenWidth * 0.94,
                    child: Divider(
                      color: Color.fromARGB(255, 72, 71, 71),
                      thickness: 2.0,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: ScreenSizeHandler.screenHeight * 0.005,
                      horizontal: ScreenSizeHandler.screenWidth * 0.05),
                  child: Text(
                    widget.subreddit.description,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: ScreenSizeHandler.bigger * 0.018,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                Container(
                  width: ScreenSizeHandler.screenWidth,
                  child: Divider(
                    color: Colors.black,
                    thickness: 4,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: ScreenSizeHandler.screenHeight * 0.005,
                      horizontal: ScreenSizeHandler.screenWidth * 0.05),
                  child: Text(
                    'Rules',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: ScreenSizeHandler.bigger * 0.02,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                Center(
                  child: Container(
                    width: ScreenSizeHandler.screenWidth * 0.94,
                    child: Divider(
                      color: Color.fromARGB(255, 72, 71, 71),
                      thickness: 2.0,
                    ),
                  ),
                ),
                for (var i = 1; i <= rules.length; i++)
                  RulesTile(
                    index: i, // Start index at 1 and then increment
                    ruleTitle: rules[i - 1]['ruleText'],
                    ruleDescription: rules[i - 1]['fullDescription'],
                  ),
                Container(
                  width: ScreenSizeHandler.screenWidth,
                  child: Divider(
                    color: Colors.black,
                    thickness: 4,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: ScreenSizeHandler.screenHeight * 0.005,
                      horizontal: ScreenSizeHandler.screenWidth * 0.05),
                  child: Row(
                    children: [
                      Text(
                        'Moderators',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: ScreenSizeHandler.bigger * 0.02,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      Spacer(),
                      Icon(FontAwesomeIcons.envelope,
                          color: kDisabledButtonColor,
                          size: ScreenSizeHandler.bigger * 0.022),
                    ],
                  ),
                ),
                Center(
                  child: Container(
                    width: ScreenSizeHandler.screenWidth * 0.94,
                    child: Divider(
                      color: Color.fromARGB(255, 72, 71, 71),
                      thickness: 2.0,
                    ),
                  ),
                ),
                for (var mod in moderators)
                  Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: ScreenSizeHandler.screenHeight * 0.01,
                        horizontal: ScreenSizeHandler.screenWidth * 0.053),
                    child: Text(
                      'u/${mod['userName']}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: ScreenSizeHandler.bigger * 0.02,
                      ),
                    ),
                  ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
