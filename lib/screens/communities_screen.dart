import 'dart:math';

import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:reddit_bel_ham/components/general_components/reddit_loading_indicator.dart';
import 'package:reddit_bel_ham/screens/TrendingTopCommunitiesScreen.dart';
import 'package:reddit_bel_ham/screens/subreddit_screen.dart';
import 'package:reddit_bel_ham/utilities/screen_size_handler.dart';

import '../services/api_service.dart';
import '../utilities/token_decoder.dart';

class CommunitiesScreen extends StatefulWidget {
  const CommunitiesScreen({super.key});

  static const id = 'communities_screen';

  @override
  State<CommunitiesScreen> createState() => _CommunitiesScreenState();
}

class _CommunitiesScreenState extends State<CommunitiesScreen> {
  List<String> trendingCommunities = [];
  List<int> trendingCommunitiesMembers = [];
  List<String> trendingAvatarImages = [];
  List<String> trendingCommunityDesciptions = [];

  List<String> topCommunities = [];
  List<int> topCommunitiesMembers = [];
  List<String> topAvatarImages = [];
  List<String> topCommunitiesDesciptions = [];

  bool isLoading = false;

  void getTopCommunities() async {
    setState(() {
      isLoading = true;
    });
    ApiService apiService = ApiService(TokenDecoder.token);
    var response = await apiService.getPopularCommunites();
    response = response['popularCommunities'];
    setState(() {
      for (var community in response) {
        topCommunities.add(community['name']);
        topCommunitiesMembers.add(community['memberCount']);
        if (community['avatarImageUrl'] == null) {
          topAvatarImages.add('assets/images/planet3.png');
        } else {
          topAvatarImages.add(community['avatarImageUrl']);
        }
        topCommunitiesDesciptions.add(
            "Welcome to ${community['name']}, the largest ${community['name']} community");
      }
    });
  }

  void getTrendingCommunities() async {
    ApiService apiService = ApiService(TokenDecoder.token);
    var response = await apiService.getTrendingCommunities();
    response = response['TrendingCommunities'];
    setState(() {
      for (var community in response) {
        trendingCommunities.add(community['name']);
        trendingCommunitiesMembers.add(community['memberCount']);
        if (community['avatarImageUrl'] == null) {
          trendingAvatarImages.add('assets/images/planet3.png');
        } else {
          trendingAvatarImages.add(community['avatarImageUrl']);
        }
        trendingCommunityDesciptions.add(
            "Welcome to ${community['name']}, the largest ${community['name']} community");
      }
    });
    setState(() {
      isLoading = false;
    });
  }

  @override
  void didChangeDependencies() {
    getTopCommunities();
    getTrendingCommunities();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: ModalProgressHUD(
        inAsyncCall: isLoading,
        progressIndicator: const RedditLoadingIndicator(),
        color: Colors.black,
        opacity: 0.5,
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: ScreenSizeHandler.screenWidth * 0.05),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommunitiesScreenHeader(
                  title: '🔥 Tending globally',
                  onTap: () {
                    Navigator.pushNamed(
                        context, TrendingTopCommunitiesScreen.id,
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
                        numOfMembers:
                            trendingCommunitiesMembers[index].toString(),
                        description: trendingCommunityDesciptions[index],
                        image: trendingAvatarImages[index],
                      );
                    },
                  ),
                ),
                CommunitiesScreenHeader(
                  title: '🌍  Top globally',
                  onTap: () {
                    Navigator.pushNamed(
                        context, TrendingTopCommunitiesScreen.id,
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
                    itemCount: topCommunities.length,
                    itemBuilder: (context, index) {
                      return CommunityPreviewTile(
                        id: 'id$index',
                        subredditName: topCommunities[index],
                        numOfMembers: topCommunitiesMembers[index].toString(),
                        description: topCommunitiesDesciptions[index],
                        image: topAvatarImages[index],
                      );
                    },
                  ),
                ),
              ],
            ),
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
      onTap: () {
        Navigator.pushNamed(context, SubredditScreen.id,
            arguments: subredditName);
      },
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
                padding: EdgeInsets.only(
                    top: ScreenSizeHandler.screenHeight * 0.006),
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
