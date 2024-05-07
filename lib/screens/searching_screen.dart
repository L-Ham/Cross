import 'package:flutter/material.dart';
import 'package:reddit_bel_ham/screens/communities_search_screen.dart';
import 'package:reddit_bel_ham/screens/people_search_screen.dart';
import 'package:reddit_bel_ham/services/api_service.dart';
import 'package:reddit_bel_ham/utilities/token_decoder.dart';
import '../components/general_components/reddit_loading_indicator.dart';
import '../constants.dart';
import '../utilities/screen_size_handler.dart';

class SearchingScreen extends StatefulWidget {
  const SearchingScreen({super.key});

  static const id = 'searching_screen';

  @override
  State<SearchingScreen> createState() => _SearchingScreenState();
}

TextEditingController _searchController = TextEditingController();

class _SearchingScreenState extends State<SearchingScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late Map<String, dynamic> args;

  List<String> subredditNames = [];
  List<int> subredditMembers = [];
  List<String> subredditAvatarImages = [];

  List<String> userNames = [];
  List<String> userAvatarImages = [];

  bool isLoading = false;

  ApiService apiService = ApiService(TokenDecoder.token);

  void getSearchesFromBack() async {
    setState(() {
      isLoading = true;
    });
    Map<String, dynamic> results =
        await apiService.searchSubredditByName(_searchController.text);
    List<dynamic> resultsList = results['matchingNames'];
    searchSubreddit(resultsList);
    Map<String, dynamic> response =
        await apiService.getSearchedForBlockedUsers(_searchController.text);
    searchPeople(response['matchingUsernames'] as List<dynamic>);
  }

  void searchPeople(List<dynamic> resultsList) {
    userNames.clear();
    userAvatarImages.clear();
    for (int i = 0; i < resultsList.length; i++) {
      mounted
          ? setState(() {
              // if (resultsList[i]["avatarImage"] != null) {
              //   userAvatarImages.add(resultsList[i]["avatarImage"]);
              // } else {
              //   userAvatarImages.add('assets/images/redditAvata2.png');
              // }
              userAvatarImages.add('assets/images/redditAvata2.png');
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
    subredditNames.clear();
    subredditMembers.clear();
    subredditAvatarImages.clear();

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

  @override
  void initState() {
    _tabController = TabController(length: 4, vsync: this);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    setState(() {
      _searchController.text =
          ModalRoute.of(context)!.settings.arguments as String;
    });
    getSearchesFromBack();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Column(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: SizedBox(
                height: ScreenSizeHandler.bigger * 0.04,
                width: ScreenSizeHandler.screenWidth * 0.8,
                child: Container(
                  color: kFillingColor,
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: ScreenSizeHandler.screenWidth * 0.018),
                        child: Icon(
                          Icons.search,
                          size: ScreenSizeHandler.bigger * 0.029,
                        ),
                      ),
                      Text(
                        _searchController.text,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: ScreenSizeHandler.bigger * 0.019),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        backgroundColor: kBackgroundColor,
      ),
      backgroundColor: kBackgroundColor,
      body: Column(
        children: [
          TabBar(
            controller: _tabController,
            indicatorColor: const Color.fromARGB(255, 70, 111, 205),
            labelColor: Colors.white,
            indicator: UnderlineTabIndicator(
              borderSide: BorderSide(
                width: ScreenSizeHandler.screenWidth * 0.01,
                color: const Color.fromARGB(255, 70, 111, 205),
              ),
            ),
            unselectedLabelColor: Colors.white,
            labelStyle: TextStyle(
                fontSize: ScreenSizeHandler.bigger * 0.017,
                fontWeight: FontWeight.w400),
            labelPadding: const EdgeInsets.all(0),
            indicatorSize: TabBarIndicatorSize.label,
            tabs: const [
              Tab(text: 'Posts'),
              Tab(text: 'Communities'),
              Tab(text: 'Comments'),
              Tab(text: 'People'),
            ],
          ),
          isLoading
              ? const Center(child: RedditLoadingIndicator())
              : Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      Center(child: Text("NOT IMPLEMENTED YET")),
                      CommunitiesSearchScreen(
                        subredditAvatarImages: subredditAvatarImages,
                        subredditMembers: subredditMembers,
                        subredditNames: subredditNames,
                      ),
                      Center(child: Text("NOT IMPLEMENTED YET")),
                      PeopleSearchScreen(
                          userNames: userNames,
                          userAvatarImages: userAvatarImages),
                    ],
                  ),
                ),
        ],
      ),
    );
  }
}
