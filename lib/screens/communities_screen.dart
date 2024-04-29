import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:reddit_bel_ham/constants.dart';
import 'package:reddit_bel_ham/screens/TrendingTopCommunitiesScreen.dart';
import 'package:reddit_bel_ham/utilities/screen_size_handler.dart';

class CommunitiesScreen extends StatefulWidget {
  const CommunitiesScreen({super.key});

  static const id = 'communities_screen';

  @override
  State<CommunitiesScreen> createState() => _CommunitiesScreenState();
}

class _CommunitiesScreenState extends State<CommunitiesScreen> {
  List<String> trendingCommunities = [
    'FlutterDev',
    'Dart',
    'Firebase',
    'Flutter',
    'FlutterDev',
    'Dart',
    'Firebase',
    'Flutter',
    'batates'
  ];

  List<String> trendingCommunitiesMembers = [
    "1.2M",
    "4.5M",
    "3.2M",
    "2.1M",
    "1.2M",
    "4.5M",
    "3.2M",
    "2.1M",
    '1k'
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
    'hehe'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: ScreenSizeHandler.screenWidth * 0.05),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommunitiesScreenHeader(
                title: '🔥 Tending globally',
                onTap: () {
                  Navigator.pushNamed(context, TrendingTopCommunitiesScreen.id,
                      arguments: true);
                },
              ),
              SizedBox(
                height: ScreenSizeHandler.screenHeight * 0.3,
                child: GridView.builder(
                  scrollDirection: Axis.horizontal,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisExtent: ScreenSizeHandler.bigger * 0.38,
                    crossAxisCount: 2,
                    crossAxisSpacing: ScreenSizeHandler.screenWidth * 0.028,
                    mainAxisSpacing: ScreenSizeHandler.screenWidth * 0.028,
                  ),
                  itemCount: min(trendingCommunities.length, 24),
                  itemBuilder: (context, index) {
                    return CommunityPreviewTile(
                      id: 'id$index',
                      subredditName: trendingCommunities[index],
                      numOfMembers: trendingCommunitiesMembers[index],
                      description: trendingCommunityDesciptions[index],
                      image: trendingAvatarImages[index],
                    );
                  },
                ),
              ),
              CommunitiesScreenHeader(
                title: '🌍  Top globally',
                onTap: () {
                  Navigator.pushNamed(context, TrendingTopCommunitiesScreen.id,
                      arguments: false);
                },
              ),
              SizedBox(
                height: ScreenSizeHandler.screenHeight * 0.3,
                child: GridView.builder(
                  scrollDirection: Axis.horizontal,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisExtent: ScreenSizeHandler.bigger * 0.38,
                    crossAxisCount: 2,
                    crossAxisSpacing: ScreenSizeHandler.screenWidth * 0.028,
                    mainAxisSpacing: ScreenSizeHandler.screenWidth * 0.028,
                  ),
                  itemCount: trendingCommunities.length,
                  itemBuilder: (context, index) {
                    return CommunityPreviewTile(
                      id: 'id$index',
                      subredditName: trendingCommunities[index],
                      numOfMembers: trendingCommunitiesMembers[index],
                      description: trendingCommunityDesciptions[index],
                      image: trendingAvatarImages[index],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CommunityPreviewTile extends StatelessWidget {
  const CommunityPreviewTile({
    required this.id,
    required this.subredditName,
    required this.numOfMembers,
    required this.description,
    required this.image,
    super.key,
  });

  final String id;
  final String subredditName;
  final String numOfMembers;
  final String description;
  final String image;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.only(
            top: ScreenSizeHandler.screenHeight * 0.01,
            left: ScreenSizeHandler.screenWidth * 0.025,
            right: ScreenSizeHandler.screenWidth * 0.025),
        decoration: BoxDecoration(
          color: Colors.black,
          border: Border.all(
            color: Colors.grey[700]!,
            width: 0.5,
          ),
          borderRadius: BorderRadius.circular(12.0),
        ),
        height: ScreenSizeHandler.bigger * 0.115,
        width: ScreenSizeHandler.bigger * 0.38,
        child: Column(
          children: [
            Row(
              children: [
                Avatar(
                  avatar: image,
                  radius: ScreenSizeHandler.bigger * 0.0245,
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: ScreenSizeHandler.screenWidth * 0.02),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        subredditName,
                        style: TextStyle(
                            fontSize: ScreenSizeHandler.bigger * 0.018,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                      ),
                      Text(
                        '$numOfMembers members',
                        style: TextStyle(
                            fontSize: ScreenSizeHandler.bigger * 0.015,
                            color: Colors.grey[600],
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                )
              ],
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding:
                    EdgeInsets.only(top: ScreenSizeHandler.screenHeight * 0.006),
                child: Text(
                  description,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 4,
                  style: TextStyle(
                      height: 1.1,
                      fontSize: ScreenSizeHandler.bigger * 0.015,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w400),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CommunitiesScreenHeader extends StatelessWidget {
  const CommunitiesScreenHeader({
    required this.title,
    required this.onTap,
    super.key,
  });

  final String title;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(
            vertical: ScreenSizeHandler.screenHeight * 0.015),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: ScreenSizeHandler.bigger * 0.02),
            ),
            Icon(
              Icons.keyboard_arrow_right,
              color: Colors.grey,
              size: ScreenSizeHandler.bigger * 0.03,
            )
          ],
        ),
      ),
    );
  }
}

class Avatar extends StatelessWidget {
  const Avatar(
      {required this.avatar,
      this.radius = 35,
      this.defaultImg = 'assets/images/planet3.png',
      super.key});

  final String avatar;
  final double radius;
  final String defaultImg;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: Colors.white,
      child: avatar != defaultImg
          ? ClipRRect(
              borderRadius: BorderRadius.circular(35),
              child: Image.network(
                avatar,
                fit: BoxFit.cover,
              ),
            )
          : ClipRRect(
              borderRadius: BorderRadius.circular(35),
              child: Image.asset(
                defaultImg,
                fit: BoxFit.cover,
              ),
            ),
    );
  }
}
