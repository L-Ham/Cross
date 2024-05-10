import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:reddit_bel_ham/screens/subreddit_screen.dart';
import 'package:reddit_bel_ham/services/api_service.dart';
import 'package:reddit_bel_ham/utilities/screen_size_handler.dart';
import 'package:reddit_bel_ham/utilities/subreddit_store.dart';
import 'package:reddit_bel_ham/utilities/token_decoder.dart';

class DrawerOne extends StatefulWidget {
  final Function(bool) setIsRecentlyVisitedDrawerVisibleCbk;

  DrawerOne({
    required this.setIsRecentlyVisitedDrawerVisibleCbk,
    Key? key,
  }) : super(key: key);

  @override
  _DrawerOneState createState() => _DrawerOneState();
}

class Community {
  final String id;
  final String name;
  final String avatar;
  final bool isFavorite;
  late bool isModerator;

  Community({
    required this.id,
    required this.name,
    required this.avatar,
    required this.isFavorite,
    this.isModerator = false,
  });
}

class _DrawerOneState extends State<DrawerOne> {
  bool isFavoritesPressed = true;
  bool isYourCommunitiesPressed = false;
  bool isModeratingPressed = false;

  List<String> subredditImages = [];
  List<String> recentlyVisitedCommunities = [];

  List<String> favSubredditImages = [];
  List<Community> favoriteCommunities = [];

  List<Community> moderatingCommunities = [];
  List<Community> yourCommunities = [];

  ApiService apiService = ApiService(TokenDecoder.token);

  void getRecentSubreddits() async {
    SubredditStore().getSubreddits().then((value) {
      setState(() {
        recentlyVisitedCommunities = value['names']!;
        subredditImages = value['images']!;
      });
    });
  }

  Future<void> getYourCommunities() async {
    Map<String, dynamic> data = (await apiService.getYourCommunities()) ?? {};
    if (mounted) {
      setState(() {
        moderatingCommunities.clear();
        yourCommunities = (data['communities'] as List).map((community) {
          Community newCommunity = Community(
            id: community['communityId'],
            name: community['communityName'],
            avatar: community['communityAvatar'] ??
                'assets/images/community_logo.png',
            isFavorite: community['isFavorite'],
            isModerator: community['isModerator'],
          );
          if (newCommunity.isModerator) {
            moderatingCommunities.add(newCommunity);
          }
          return newCommunity;
        }).toList();
      });
    }
  }

  Future<void> getFavouriteCommunities() async {
    Map<String, dynamic> data =
        (await apiService.getFavouriteCommunities()) ?? {};
    if (mounted) {
      setState(() {
        favoriteCommunities =
            (data['communitiesWithAvatar'] as List).map((community) {
          Community newCommunity = Community(
            id: community['id'],
            name: community['name'],
            avatar: community['avatar'] ?? 'assets/images/community_logo.png',
            isFavorite: true,
          );
          return newCommunity;
        }).toList();
      });
    }
  }

  Future<void> favouriteSubreddit(String subredditID) async {
    await apiService.favouriteSubreddit(subredditID);
    getFavouriteCommunities();
    getYourCommunities();
  }

  Future<void> unfavouriteSubreddit(String subredditID) async {
    await apiService.unfavouriteSubreddit(subredditID);
    getFavouriteCommunities();
    getYourCommunities();
  }

  @override
  void didChangeDependencies() {
    getRecentSubreddits();
    getYourCommunities();
    getFavouriteCommunities();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        children: [
          Column(
            children: [
              if (recentlyVisitedCommunities.isNotEmpty) Divider(),
              if (recentlyVisitedCommunities.isNotEmpty)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        'Recently Visited',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          widget.setIsRecentlyVisitedDrawerVisibleCbk(true);
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(right: 20.0),
                        child: Semantics(
                          key: Key('see_all_button'),
                          child: Text(
                            'See all',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              if (recentlyVisitedCommunities.isNotEmpty)
                Container(
                  height: recentlyVisitedCommunities.length > 3
                      ? 150.0
                      : 50.0 * recentlyVisitedCommunities.length,
                  child: Column(
                    children: [
                      Flexible(
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: recentlyVisitedCommunities.length > 3
                              ? 3
                              : recentlyVisitedCommunities.length,
                          itemBuilder: (context, index) {
                            return Container(
                              height: 50,
                              child: ListTile(
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    SubredditScreen.id,
                                    arguments:
                                        recentlyVisitedCommunities[index],
                                  );
                                },
                                title: Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(50),
                                      child: Image(
                                        image: subredditImages[index] ==
                                                'assets/images/planet3.png'
                                            ? AssetImage(
                                                'assets/images/planet3.png')
                                            : NetworkImage(
                                                    subredditImages[index])
                                                as ImageProvider,
                                        height: 23,
                                      ),
                                    ),
                                    SizedBox(
                                      width:
                                          ScreenSizeHandler.screenWidth * 0.6,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          'r/' +
                                              recentlyVisitedCommunities[index],
                                          style: TextStyle(
                                            overflow: TextOverflow.ellipsis,
                                            color: Colors.white,
                                            fontSize: 15,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              if (favoriteCommunities.isNotEmpty) Divider(),
              if (favoriteCommunities.isNotEmpty)
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isFavoritesPressed = !isFavoritesPressed;
                    });
                  },
                  child: ListTile(
                    title: Text(
                      'Favorites',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                    trailing: isFavoritesPressed
                        ? Icon(
                            Icons.keyboard_arrow_down_outlined,
                            size: 25, // REFACTOR THIS
                          )
                        : Icon(
                            Icons.arrow_forward_ios_outlined,
                            size: 15,
                          ),
                  ),
                ),
            ],
          ),
          if (favoriteCommunities.isNotEmpty)
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              height:
                  isFavoritesPressed ? 50.0 * favoriteCommunities.length : 0,
              child: Column(
                children: [
                  Flexible(
                    child: isFavoritesPressed
                        ? ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: favoriteCommunities.length,
                            itemBuilder: (context, index) {
                              return SizedBox(
                                height: 50,
                                child: ListTile(
                                  title: Row(
                                    children: [
                                      favoriteCommunities[index].avatar ==
                                              'Custom Feeds'
                                          ? Icon(Icons.feed_outlined)
                                          : CircleAvatar(
                                              backgroundImage: favoriteCommunities[
                                                              index]
                                                          .avatar !=
                                                      'assets/images/community_logo.png'
                                                  ? NetworkImage(
                                                      favoriteCommunities[index]
                                                          .avatar)
                                                  : const AssetImage(
                                                      'assets/images/community_logo.png',
                                                    ) as ImageProvider,
                                              radius: 13,
                                            ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: GestureDetector(
                                          onTap: () {
                                            Navigator.pushNamed(
                                              context,
                                              SubredditScreen.id,
                                              arguments:
                                                  favoriteCommunities[index]
                                                      .name,
                                            );
                                          },
                                          child: Text(
                                            'r/${favoriteCommunities[index].name}',
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 15,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const Spacer(),
                                      IconButton(
                                        onPressed: () {
                                          setState(() {
                                            if (favoriteCommunities[index]
                                                .isFavorite) {
                                              unfavouriteSubreddit(
                                                  favoriteCommunities[index]
                                                      .id);
                                            } else {
                                              favouriteSubreddit(
                                                  favoriteCommunities[index]
                                                      .id);
                                            }
                                          });
                                        },
                                        icon: Icon(
                                          favoriteCommunities[index].isFavorite
                                              ? Icons.star_rounded
                                              : Icons.star_border_rounded,
                                          color: Colors.grey,
                                          size: 23,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                          )
                        : Container(), // Provide a default widget when isFavoritesPressed is false
                  ),
                ],
              ),
            ),
          if (recentlyVisitedCommunities.isNotEmpty ||
              favoriteCommunities.isNotEmpty)
            Divider(),
          GestureDetector(
            onTap: () {
              setState(() {
                isModeratingPressed = !isModeratingPressed;
              });
            },
            child: ListTile(
              title: Text(
                'Moderating',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
              trailing: isModeratingPressed
                  ? Icon(
                      Icons.keyboard_arrow_down_outlined,
                      size: 25, // REFACTOR THIS
                    )
                  : const Icon(
                      Icons.arrow_forward_ios_outlined,
                      size: 15,
                    ),
            ),
          ),
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            child: Column(
              children: [
                isModeratingPressed
                    ? ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: 3 + moderatingCommunities.length,
                        itemBuilder: (context, index) {
                          if (index == 0)
                            return ListTile(
                              leading: Icon(Icons.feed_outlined),
                              title: Text("Mod Feed"),
                            );
                          else if (index == 1)
                            return ListTile(
                              leading: Icon(Icons.queue_rounded),
                              title: Text("Queues"),
                            );
                          else if (index == 2)
                            return ListTile(
                              leading: Icon(Icons.mail_outline_rounded),
                              title: Text("Modmail"),
                            );
                          else {
                            return ListTile(
                              title: Row(
                                children: [
                                  CircleAvatar(
                                    backgroundImage: moderatingCommunities[
                                                    index - 3]
                                                .avatar !=
                                            'assets/images/community_logo.png'
                                        ? NetworkImage(
                                            moderatingCommunities[index - 3]
                                                .avatar)
                                        : AssetImage(
                                            'assets/images/community_logo.png',
                                          ) as ImageProvider,
                                    radius: 13,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.pushNamed(
                                          context,
                                          SubredditScreen.id,
                                          arguments:
                                              moderatingCommunities[index - 3]
                                                  .name,
                                        );
                                      },
                                      child: Text(
                                        'r/' +
                                            moderatingCommunities[index - 3]
                                                .name,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Spacer(),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        if (moderatingCommunities[index - 3]
                                            .isFavorite) {
                                          unfavouriteSubreddit(
                                              moderatingCommunities[index - 3]
                                                  .id);
                                        } else {
                                          favouriteSubreddit(
                                              moderatingCommunities[index - 3]
                                                  .id);
                                        }
                                      });
                                    },
                                    child: Icon(
                                      moderatingCommunities[index - 3]
                                              .isFavorite
                                          ? Icons.star_rounded
                                          : Icons.star_border_rounded,
                                      color: Colors.grey,
                                      size: 23,
                                    ),
                                  )
                                ],
                              ),
                            );
                          }
                        },
                      )
                    : Container(),
              ],
            ),
          ),
          if (yourCommunities.isNotEmpty) Divider(),
          GestureDetector(
            onTap: () {
              setState(() {
                isYourCommunitiesPressed = !isYourCommunitiesPressed;
              });
            },
            child: ListTile(
              title: Text(
                'Your Communities',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
              trailing: isYourCommunitiesPressed
                  ? Icon(
                      Icons.keyboard_arrow_down_outlined,
                      size: 25,
                    )
                  : Icon(
                      Icons.arrow_forward_ios_outlined,
                      size: 15,
                    ),
            ),
          ),
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            height: isYourCommunitiesPressed
                ? 50.0 * (yourCommunities.length + 2)
                : 0,
            child: Column(
              children: [
                Flexible(
                  child: isYourCommunitiesPressed
                      ? Container(
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: 2 + yourCommunities.length,
                            itemBuilder: (context, index) {
                              return SizedBox(
                                  height: 50,
                                  child: index == 0
                                      ? ListTile(
                                          leading: Icon(Icons.add),
                                          title: Text("Create a community"),
                                          onTap: () {
                                            Navigator.pushNamed(context,
                                                'create_community_screen');
                                          },
                                        )
                                      : index != 1 + yourCommunities.length
                                          ? ListTile(
                                              title: Row(
                                                children: [
                                                  CircleAvatar(
                                                    backgroundImage: yourCommunities[
                                                                    index - 1]
                                                                .avatar !=
                                                            'assets/images/community_logo.png'
                                                        ? NetworkImage(
                                                            yourCommunities[
                                                                    index - 1]
                                                                .avatar)
                                                        : AssetImage(
                                                            'assets/images/community_logo.png',
                                                          ) as ImageProvider,
                                                    radius: 13,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        Navigator.pushNamed(
                                                          context,
                                                          SubredditScreen.id,
                                                          arguments:
                                                              yourCommunities[
                                                                      index - 1]
                                                                  .name,
                                                        );
                                                      },
                                                      child: Text(
                                                        'r/${yourCommunities[index - 1].name}',
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 15,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Spacer(),
                                                  GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        if (yourCommunities[
                                                                index - 1]
                                                            .isFavorite) {
                                                          unfavouriteSubreddit(
                                                              yourCommunities[
                                                                      index - 1]
                                                                  .id);
                                                        } else {
                                                          favouriteSubreddit(
                                                              yourCommunities[
                                                                      index - 1]
                                                                  .id);
                                                        }
                                                      });
                                                    },
                                                    child: Icon(
                                                      yourCommunities[index - 1]
                                                              .isFavorite
                                                          ? Icons.star_rounded
                                                          : Icons
                                                              .star_border_rounded,
                                                      color: Colors.grey,
                                                      size: 23,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            )
                                          : ListTile(
                                              title: Row(
                                                children: [
                                                  Icon(Icons.feed_outlined),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(
                                                      'Custom Feeds',
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 15,
                                                      ),
                                                    ),
                                                  ),
                                                  Spacer(),
                                                  GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        // favoriteCommunities
                                                        //         .contains(
                                                        //             'Custom Feeds')
                                                        //     ? favoriteCommunities
                                                        //         .remove(
                                                        //             'Custom Feeds')
                                                        //     : favoriteCommunities
                                                        //         .add(
                                                        //             'Custom Feeds');
                                                      });
                                                    },
                                                    child: Icon(
                                                      favoriteCommunities
                                                              .contains(
                                                                  'Custom Feeds')
                                                          ? Icons.star_rounded
                                                          : Icons
                                                              .star_border_rounded,
                                                      color: Colors.grey,
                                                      size: 23,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ));
                            },
                          ),
                        )
                      : Container(),
                ),
              ],
            ),
          ),
          Divider(),
          ListTile(
            title: Row(
              children: [
                Container(
                  width: 18,
                  height: 18,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white,
                      width: 1,
                    ),
                  ),
                  child: Icon(
                    Icons.bar_chart_rounded,
                    color: Colors.white,
                    size: 15,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'All',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
