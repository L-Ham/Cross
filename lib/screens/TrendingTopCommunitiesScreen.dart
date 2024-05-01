import 'dart:math';

import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:reddit_bel_ham/components/general_components/reddit_loading_indicator.dart';
import 'package:reddit_bel_ham/constants.dart';
import 'package:reddit_bel_ham/screens/communities_screen.dart';
import 'package:reddit_bel_ham/services/api_service.dart';
import 'package:reddit_bel_ham/utilities/screen_size_handler.dart';
import 'package:reddit_bel_ham/utilities/token_decoder.dart';

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
  bool isLoading = true;
  ApiService apiService = ApiService(TokenDecoder.token);

  List<String> communities = [];
  List<int> communitiesMembers = [];
  List<String> avatarImages = [];
  List<String> communityDesciptions = [];

  void getTopCommunities() async {
    ApiService apiService = ApiService(TokenDecoder.token);
    var response = await apiService.getPopularCommunites();
    response = response['popularCommunities'];
    setState(() {
      for (var community in response) {
        communities.add(community['name']);
        communitiesMembers.add(community['memberCount']);
        if (community['avatarImageUrl'] == null) {
          avatarImages.add('assets/images/planet3.png');
        } else {
          avatarImages.add(community['avatarImageUrl']);
        }
        communityDesciptions.add(
            "Welcome to ${community['name']}, the largest ${community['name']} community");
      }
    });
    setState(() {
      isLoading = false;
    });
  }

  void getTrendingCommunities() async {
    ApiService apiService = ApiService(TokenDecoder.token);
    var response = await apiService.getTrendingCommunities();
    response = response['TrendingCommunities'];
    setState(() {
      for (var community in response) {
        communities.add(community['name']);
        communitiesMembers.add(community['memberCount']);
        if (community['avatarImageUrl'] == null) {
          avatarImages.add('assets/images/planet3.png');
        } else {
          avatarImages.add(community['avatarImageUrl']);
        }
        communityDesciptions.add(
            "Welcome to ${community['name']}, the largest ${community['name']} community");
      }
    });
    setState(() {
      isLoading = false;
    });
  }

  @override
  void didChangeDependencies() {
    isTrending = ModalRoute.of(context)!.settings.arguments as bool;
    if (isTrending) {
      getTrendingCommunities();
    } else {
      getTopCommunities();
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.black,
        title: Text(
          isTrending ? '🔥 Tending globally' : '🌍  Top globally',
          style: TextStyle(
              fontSize:
                  ScreenSizeHandler.smaller * kAppBarTitleSmallerFontRatio,
              fontWeight: FontWeight.w500),
        ),
      ),
      body: ModalProgressHUD(
        inAsyncCall: isLoading,
        progressIndicator: const RedditLoadingIndicator(),
        color: Colors.black,
        opacity: 0.5,
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: ScreenSizeHandler.screenWidth * 0.046),
          child: ListView.builder(
            itemCount: min(25, communities.length),
            itemExtent: ScreenSizeHandler.screenHeight * 0.16,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.symmetric(
                    vertical: ScreenSizeHandler.screenHeight * 0.008),
                child: CommunityPreviewTile(
                  id: 'id$index',
                  subredditName: communities[index],
                  numOfMembers: communitiesMembers[index].toString(),
                  description: communityDesciptions[index],
                  image: avatarImages[index],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
