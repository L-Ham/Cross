import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:reddit_bel_ham/screens/subreddit_screen.dart';
import 'package:reddit_bel_ham/utilities/subreddit_store.dart';

class DrawerOne extends StatefulWidget {
  final Function(bool) setIsRecentlyVisitedDrawerVisibleCbk;
  const DrawerOne({
    required this.setIsRecentlyVisitedDrawerVisibleCbk,
    Key? key,
  }) : super(key: key);

  @override
  _DrawerOneState createState() => _DrawerOneState();
}

class _DrawerOneState extends State<DrawerOne> {
  List<String> recentlyVisitedCommunities = [];
  List<String> subredditImages = [];

  bool isFavoritesPressed = true;
  List<String> favoriteCommunities = [];

  bool isModeratingPressed = false;
  List<String> moderatingCommunities = [
    'Comm1',
    'Comm2',
    'Comm3',
    'Comm4',
    'Comm5',
    'Comm6',
    'Comm7',
    'Comm8',
    'Comm9',
    'Comm10',
  ];

  bool isYourCommunitiesPressed = false;
  List<String> yourCommunities = [
    'Yourcommunity1',
    'Yourcommunity2',
    'Yourcommunity3',
    'Yourcommunity4',
  ];

  void getRecentSubreddits() async {
    SubredditStore().getSubreddits().then((value) {
      setState(() {
        recentlyVisitedCommunities = value['names']!;
        subredditImages = value['images']!;
        
      });
    });
  }

  @override
  void didChangeDependencies() {
    getRecentSubreddits();
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
                                      context, SubredditScreen.id,
                                      arguments:
                                          recentlyVisitedCommunities[index]);
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
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        'r/' +
                                            recentlyVisitedCommunities[index],
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
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
                        ? Container(
                            child: ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: favoriteCommunities.length,
                              itemBuilder: (context, index) {
                                return SizedBox(
                                  height: 50,
                                  child: ListTile(
                                    title: Row(
                                      children: [
                                        favoriteCommunities[index] ==
                                                'Custom Feeds'
                                            ? Icon(Icons.feed_outlined)
                                            : Image(
                                                image: const AssetImage(
                                                    'assets/images/community_logo.png'),
                                                height: 23,
                                              ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            'r/${favoriteCommunities[index]}',
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 15,
                                            ),
                                          ),
                                        ),
                                        const Spacer(),
                                        IconButton(
                                          onPressed: () {
                                            setState(() {
                                              favoriteCommunities.remove(
                                                  favoriteCommunities[index]);
                                            });
                                          },
                                          icon: Icon(
                                            Icons.star_rounded,
                                            color: Colors.grey,
                                            size: 23,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          )
                        : Container(), // Provide a default widget when isFavoritesPressed is false
                  ),
                ],
              ),
            ),
          if (recentlyVisitedCommunities.isNotEmpty) Divider(),
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
            height:
                isModeratingPressed ? 50.0 * moderatingCommunities.length : 0,
            child: Column(
              children: [
                Flexible(
                    child: isModeratingPressed
                        ? Container(
                            child: ListView.builder(
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
                                        Image(
                                          image: AssetImage(
                                              'assets/images/community_logo.png'),
                                          height: 23,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            'r/' +
                                                moderatingCommunities[
                                                    index - 3],
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
                                              favoriteCommunities.contains(
                                                      moderatingCommunities[
                                                          index - 3])
                                                  ? favoriteCommunities.remove(
                                                      moderatingCommunities[
                                                          index - 3])
                                                  : favoriteCommunities.add(
                                                      moderatingCommunities[
                                                          index - 3]);
                                            });
                                          },
                                          child: Icon(
                                            favoriteCommunities.contains(
                                                    moderatingCommunities[
                                                        index - 3])
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
                            ),
                          )
                        : Container()),
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
                                                  Image(
                                                    image: AssetImage(
                                                        'assets/images/community_logo.png'),
                                                    height: 23,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(
                                                      'r/${yourCommunities[index - 1]}',
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
                                                        favoriteCommunities
                                                                .contains(
                                                                    yourCommunities[
                                                                        index -
                                                                            1])
                                                            ? favoriteCommunities
                                                                .remove(
                                                                    yourCommunities[
                                                                        index -
                                                                            1])
                                                            : favoriteCommunities
                                                                .add(
                                                                    yourCommunities[
                                                                        index -
                                                                            1]);
                                                      });
                                                    },
                                                    child: Icon(
                                                      favoriteCommunities
                                                              .contains(
                                                                  yourCommunities[
                                                                      index -
                                                                          1])
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
                                                        favoriteCommunities
                                                                .contains(
                                                                    'Custom Feeds')
                                                            ? favoriteCommunities
                                                                .remove(
                                                                    'Custom Feeds')
                                                            : favoriteCommunities
                                                                .add(
                                                                    'Custom Feeds');
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
