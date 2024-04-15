import 'package:flutter/material.dart';
import 'package:reddit_bel_ham/screens/subreddit_screen.dart';
import 'package:reddit_bel_ham/utilities/subreddit_store.dart';

class DrawerTwo extends StatefulWidget {
  final Function(bool) setIsRecentlyVisitedDrawerVisibleCbk;
  const DrawerTwo({
    required this.setIsRecentlyVisitedDrawerVisibleCbk,
    Key? key,
  }) : super(key: key);

  @override
  State<DrawerTwo> createState() => _DrawerTwoState();
}

class _DrawerTwoState extends State<DrawerTwo> {
  final bool isExitPressed = false;

  bool isRecentlyVisitedDrawerVisible = false;
  List<String> recentlyVisitedCommunities = [];
  List<String> subredditImages = [];

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
      child: Column(
        children: [
          SizedBox(height: 15), //REFACTOR THIS
          Row(
            children: [
              IconButton(
                  onPressed: () {
                    setState(() {
                      widget.setIsRecentlyVisitedDrawerVisibleCbk(false);
                    });
                  },
                  icon: Icon(Icons.arrow_back)),
              Text(
                'Recently Visited',
                style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
              ),
              Spacer(),
              GestureDetector(
                onTap: () {
                  setState(() {
                    recentlyVisitedCommunities.clear();
                    SubredditStore().clearSubreddits();
                    subredditImages.clear();
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: Text(
                    'Clear all',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Container(
            height: 300,
            child: Column(
              children: [
                Flexible(
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: recentlyVisitedCommunities.length,
                    itemBuilder: (context, index) {
                      return Container(
                        height: 50,
                        child: ListTile(
                          onTap:() {
                            Navigator.pushNamed(context, SubredditScreen.id, arguments: recentlyVisitedCommunities[index]);
                            },
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Image(
                              image: subredditImages[index] ==
                                      'assets/images/planet3.png'
                                  ? AssetImage('assets/images/planet3.png')
                                  : NetworkImage(subredditImages[index])
                                      as ImageProvider,
                              height: 23,
                            ),
                          ),
                          title: Text(
                            recentlyVisitedCommunities[index],
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                          trailing: IconButton(
                            onPressed: () {
                              setState(() {
                                recentlyVisitedCommunities
                                    .remove(recentlyVisitedCommunities[index]);
                                subredditImages.remove(subredditImages[index]);
                                SubredditStore().deleteSubreddit(index);
                              });
                            },
                            icon: Icon(
                              Icons.close,
                              color: Colors.grey,
                              size: 20,
                            ),
                          ),
                        ),
                      );
                    },
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
