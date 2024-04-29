import 'dart:math';

import 'package:flutter/material.dart';
import 'package:reddit_bel_ham/constants.dart';
import 'package:reddit_bel_ham/screens/communities_screen.dart';
import 'package:reddit_bel_ham/utilities/screen_size_handler.dart';

class TrendingTopCommunitiesScreen extends StatefulWidget {
  const TrendingTopCommunitiesScreen({super.key});

  static const id = "TrendingTopCommunitiesScreen";

  @override
  State<TrendingTopCommunitiesScreen> createState() =>
      _TrendingTopCommunitiesScreenState();
}

class _TrendingTopCommunitiesScreenState
    extends State<TrendingTopCommunitiesScreen> {
  bool isTrending = true;

  List<String> trendingCommunities = [
    'FlutterDev',
    'Dart',
    'Firebase',
    'Flutter',
    'FlutterDev',
    'Dart',
    'Firebase',
    'Flutter',
  ];

  List<String> trendingCommunitiesMembers = [
    "1.2M",
    "4.5M",
    "3.2M",
    "2.1M",
    "1.2M",
    "4.5M",
    "3.2M",
    "2.1M"
  ];

  List<String> trendingAvatarImages = [
    'assets/images/planet3.png',
    'assets/images/planet3.png',
    'assets/images/planet3.png',
    'assets/images/planet3.png',
    'assets/images/planet3.png',
    'assets/images/planet3.png',
    'assets/images/planet3.png',
    'assets/images/planet3.png',
  ];

  List<String> trendingCommunityDesciptions = [
    'Welcome to FlutterDev, the largest Flutter communityyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy',
    'Welcome to Dart, the largest Dart community',
    'Welcome to Firebase, the largest Firebase community',
    'Welcome to Flutter, the largest Flutter community',
    'Welcome to FlutterDev, the largest Flutter community',
    'Welcome to Dart, the largest Dart community',
    'Welcome to Firebase, the largest Firebase community',
    'Welcome to Flutter, the largest Flutter community',
  ];

  @override
  void didChangeDependencies() {
    isTrending = ModalRoute.of(context)!.settings.arguments as bool;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: kBackgroundColor,
        title: Text(
          isTrending ? '🔥 Tending globally' : '🌍  Top globally',
          style: TextStyle(
              fontSize: ScreenSizeHandler.smaller *
                  kAppBarTitleSmallerFontRatio,
              fontWeight: FontWeight.w500),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: ScreenSizeHandler.screenWidth * 0.046),
        child: ListView.builder(
          itemCount: min(25, trendingCommunities.length),
          itemExtent: ScreenSizeHandler.screenHeight * 0.16,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.symmetric(
                  vertical: ScreenSizeHandler.screenHeight * 0.008),
              child: CommunityPreviewTile(
                id: 'id$index',
                subredditName: trendingCommunities[index],
                numOfMembers: trendingCommunitiesMembers[index],
                description: trendingCommunityDesciptions[index],
                image: trendingAvatarImages[index],
              ),
            );
          },
        ),
      ),
    );
  }
}
