import 'dart:math';

import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:reddit_bel_ham/components/general_components/reddit_loading_indicator.dart';
import 'package:reddit_bel_ham/screens/TrendingTopCommunitiesScreen.dart';
import 'package:reddit_bel_ham/utilities/screen_size_handler.dart';

import '../components/communities_screen_components/communities_screen_header.dart';
import '../components/communities_screen_components/community_preview_tile.dart';
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
    if (mounted) {

    setState(() {
      for (var community in response) {
        topCommunities.add(community['name']);
        topCommunitiesMembers.add(community['memberCount']);
        if (community['avatarImageUrl'] == null) {
          topAvatarImages.add('assets/images/planet3.png');
        } else {
          topAvatarImages.add(community['avatarImageUrl']);
        }
        topCommunitiesDesciptions.add(community['description']);
      }
    });
    }
  }

  void getTrendingCommunities() async {
    ApiService apiService = ApiService(TokenDecoder.token);
    var response = await apiService.getTrendingCommunities();
    response = response['TrendingCommunities'];
    if (mounted)
    {

    setState(() {
      for (var community in response) {
        trendingCommunities.add(community['name']);
        trendingCommunitiesMembers.add(community['memberCount']);
        if (community['avatarImageUrl'] == null) {
          trendingAvatarImages.add('assets/images/planet3.png');
        } else {
          trendingAvatarImages.add(community['avatarImageUrl']);
        }
        trendingCommunityDesciptions.add(community['description']);
      }
    });
    setState(() {
      isLoading = false;
    });
    }
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
