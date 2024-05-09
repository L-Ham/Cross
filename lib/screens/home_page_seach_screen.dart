import 'dart:math';

import 'package:flutter/material.dart';
import 'package:reddit_bel_ham/components/general_components/avatar.dart';
import 'package:reddit_bel_ham/components/general_components/interactive_text.dart';
import 'package:reddit_bel_ham/constants.dart';
import 'package:reddit_bel_ham/screens/searching_screen.dart';
import 'package:reddit_bel_ham/screens/subreddit_screen.dart';
import 'package:reddit_bel_ham/services/api_service.dart';
import 'package:reddit_bel_ham/utilities/screen_size_handler.dart';
import 'package:reddit_bel_ham/utilities/searches_store.dart';
import 'package:reddit_bel_ham/utilities/token_decoder.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<String> trendingPostTitles = [];
  List<String> trendingPostDescriptions = [];
  List<String> trendingPostImages = [];

  final TextEditingController _searchController = TextEditingController();
  bool isSearching = false;
  bool isLoading = false;
  ApiService apiService = ApiService(TokenDecoder.token);

  List<String> subredditNames = [];
  List<int> subredditMembers = [];
  List<String> subredditAvatarImages = [];

  List<String> userNames = [];
  List<String> userAvatarImages = [];

  List<String> searchHistory = [];

  void getSearchesFromBack() async {
    Map<String, dynamic> results =
        await apiService.searchSubredditByName(_searchController.text);
    List<dynamic> resultsList = results['matchingNames'];
    searchSubreddit(resultsList);
    Map<String, dynamic> response =
        await apiService.getSearchedForBlockedUsers(_searchController.text);
    searchPeople(response['matchingUsernames'] ?? [] as List<dynamic>);
  }

  void searchPeople(List<dynamic> resultsList) {
    if (mounted) {
      setState(() {
        userNames.clear();
        userAvatarImages.clear();
      });
    }
    for (int i = 0; i < resultsList.length; i++) {
      mounted
          ? setState(() {
              if (resultsList[i]["avatarImageUrl"] != null) {
                userAvatarImages.add(resultsList[i]["avatarImageUrl"]);
              } else {
                userAvatarImages.add('assets/images/redditAvata2.png');
              }
              userNames.add(resultsList[i]["userName"]);
            })
          : null;
    }
    mounted
        ? setState(() {
            isLoading = false;
          })
        : null;
  }

  void searchSubreddit(List<dynamic> resultsList) {
    if (mounted) {
      setState(() {
        subredditNames.clear();
        subredditMembers.clear();
        subredditAvatarImages.clear();
      });
    }
    for (int i = 0; i < resultsList.length; i++) {
      mounted
          ? setState(() {
              if (resultsList[i]["appearance"]["avatarImage"] != null) {
                subredditAvatarImages
                    .add(resultsList[i]["appearance"]["avatarImage"]["url"]);
              } else {
                subredditAvatarImages.add('assets/images/planet3.png');
              }
              subredditNames.add(resultsList[i]["name"]);
              subredditMembers.add(resultsList[i]["membersCount"]);
            })
          : null;
    }
    mounted
        ? setState(() {
            isLoading = false;
          })
        : null;
  }

  void getRecentSearches() async {
    List<String> searches = await SearchStore().getSearches();
    setState(() {
      searchHistory = searches;
    });
  }

  void getTrendingPosts() async {
    var response = await apiService.getTrendingPosts();
    if (response != null) {
      response = response["trendingPosts"] ?? [];
    }
    if (mounted) {
      setState(() {
        trendingPostTitles.clear();
        trendingPostDescriptions.clear();
        trendingPostImages.clear();
      });
    }
    if (response != null) {
      for (var trendingPost in response) {
        setState(() {
          trendingPostTitles.add(trendingPost["title"]);
          trendingPostDescriptions.add(trendingPost["text"] ?? "");
          trendingPostImages.add(trendingPost["image"]);
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() {
        isSearching = _searchController.text.isNotEmpty;
        if (isSearching) {
          getSearchesFromBack();
        }
      });
    });
    getRecentSearches();
  }

  @override
  void didChangeDependencies() {
    getTrendingPosts();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: SizedBox(
          height: ScreenSizeHandler.bigger * 0.04,
          child: SearchScreenTextField(searchController: _searchController),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Padding(
              padding:
                  EdgeInsets.only(right: ScreenSizeHandler.screenWidth * 0.05),
              child: const Center(
                child: Text('Cancel',
                    style: TextStyle(
                        color: Colors.grey,
                        decoration: TextDecoration.underline,
                        decorationColor: Colors.grey,
                        fontWeight: FontWeight.w500)),
              ),
            ),
          ),
        ],
        backgroundColor: kBackgroundColor,
      ),
      body: SingleChildScrollView(
        child: isSearching
            ? Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: ScreenSizeHandler.screenWidth * 0.05),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (subredditNames.isNotEmpty)
                      Padding(
                        padding: EdgeInsets.only(
                            bottom: ScreenSizeHandler.screenHeight * 0.01),
                        child: Text(
                          "Communities",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: ScreenSizeHandler.bigger * 0.02),
                        ),
                      ),
                    for (int i = 0; i < min(6, subredditNames.length); i++)
                      SearchSubredditPeoplePreview(
                        isSubreddit: true,
                        title: subredditNames[i],
                        description: subredditMembers[i].toString(),
                        avatarImage: subredditAvatarImages[i],
                      ),
                    if (userNames.isNotEmpty)
                      Text(
                        "People",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: ScreenSizeHandler.bigger * 0.02),
                      ),
                    if (userNames.isNotEmpty)
                      for (int i = 0;
                          i <
                              min(6 - subredditMembers.length,
                                  userNames.length);
                          i++)
                        SearchSubredditPeoplePreview(
                          isSubreddit: false,
                          title: userNames[i],
                          description: '0 karma',
                          avatarImage: userAvatarImages[i],
                        ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: ScreenSizeHandler.screenHeight * 0.013),
                      child: InteractiveText(
                        text: 'Search for "${_searchController.text}" ',
                        onTap: () {
                          SearchStore().addSearch(_searchController.text);
                          setState(() {
                            getRecentSearches();
                          });
                          Navigator.pushNamed(context, SearchingScreen.id,
                              arguments: _searchController.text);
                        },
                      ),
                    )
                  ],
                ),
              )
            : Column(
                children: [
                  Visibility(
                    visible: searchHistory.isNotEmpty,
                    child: SizedBox(
                      height: ScreenSizeHandler.bigger *
                          0.19 *
                          searchHistory.length /
                          3,
                      child: ListView.builder(
                        itemCount: searchHistory.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            onTap: () {
                              Navigator.pushNamed(context, SearchingScreen.id,
                                  arguments: searchHistory[index]);
                            },
                            visualDensity: VisualDensity.compact,
                            leading: GestureDetector(
                              child: Icon(
                                Icons.access_time,
                                size: ScreenSizeHandler.bigger * 0.03,
                              ),
                              onTap: () {
                                _searchController.text = searchHistory[index];
                              },
                            ),
                            title: Text(
                              searchHistory[index],
                              style: TextStyle(
                                  fontSize: ScreenSizeHandler.bigger * 0.018),
                            ),
                            trailing: GestureDetector(
                              child: Icon(
                                Icons.cancel_outlined,
                                size: ScreenSizeHandler.bigger * 0.027,
                              ),
                              onTap: () {
                                setState(() {
                                  searchHistory.removeAt(index);
                                  SearchStore().deleteSearch(index);
                                });
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  const Divider(
                    thickness: 10,
                    color: Colors.black,
                  ),
                  if (trendingPostTitles.isNotEmpty)
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: ScreenSizeHandler.screenWidth * 0.06),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                bottom: ScreenSizeHandler.screenHeight * 0.01),
                            child: const Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Trending Today",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                          for (int i = 0;
                              i < min(6, trendingPostImages.length);
                              i++)
                            TrendingPreviewTile(
                                image: trendingPostImages[i],
                                title: trendingPostTitles[i],
                                description: trendingPostDescriptions[i])
                        ],
                      ),
                    )
                ],
              ),
      ),
      backgroundColor: kBackgroundColor,
    );
  }
}

class SearchScreenTextField extends StatelessWidget {
  const SearchScreenTextField(
      {super.key,
      required TextEditingController searchController,
      this.focusNode})
      : _searchController = searchController;

  final TextEditingController _searchController;
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    return TextField(
      focusNode: focusNode,
      controller: _searchController,
      style: TextStyle(
          color: Colors.white, fontSize: ScreenSizeHandler.bigger * 0.019),
      autofocus: true,
      decoration: InputDecoration(
        contentPadding:
            EdgeInsets.only(bottom: ScreenSizeHandler.screenHeight * 0.017),
        prefixIcon: Icon(
          Icons.search,
          size: ScreenSizeHandler.bigger * 0.029,
        ),
        suffixIcon: _searchController.text.isNotEmpty
            ? IconButton(
                icon: Icon(
                  Icons.cancel_outlined,
                  size: ScreenSizeHandler.bigger * 0.02,
                ),
                onPressed: () => _searchController.clear(),
              )
            : null,
        fillColor: kFillingColor,
        filled: true,
        hintText: 'Search',
        border: InputBorder.none,
        hintStyle: TextStyle(
            color: kHintTextColor, fontSize: ScreenSizeHandler.bigger * 0.019),
      ),
    );
  }
}

class SearchSubredditPeoplePreview extends StatelessWidget {
  const SearchSubredditPeoplePreview({
    required this.isSubreddit,
    required this.title,
    required this.description,
    required this.avatarImage,
    super.key,
  });

  final bool isSubreddit;
  final String title;
  final String description;
  final String avatarImage;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (isSubreddit) {
          Navigator.pushNamed(context, SubredditScreen.id, arguments: title);
        }
      },
      child: Padding(
        padding: EdgeInsets.symmetric(
            vertical: ScreenSizeHandler.screenHeight * 0.008),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding:
                  EdgeInsets.only(right: ScreenSizeHandler.screenWidth * 0.02),
              child: Avatar(
                avatar: avatarImage,
                radius: ScreenSizeHandler.bigger * 0.0155,
                defaultImg: isSubreddit
                    ? "assets/images/planet3.png"
                    : "assets/images/redditAvata2.png",
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isSubreddit ? "r/$title" : "u/$title",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: ScreenSizeHandler.bigger * 0.018),
                ),
                Text(
                  isSubreddit ? "$description members" : description,
                  style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                      fontSize: ScreenSizeHandler.bigger * 0.015),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class TrendingPreviewTile extends StatelessWidget {
  const TrendingPreviewTile({
    required this.image,
    required this.title,
    required this.description,
    super.key,
  });

  final String image;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, SearchingScreen.id, arguments: title);
      },
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: ScreenSizeHandler.screenWidth * 0.7,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                          color: const Color.fromARGB(255, 140, 140, 244),
                          fontWeight: FontWeight.bold,
                          fontSize: ScreenSizeHandler.bigger * 0.018),
                    ),
                    Text(
                      description,
                      style: TextStyle(
                          overflow: TextOverflow.ellipsis,
                          color: Colors.grey,
                          fontSize: ScreenSizeHandler.bigger * 0.015),
                      maxLines: 2,
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    right: ScreenSizeHandler.screenWidth * 0.02),
                child: Image.network(
                  image,
                  width: ScreenSizeHandler.screenWidth * 0.15,
                ),
              )
            ],
          ),
          Divider(
            color: Colors.grey[600]!,
            thickness: 0.5,
            height: ScreenSizeHandler.screenHeight * 0.04,
          )
        ],
      ),
    );
  }
}
