import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:reddit_bel_ham/constants.dart';
import 'package:reddit_bel_ham/screens/edit_profile_screen.dart';
import 'package:reddit_bel_ham/utilities/screen_size_handler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:reddit_bel_ham/components/general_components/rounded_button.dart';
import 'package:reddit_bel_ham/services/api_service.dart';
import 'package:reddit_bel_ham/utilities/time_ago.dart';
import 'package:reddit_bel_ham/utilities/token_decoder.dart';
import '../components/general_components/reddit_loading_indicator.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
  static const String id = 'profile_screen';
}

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool isAppBarExpanded = false;
  bool isMyProfile = true;
  List<Map<String, dynamic>> socialLinks = [];
  List<Icon> socialIcons = [
    Icon(FontAwesomeIcons.facebook),
    Icon(FontAwesomeIcons.facebook),
    Icon(FontAwesomeIcons.facebook)
  ];
  ApiService apiService = ApiService(TokenDecoder.token);
  String avatarImage = '';
  String username = '';
  String postKarma = '';
  String displayName = '';
  String commentKarma = '';
  String bannerImage = '';
  String created = '';
  String about = '';
  bool isLoading = false;

  Future<void> getUserPersonalInfo() async {
    Map<String, dynamic> data = (await apiService.getUserSelfInfo()) ?? {};
    if (mounted)
      setState(() {
        avatarImage = data['user']['avatar'] ?? '';
        username = data['user']['username'] ?? '';
        postKarma = data['user']['postKarma'].toString() == 'null'
            ? '0 karma'
            : data['user']['post_karma'].toString() + ' karma';
        displayName = data['user']['displayName'] ?? data['user']['username'];
        commentKarma = data['user']['commentKarma'].toString() ?? '0';
        bannerImage = data['user']['banner'] ?? '';
        created = timeAgo(data['user']['created'].toString()) ?? '';
        about = data['user']['About'] ?? '';
        isLoading = false;
      });
      print(displayName);
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

  Future<void> getProfileInfo() async {
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
    // Map<String, dynamic> args =
    //     ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    // isMyProfile = args['isMyProfile'] as bool;
    // avatarImage = args['avatarImage'] as String;
    // username = args['username'] as String;
    // postKarma = args['postKarma'] as String;
    // displayName = args['displayName'] as String;
    // commentKarma = args['commentKarma'] as String;
    // bannerImage = args['bannerImage'] as String;
    // created = args['created'] as String;
// socialLinks = args['socialLinks'] != null ? args['socialLinks'] as List<Map<String,dynamic>> : [];
    if (isMyProfile) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          setState(() {
            getProfileInfo();
          });
        }
        isAppBarExpanded = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 3, vsync: this);
    if (isMyProfile) {
      if (mounted) {
        setState(() {
          getProfileInfo();
          isLoading = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      progressIndicator: const RedditLoadingIndicator(),
      blur: 0,
      opacity: 0,
      offset: Offset(ScreenSizeHandler.screenWidth * 0.38,
          ScreenSizeHandler.screenHeight * 0.6),
      child: Scaffold(
        body: CustomScrollView(
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
                  WidgetsBinding.instance!.addPostFrameCallback((_) {
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
                          icon: Icon(Icons.arrow_back, color: Colors.white),
                        ),
                      ),
                      Positioned(
                        left: ScreenSizeHandler.screenWidth * 0.75,
                        top: 15.0,
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.search, color: Colors.white),
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
                                left: isAppBarExpanded ? 20.0 : 40.0,
                                bottom: 40.0),
                            child: Row(
                              children: [
                                avatarImage.isEmpty
                                    ? Icon(
                                        Icons.account_circle,
                                        color: Colors.white,
                                        size: 70,
                                      )
                                    : ClipOval(
                                        child: Image.network(avatarImage,
                                            width: isAppBarExpanded ? 90 : 25,
                                            height: isAppBarExpanded ? 90 : 25),
                                      ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text(
                                    displayName,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: isAppBarExpanded ? 30.0 : 17.0,
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (isAppBarExpanded) ...[
                            Padding(
                              padding: EdgeInsets.only(
                                  top: socialLinks.length < 2 ? 220.0 : 320.0,
                                  left: 16),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      isMyProfile
                                          ? Navigator.pushNamed(
                                                  context, EditProfileScreen.id,
                                                  arguments: {
                                                  'isAddSocialLinkPressed':
                                                      false,
                                                  'avatarImage': avatarImage,
                                                  'bannerImage': bannerImage,
                                                })
                                              .then((value) => getProfileInfo())
                                          : null;
                                    },
                                    child: Text(
                                      isMyProfile ? 'Edit' : 'Follow',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.transparent,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(100.0),
                                        side: BorderSide(
                                            color: Colors.white, width: 1.0),
                                      ),
                                    ),
                                  ),
                                  if (!isMyProfile) ...[
                                    ElevatedButton(
                                      onPressed: () {},
                                      child: Icon(Icons.message_outlined,
                                          color: Colors.white, size: 20),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.transparent,
                                        shape: CircleBorder(
                                          side: BorderSide(
                                              color: Colors.white, width: 1.0),
                                        ),
                                      ),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {},
                                      child: Icon(Icons.person_add_alt_outlined,
                                          color: Colors.white, size: 25),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.transparent,
                                        shape: CircleBorder(
                                          side: BorderSide(
                                              color: Colors.white, width: 1.0),
                                        ),
                                      ),
                                    ),
                                  ]
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 16.0),
                              child: Text('$username • $postKarma • $created',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 13)),
                            ),
                            // isMyProfile?
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
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
                                      itemCount: socialLinks.length + 1,
                                      itemBuilder: (context, index) {
                                        var iconName =
                                            index < socialLinks.length
                                                ? socialLinks[index]['appName']
                                                : '';
                                        var icon = iconMapping[iconName];
                                        return index != socialLinks.length
                                            ? Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: RoundedButton(
                                                  onTap: () {},
                                                  buttonHeightRatio: 0.06,
                                                  buttonWidthRatio: 0.1,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      icon!,
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                left: 8.0),
                                                        child: Text(
                                                          socialLinks[index]
                                                              ["displayText"],
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
                                            : socialLinks.length < 5 &&
                                                    isMyProfile
                                                ? Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: ElevatedButton(
                                                      onPressed: () {
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
                                                            }).then((value) =>
                                                            getProfileInfo());
                                                      },
                                                      child: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          Icon(Icons.add,
                                                              color:
                                                                  Colors.white),
                                                          Text(
                                                              'Add social link',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize:
                                                                      13)),
                                                        ],
                                                      ),
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        backgroundColor:
                                                            kBackgroundColor,
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      100.0),
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
                              indicatorSize: TabBarIndicatorSize.tab,
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
                  Center(child: Text('Tab 1 Content')),
                  Center(child: Text('Tab 2 Content')),
                  Center(child: Text('Tab 3 Content')),
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
