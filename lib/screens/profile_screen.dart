import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:reddit_bel_ham/components/comments_components/comment_card.dart';
import 'package:reddit_bel_ham/components/empty_dog.dart';
import 'package:reddit_bel_ham/constants.dart';
import 'package:reddit_bel_ham/screens/chatting_screen.dart';
import 'package:reddit_bel_ham/screens/edit_profile_screen.dart';
import 'package:reddit_bel_ham/screens/new_message_screen.dart';
import 'package:reddit_bel_ham/screens/searching_screen.dart';
import 'package:reddit_bel_ham/utilities/screen_size_handler.dart';
import 'package:reddit_bel_ham/components/general_components/rounded_button.dart';
import 'package:reddit_bel_ham/services/api_service.dart';
import 'package:reddit_bel_ham/utilities/token_decoder.dart';
import '../components/general_components/reddit_loading_indicator.dart';
import 'package:url_launcher/url_launcher.dart';
import '../utilities/go_to_profile.dart';
import 'package:reddit_bel_ham/components/home_page_components/post_card.dart';
import 'package:reddit_bel_ham/screens/add_post_screen.dart';
import 'communities_screen.dart';
import 'inbox_messages.dart';
import '../screens/comments_screen.dart';
import 'subreddit_search_screen.dart';
import 'subreddit_screen.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
  static const String id = 'profile_screen';
}

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool isAppBarExpanded = false;
  bool isMyProfile = false;
  List<Map<String, dynamic>> socialLinks = [];
  List<Icon> socialIcons = [
    Icon(FontAwesomeIcons.facebook),
    Icon(FontAwesomeIcons.facebook),
    Icon(FontAwesomeIcons.facebook)
  ];
  ApiService apiService = ApiService(TokenDecoder.token);
  final ScrollController _scrollController = ScrollController();
  final ScrollController _scrollController2 = ScrollController();
  String avatarImage = '';
  String username = '';
  String postKarma = '';
  String displayName = '';
  String commentKarma = '';
  String bannerImage = '';
  String created = '';
  String about = '';
  bool isFriend = false;
  bool isBlocked = false;
  bool isLoading = false;
  List<Post> feed = [];
  List<dynamic> comments = [];
  List<Post> newPosts = [];
  List<dynamic> newComments = [];
  String id = '0';
  int page = 1;
  int page2 = 1;
  bool isFeedCalled = false;
  bool isCommentsCalled = false;
  bool isFeedFinished = false;
  bool isCommentsFinished = false;
  bool isMarkingAllAsRead = false;
  bool isExisting=true;
  Future<void> _launchURL(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw 'Could not launch $url';
    }
  }

  Future<void> getUser(String username) async {
    Map<String, dynamic> data =
        (await apiService.getSearchedForBlockedUsers(username)) ?? {};
    if (mounted) {
      if (!isMyProfile) {
        setState(() {
          if (data['matchingUsernames'].isEmpty) {
            isExisting=false;
            return;
          }
          // print(data);

          id = data['matchingUsernames'][0]['_id'].toString();
          print('IDDDDD: $id');
        });
      }
    }
  }

  Future<void> getUserInfo(String username) async {
    await getUser(username);
    Map<String, dynamic> data = (await apiService.getUserInfo(id)) ?? {};
    if (mounted) {
      setState(() {
        if (data['user'] == null) {
          isExisting=false;
          return;
        }
        avatarImage = data['user']['avatar'] ?? '';
        username = data['user']['username'] ?? '';
        postKarma = data['user']['postKarma'].toString() == 'null'
            ? '0'
            : data['user']['postKarma'].toString();
        displayName = data['user']['displayName'] ?? data['user']['username'];
        commentKarma = data['user']['commentKarma'].toString() ?? '0';
        bannerImage = data['user']['banner'] ?? '';
        created = data['user']['created'] != null
            ? DateTime.fromMillisecondsSinceEpoch(
                    data['user']['created'] * 1000)
                .toString()
            : '';
        about = data['user']['About'] ?? '';
        isFriend = data['user']['isFriend'] ?? false;
        isBlocked = data['user']['isBlocked'] ?? false;
        // socialLinks = (data['user']['socialLinks'] as List<dynamic>)
        //     ?.map((item) => item as Map<String, dynamic>)
        //     ?.toList() ??
        // [];
        isLoading = false;
        print(data);
      });
    }
    print(displayName);
  }

  Future<void> followUser(String username) async {
    await apiService.followUser(username) ?? {};
    setState(() {
      isFriend = true;
    });
  }

  Future<void> unfollowUser(String username) async {
    await apiService.unfollowUser(username) ?? {};
    setState(() {
      isFriend = false;
    });
  }

  Future<void> getUserPersonalInfo() async {
    Map<String, dynamic> data = (await apiService.getUserSelfInfo()) ?? {};
    if (mounted) {
      setState(() {
        avatarImage = data['user']['avatar'] ?? '';
        username = data['user']['username'] ?? '';
        postKarma = data['user']['postKarma'].toString() == 'null'
            ? '0'
            : data['user']['postKarma'].toString();
        displayName = data['user']['displayName'] ?? data['user']['username'];
        commentKarma = data['user']['commentKarma'].toString() ?? '0';
        bannerImage = data['user']['banner'] ?? '';
        created = data['user']['created'] != null
            ? DateTime.fromMillisecondsSinceEpoch(
                    data['user']['created'] * 1000)
                .toString()
            : '';
        about = data['user']['About'] ?? '';
        isLoading = false;
      });
    }
    print(displayName);
  }

  Future<void> getProfileFeed(String username, int page, int limit) async {
    print('USERNAMEEE: $username');
    Map<String, dynamic> data = (await apiService.getProfileFeed(
            username, page.toString(), limit.toString())) ??
        {};
    print(data);
    if (data.containsKey('userPosts')) {
      List<dynamic> jsonPosts = data['userPosts'];
      setState(() {
        newPosts = jsonPosts.map((json) => Post.fromJson(json)).toList();
        print(avatarImage);
        for (var post in newPosts) {
          post.userAvatarImage = avatarImage;

          post.userName = username;
        }
        if (page == 1) {
          feed = newPosts;
        } else {
          feed.addAll(newPosts);
        }
        isFeedCalled = true;
      });
      print("llllllllllllllllllllllllllllllllllllllllllllllllllllllllll");
    } else {
      setState(() {
        isFeedFinished = true;
      });
    }
  }
  Future<void> getUserComments(String username, int page, int limit) async {
    print('USERNAMEEE: $username');
    Map<String, dynamic> data = (await apiService.getUserComments(
            username, page.toString(), limit.toString())) ??
        {};
    print(data);
    if (data.containsKey('hiddenPosts')) {
      List<dynamic> newComments = data['hiddenPosts'];
      print(newComments);
      setState(() {
        print(avatarImage);
        if (page == 1) {
          comments = newComments;
        } else {
          comments.addAll(newComments);
        }
        isCommentsCalled = true;
      });
      print("llllllllllllllllllllllllllllllllllllllllllllllllllllllllll");
    } else {
      setState(() {
        isCommentsFinished = true;
      });
    }
  }

  Future<void> getSocialLinks() async {
    Map<String, dynamic> data = (await apiService.getProfileSettings()) ?? {};
    if (mounted) {
      setState(() {
        socialLinks = (data['profileSettings']['socialLinks'] as List<dynamic>)
                ?.map((item) => item as Map<String, dynamic>)
                ?.toList() ??
            [];
      });
    }
  }

  final iconMapping = {
    'reddit': Icon(
      FontAwesomeIcons.reddit,
      color: Colors.deepOrange,
    ),
    'facebook': Icon(
      FontAwesomeIcons.facebook,
      color: Colors.blue,
    ),
    'twitter': Icon(FontAwesomeIcons.twitter, color: Colors.blue),
    'youtube': Icon(FontAwesomeIcons.youtube, color: Colors.red),
    'paypal': Icon(FontAwesomeIcons.paypal, color: Colors.blue),
    'discord': Icon(
      FontAwesomeIcons.discord,
      color: Colors.blue,
    ),
    'instagram': Icon(FontAwesomeIcons.instagram, color: Colors.purple),
    'tiktok': Icon(FontAwesomeIcons.tiktok, color: Colors.white),
    'soundcloud': Icon(FontAwesomeIcons.soundcloud, color: Colors.deepOrange),
    'twitch': Icon(
      FontAwesomeIcons.twitch,
      color: Colors.purple,
    ),
    'spotify': Icon(
      FontAwesomeIcons.spotify,
      color: Colors.green,
    ),
    'link': Icon(FontAwesomeIcons.link, color: Colors.black),
    // Add more mappings as needed...
  };

// Then, you can use this mapping to get the icon for a given name:

  Future<void> getSelfProfileInfo() async {
    if (mounted) {
      setState(() {
        getUserPersonalInfo();
        getSocialLinks();
      });
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Map<String, dynamic> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>? ??
            {};
    isMyProfile = args['isMyProfile'] == true ? true : false;
    // avatarImage = args['avatarImage'] as String;
    username = args['username'];

    print(TokenDecoder.token);
    print(username);
    page = 1;
    page2 = 1;
    getProfileFeed(username, page, 5);
    getUserComments(username, page2, 8);
    page++;
    page2++;
    //     Map<String, dynamic> args =
    //     ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>? ?? {};
    // isMyProfile = args['isMyProfile']==true?true:false;
    // // avatarImage = args['avatarImage'] as String;
    // if (!isMyProfile)
    // {
    // username = args['username'];
    // }
    // postKarma = args['postKarma'] as String;
    // displayName = args['displayName'] as String;
    // commentKarma = args['commentKarma'] as String;
    // bannerImage = args['bannerImage'] as String;
    // created = args['created'] as String;
// socialLinks = args['socialLinks'] != null ? args['socialLinks'] as List<Map<String,dynamic>> : [];
    // if (isMyProfile) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        setState(() {
          if (isMyProfile) {
            getSelfProfileInfo();
          } else {
            getUserInfo(username);
          }
          isLoading = true;
        });
      }
      isAppBarExpanded = true;
    });
    // }
  }

  void getNewPostsForFeed() {
    double diff = _scrollController.position.maxScrollExtent -
        _scrollController.position.pixels;

    if (diff < 150 && diff > 100) {
      if (isFeedCalled) {
        setState(() {
          isFeedCalled = false;
          if (!isFeedFinished) {
            getProfileFeed(username, page, 2);
            page++;
          }
          print(page);
        });
      }
    }
  }
    void getNewCommentsForFeed() {
    double diff = _scrollController2.position.maxScrollExtent -
        _scrollController2.position.pixels;

    if (diff < 150 && diff > 100) {
      if (isCommentsCalled) {
        setState(() {
          isCommentsCalled = false;
          if (!isCommentsFinished) {
            getUserComments(username, page2, 4);
            page2++;
          }
          print(page2);
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      //     Map<String, dynamic> args =
      //     ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>? ?? {};
      // isMyProfile = args['isMyProfile']==true?true:false;
      // // avatarImage = args['avatarImage'] as String;
      // username = args['username'];

      //   print(TokenDecoder.token);
      //   page = 1;
      //   getProfileFeed(username,page, 5);
      //   page++;
    });
    _tabController = TabController(length: 3, vsync: this);
    _scrollController.addListener(getNewPostsForFeed);
    _scrollController2.addListener(getNewCommentsForFeed);
    // if (isMyProfile) {
    if (mounted) {
      // setState(() {
      //   if(isMyProfile)
      //   {
      //   getSelfProfileInfo();

      //   }
      //   else
      //   {
      //   getUserInfo(username);
      //   }
      // });
    }
    // }
  }

  int navigationBarIndex = 0;
  int oldIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      oldIndex = navigationBarIndex;
      navigationBarIndex = index;
    });
    if (index == 2) {
      Navigator.pushNamed(context, AddPostScreen.id, arguments: {
        'subredditName': username,
        'subredditImage': avatarImage,
        'subredditId': null,
        "isProfile": true
      });
      setState(() {
        navigationBarIndex = oldIndex;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return !isExisting? EmptyDog(): 
    ModalProgressHUD(
      inAsyncCall: isLoading,
      progressIndicator: const RedditLoadingIndicator(),
      blur: 0,
      opacity: 0,
      offset: Offset(ScreenSizeHandler.screenWidth * 0.38,
          ScreenSizeHandler.screenHeight * 0.6),
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
        body: navigationBarIndex == 1
            ? const CommunitiesScreen()
            : navigationBarIndex == 3
                ? const ChattingScreen()
                : navigationBarIndex == 4
                    ? isMarkingAllAsRead
                        ? const Center(child: RedditLoadingIndicator())
                        : const InboxMessagesScreen()
                    : CustomScrollView(
                        slivers: <Widget>[
                          SliverPersistentHeader(
                            pinned: true,
                            delegate: _SliverAppBarDelegate(
                              minHeight: 120.0,
                              maxHeight: socialLinks.length < 2
                                  ? 420.0
                                  : socialLinks.length < 4
                                      ? 560.0
                                      : 600.0,
                              onExpandStatusChange: (expanded) {
                                WidgetsBinding.instance!
                                    .addPostFrameCallback((_) {
                                  if (isAppBarExpanded != expanded) {
                                    setState(() {
                                      isAppBarExpanded = expanded;
                                    });
                                  }
                                });
                              },
                              child: Container(
                                decoration: bannerImage.isEmpty
                                    ? BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [Colors.blue, Colors.black],
                                          begin: Alignment.topCenter,
                                          end: Alignment.center,
                                        ),
                                      )
                                    : BoxDecoration(
                                        image: DecorationImage(
                                          image: NetworkImage(bannerImage),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                child: Stack(
                                  alignment: Alignment.centerLeft,
                                  children: [
                                    Positioned(
                                      left: 0.0,
                                      top: 15.0,
                                      child: IconButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        icon: Icon(Icons.arrow_back,
                                            color: Colors.white),
                                      ),
                                    ),
                                    Positioned(
                                      left:
                                          ScreenSizeHandler.screenWidth * 0.75,
                                      top: 15.0,
                                      child: Row(
                                        children: [
                                          IconButton(
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      SubredditSearchScreen(
                                                    subredditName: username,
                                                    subredditAvatarImage:
                                                        avatarImage,
                                                    isSubreddit: false,
                                                  ),
                                                ),
                                              );
                                            },
                                            icon: Icon(Icons.search,
                                                color: Colors.white),
                                          ),
                                          IconButton(
                                            onPressed: () {},
                                            icon: Icon(FontAwesomeIcons.share,
                                                color: Colors.white, size: 20),
                                          ),
                                        ],
                                      ),
                                    ),
                                    AnimatedBuilder(
                                      animation: _tabController.animation!,
                                      builder: (context, child) {
                                        return Padding(
                                          padding: EdgeInsets.only(
                                              left: isAppBarExpanded
                                                  ? 20.0
                                                  : 40.0,
                                              bottom: 40.0),
                                          child: Row(
                                            children: [
                                              avatarImage.isEmpty
                                                  ? Icon(
                                                      Icons.account_circle,
                                                      color: Colors.white,
                                                      size: isAppBarExpanded
                                                          ? 70
                                                          : 20,
                                                    )
                                                  : ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              100.0),
                                                      child: Image.network(
                                                          avatarImage,
                                                          width:
                                                              isAppBarExpanded
                                                                  ? 70
                                                                  : 25,
                                                          height:
                                                              isAppBarExpanded
                                                                  ? 70
                                                                  : 25),
                                                    ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 8.0),
                                                child: Text(
                                                  displayName,
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: isAppBarExpanded
                                                        ? 30.0
                                                        : 17.0,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        if (isAppBarExpanded) ...[
                                          Padding(
                                            padding: EdgeInsets.only(
                                                top: socialLinks.length < 2
                                                    ? 220.0
                                                    : 320.0,
                                                left: 16),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                ElevatedButton(
                                                  onPressed: () {
                                                    isMyProfile
                                                        ? Navigator.pushNamed(
                                                            context,
                                                            EditProfileScreen
                                                                .id,
                                                            arguments: {
                                                                'isAddSocialLinkPressed':
                                                                    false,
                                                                'avatarImage':
                                                                    avatarImage,
                                                                'bannerImage':
                                                                    bannerImage,
                                                              }).then((value) =>
                                                            getSelfProfileInfo())
                                                        : isFriend
                                                            ? unfollowUser(
                                                                username)
                                                            : followUser(
                                                                username);
                                                  },
                                                  child: Text(
                                                    isMyProfile
                                                        ? 'Edit'
                                                        : isFriend
                                                            ? 'Following'
                                                            : 'Follow',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        Colors.transparent,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              100.0),
                                                      side: BorderSide(
                                                          color: Colors.white,
                                                          width: 1.0),
                                                    ),
                                                  ),
                                                ),
                                                if (!isMyProfile) ...[
                                                  ElevatedButton(
                                                    onPressed: () {
                                                      Navigator.pushNamed(
                                                          context,
                                                          NewMessageScreen.id,
                                                          arguments: {
                                                            'userName':
                                                                username,
                                                            'isReply': false
                                                          });
                                                    },
                                                    child: Icon(
                                                        Icons.message_outlined,
                                                        color: Colors.white,
                                                        size: 20),
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      backgroundColor:
                                                          Colors.transparent,
                                                      shape: CircleBorder(
                                                        side: BorderSide(
                                                            color: Colors.white,
                                                            width: 1.0),
                                                      ),
                                                    ),
                                                  ),
                                                  // ElevatedButton(
                                                  //   onPressed: () {},
                                                  //   child: Icon(Icons.person_add_alt_outlined,
                                                  //       color: Colors.white, size: 25),
                                                  //   style: ElevatedButton.styleFrom(
                                                  //     backgroundColor: Colors.transparent,
                                                  //     shape: CircleBorder(
                                                  //       side: BorderSide(
                                                  //           color: Colors.white, width: 1.0),
                                                  //     ),
                                                  //   ),
                                                  // ),
                                                ]
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 16.0),
                                            child: Text(
                                                'u/$username • $postKarma karma • $created',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 13)),
                                          ),
                                          // isMyProfile?
                                          Expanded(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Container(
                                                height: socialLinks.length < 2
                                                    ? 50
                                                    : socialLinks.length < 4
                                                        ? 60
                                                        : 130,
                                                child: GridView.builder(
                                                    gridDelegate:
                                                        SliverGridDelegateWithFixedCrossAxisCount(
                                                            crossAxisCount: 2,
                                                            mainAxisExtent: 50),
                                                    itemCount:
                                                        socialLinks.length + 1,
                                                    itemBuilder:
                                                        (context, index) {
                                                      var iconName = index <
                                                              socialLinks.length
                                                          ? socialLinks[index]
                                                              ['appName']
                                                          : '';
                                                      var icon =
                                                          iconMapping[iconName];
                                                      return index !=
                                                              socialLinks.length
                                                          ? Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child:
                                                                  RoundedButton(
                                                                onTap: () {
                                                                  setState(() {
                                                                    if (socialLinks[index]
                                                                            [
                                                                            'appName'] ==
                                                                        'reddit') {
                                                                      if (socialLinks[index]
                                                                              [
                                                                              'linkOrUsername']
                                                                          .toString()
                                                                          .startsWith(
                                                                              'u/')) {
                                                                        goToProfile(
                                                                            context,
                                                                            socialLinks[index]['linkOrUsername'].replaceFirst('u/',
                                                                                ''));
                                                                      } else {
                                                                        Navigator.pushNamed(
                                                                            context,
                                                                            SubredditScreen.id,
                                                                            arguments:
                                                                              socialLinks[index]['linkOrUsername'].replaceFirst('r/', '')
                                                                            );
                                                                      }
                                                                    } else {
                                                                      _launchURL(
                                                                          socialLinks[index]
                                                                              [
                                                                              'linkOrUsername']);
                                                                    }
                                                                  });
                                                                },
                                                                buttonHeightRatio:
                                                                    0.06,
                                                                buttonWidthRatio:
                                                                    0.1,
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceEvenly,
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .min,
                                                                  children: [
                                                                    icon!,
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                          .only(
                                                                          left:
                                                                              8.0),
                                                                      child:
                                                                          Text(
                                                                        socialLinks[index]
                                                                            [
                                                                            "displayText"],
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.white,
                                                                            fontSize: 13),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            )
                                                          : socialLinks.length <
                                                                      5 &&
                                                                  isMyProfile
                                                              ? Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .all(
                                                                          8.0),
                                                                  child:
                                                                      ElevatedButton(
                                                                    onPressed:
                                                                        () {
                                                                      Navigator.pushNamed(
                                                                          context,
                                                                          EditProfileScreen
                                                                              .id,
                                                                          arguments: {
                                                                            'isAddSocialLinkPressed':
                                                                                true,
                                                                            'avatarImage':
                                                                                avatarImage,
                                                                            'bannerImage':
                                                                                bannerImage,
                                                                          }).then(
                                                                          (value) =>
                                                                              getSelfProfileInfo());
                                                                    },
                                                                    child: Row(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .min,
                                                                      children: [
                                                                        Icon(
                                                                            Icons
                                                                                .add,
                                                                            color:
                                                                                Colors.white),
                                                                        Text(
                                                                            'Add social link',
                                                                            style:
                                                                                TextStyle(color: Colors.white, fontSize: 13)),
                                                                      ],
                                                                    ),
                                                                    style: ElevatedButton
                                                                        .styleFrom(
                                                                      backgroundColor:
                                                                          kBackgroundColor,
                                                                      shape:
                                                                          RoundedRectangleBorder(
                                                                        borderRadius:
                                                                            BorderRadius.circular(100.0),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                )
                                                              : null;
                                                    }),
                                              ),
                                            ),
                                          )
                                          // :SizedBox(height: 30,),
                                        ],
                                        Container(
                                          color: Colors.black,
                                          child: TabBar(
                                            controller: _tabController,
                                            indicatorColor: Colors.blue,
                                            labelColor: Colors.white,
                                            unselectedLabelColor:
                                                Colors.white.withOpacity(0.5),
                                            indicatorSize:
                                                TabBarIndicatorSize.tab,
                                            labelStyle: TextStyle(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.w600,
                                            ),
                                            tabs: <Widget>[
                                              Tab(
                                                text: 'Posts',
                                              ),
                                              Tab(text: 'Comments'),
                                              Tab(text: 'About'),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SliverFillRemaining(
                            child: TabBarView(
                              controller: _tabController,
                              children: <Widget>[
                                feed.isEmpty
                                    ? EmptyDog()
                                    : CustomScrollView(
                                        controller: _scrollController,
                                        slivers: [
                                          for (var post in feed)
                                            SliverToBoxAdapter(
                                              child: GestureDetector(
                                                onTap: () {
                                                  Navigator.pushNamed(context,
                                                      CommentsScreen.id,
                                                      arguments: {
                                                        "post": post
                                                      });

                                                },
                                                child: PostCard(
                                                  post: post,
                                                  isModertor: isMyProfile,
                                                  // isModertor: isModerator,
                                                  isCommunityFeed: true,
                                                ),
                                              ),
                                            )
                                        ],
                                      ),
                                comments.isEmpty
                                    ? EmptyDog()
                                    : CustomScrollView(
                                        controller: _scrollController2,
                                        slivers: [
                                          for (var comment in comments)
                                            SliverToBoxAdapter(
                                              child: GestureDetector(
                                                onTap: () {
                                                  Navigator.pushNamed(context,
                                                      CommentsScreen.id,
                                                      arguments: {
                                                        "postId": comment['postId']
                                                      });
                                                },
                                                child: Padding(
                                                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text(comment['postTitle'], style: TextStyle(color: Colors.white, fontSize: 16,),),
                                                      Row(
                                                        children: [
                                                          Text('r/${comment['subredditName']} • ${comment['score']}', style: TextStyle(color: Colors.grey, fontSize: 13,)),
                                                          Icon(Icons.arrow_upward, color: Colors.grey, size: 15,),
                                                      
                                                        ],
                                                      ),
                                                      Text(comment['content'], style: TextStyle(color: Colors.grey, fontSize: 15),),
                                                      Divider(
                                                        color: kFillingColor,
                                                      ),
                                                    ]
                                                  ),
                                                )
                                              ),
                                            )
                                        ],
                                      ),
                                
                                SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 32.0, right: 32, left: 16),
                                        child: Row(
                                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(postKarma,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  left: ScreenSizeHandler
                                                          .screenWidth *
                                                      0.59),
                                              child: Text(commentKarma,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            bottom: 10.0, right: 32, left: 16),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text('Post Karma',
                                                style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 13,
                                                )),
                                            Text('Comment Karma',
                                                style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 13,
                                                )),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width: double.infinity,
                                        padding: EdgeInsets.only(left: 16),
                                        child: Text(
                                          about,
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      if (!isMyProfile) ...[
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.pushNamed(
                                                context, NewMessageScreen.id,
                                                arguments: {
                                                  'userName': username,
                                                  'isReply': false
                                                });
                                          },
                                          child: Container(
                                            width: double.infinity,
                                            padding: EdgeInsets.only(
                                                top: 20, left: 16),
                                            child: Row(
                                              children: [
                                                Icon(
                                                  FontAwesomeIcons.envelope,
                                                  color: Colors.grey,
                                                  size: 20,
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 8.0),
                                                  child: Text(
                                                    'Send a message',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8.0),
                                        child: Container(
                                          width: double.infinity,
                                          color: Colors.black,
                                          padding: EdgeInsets.only(
                                              top: 10, left: 16, bottom: 10),
                                          child: Text(
                                            "TROPHIES",
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 13,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.onExpandStatusChange,
    required this.child,
  });

  final double minHeight;
  final double maxHeight;
  final ValueChanged<bool> onExpandStatusChange;
  final Widget child;

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => maxHeight;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final bool isAppBarExpanded = shrinkOffset < 200;
    onExpandStatusChange(isAppBarExpanded);
    return SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
