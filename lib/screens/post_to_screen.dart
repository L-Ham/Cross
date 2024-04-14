import 'package:flutter/material.dart';
import 'package:reddit_bel_ham/components/general_components/interactive_text.dart';
import 'package:reddit_bel_ham/components/general_components/rounded_button.dart';
import 'package:reddit_bel_ham/constants.dart';
import 'package:reddit_bel_ham/services/api_service.dart';
import 'package:reddit_bel_ham/utilities/token_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../components/add_post_components/add_post_search_bar.dart';
import '../components/add_post_components/post_to_subreddit_tile.dart';
import '../utilities/screen_size_handler.dart';

class PostToScreen extends StatefulWidget {
  const PostToScreen({super.key});

  static const String id = 'post_to_screen';

  @override
  State<PostToScreen> createState() => _PostToScreenState();
}

class _PostToScreenState extends State<PostToScreen> {
  FocusNode searchFocus = FocusNode();
  bool isSearchFocused = false;
  ApiService apiService = ApiService(TokenDecoder.token);
  TextEditingController searchController = TextEditingController();
  bool isSearching = false;

  void selectSubreddit(int i) {
    String selectedSubreddit = subredditNames.removeAt(i);
    subredditNames.insert(0, selectedSubreddit);
    String selectedImage = subredditImages.removeAt(i);
    subredditImages.insert(0, selectedImage);
    int selectedNumOfOnlineUsers = numOfOnlineUsers.removeAt(i);
    numOfOnlineUsers.insert(0, selectedNumOfOnlineUsers);

    saveSubredditData();

    Navigator.pop(context, {
      "subredditName": subredditNames[i],
      "subredditImage": subredditImages[i],
      "subredditId": subredditIds[i],
    });
  }

  void selectSearchSubreddit(int i) {
    // String selectedSubreddit = subredditNames.removeAt(i);
    // subredditNames.insert(0, selectedSubreddit);
    // String selectedImage = subredditImages.removeAt(i);
    // subredditImages.insert(0, selectedImage);
    // int selectedNumOfOnlineUsers = numOfOnlineUsers.removeAt(i);
    // numOfOnlineUsers.insert(0, selectedNumOfOnlineUsers);

    saveSubredditData();

    Navigator.pop(context, {
      "subredditName": searchedSubredditNames[i],
      "subredditImage": searchSubredditImages[i],
      "subredditId": searchSubredditId[i],
    });
  }

  Future<void> saveSubredditData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('subredditNames', subredditNames);
    await prefs.setStringList('subredditImages', subredditImages);
    await prefs.setStringList(
        'numOfOnlineUsers', numOfOnlineUsers.map((i) => i.toString()).toList());
  }

  Future<void> loadSubredditData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      subredditNames = prefs.getStringList('subredditNames') ?? subredditNames;
      subredditImages =
          prefs.getStringList('subredditImages') ?? subredditImages;
      numOfOnlineUsers = (prefs.getStringList('numOfOnlineUsers') ??
              numOfOnlineUsers.map((i) => i.toString()).toList())
          .map((i) => int.parse(i))
          .toList();
    });
    print(subredditImages);
  }

  void getSubredditsFromBack() async {
    Map<String, dynamic> results =
        await apiService.searchSubredditByName(searchController.text);
    List<dynamic> resultsList = results['matchingNames'];
    searchSubreddit(resultsList);
  }

  void searchSubreddit(List<dynamic> resultsList) {
    searchSubredditImages.clear();
    searchSubredditId.clear();
    searchedSubredditNames.clear();
    searchNumOfOnlineUsers.clear();
    for (int i = 0; i < resultsList.length; i++) {
      setState(() {
        if (resultsList[i]["appearance"]["avatarImage"] != null) {
          searchSubredditImages
              .add(resultsList[i]["appearance"]["avatarImage"]);
        } else {
          searchSubredditImages.add('assets/images/planet3.png');
        }
        searchSubredditId.add(resultsList[i]["_id"]);
        searchedSubredditNames.add(resultsList[i]["name"]);
        searchNumOfOnlineUsers.add(resultsList[i]["membersCount"]);
      });
    }
    print(searchedSubredditNames);
  }

  void refreshSubreddit(String subredditName) {
    setState(() {
      getSubredditsFromBack();
    });
  }

  List<String> subredditNames = [];
  List<String> subredditImages = [];
  List<int> numOfOnlineUsers = [];
  List<String> subredditIds = [];

  List<String> searchedSubredditNames = [];
  List<String> searchSubredditImages = [];
  List<int> searchNumOfOnlineUsers = [];
  List<String> searchSubredditId = [];
  String selectedSubredditName = "";
  bool isSeeMore = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final Map<String, dynamic>? args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    if (args != null) {
      selectedSubredditName = args["subredditName"];
    }
  }

  @override
  void initState() {
    super.initState();
    loadSubredditData();
    searchFocus.addListener(() {
      setState(() {
        isSearchFocused = searchFocus.hasFocus;
      });
      searchController.addListener(() {
        setState(() {
          isSearching = searchController.text.isNotEmpty;
          if (isSearching) refreshSubreddit(searchController.text);
        });
      });
    });
  }

  @override
  void dispose() {
    searchFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        toolbarHeight:
            ScreenSizeHandler.bigger * (isSearchFocused ? 0.06 : 0.12),
        automaticallyImplyLeading: false,
        leading: null,
        elevation: 0,
        backgroundColor: kBackgroundColor,
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (!isSearchFocused)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.clear_sharp,
                      size:
                          ScreenSizeHandler.bigger * kCancelAppbarIconSizeRatio,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  Text(
                    "Post to",
                    style: TextStyle(
                        fontSize: ScreenSizeHandler.smaller *
                            kAppBarTitleSmallerFontRatio,
                        fontWeight: FontWeight.w500),
                  ),
                  Container(
                    width: ScreenSizeHandler.screenWidth * 0.13,
                  ),
                ],
              ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: ScreenSizeHandler.screenWidth * 0.015),
              child: Row(
                children: [
                  Expanded(
                    child: AddPostSearchBar(
                      searchController: searchController,
                      isSearchFocused: searchFocus,
                    ),
                  ),
                  if (isSearchFocused)
                    Padding(
                      padding: EdgeInsets.only(
                          left: ScreenSizeHandler.screenWidth * 0.03),
                      child: InteractiveText(
                        onTap: () {
                          searchFocus.unfocus();
                        },
                        text: "Cancel",
                        fontSizeRatio: 0.02,
                        isUnderlined: true,
                      ),
                    )
                ],
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: ScreenSizeHandler.screenWidth * 0.05),
          child: !isSearching
              ? Column(
                  children: [
                    SizedBox(
                      height: ScreenSizeHandler.screenHeight * 0.018,
                    ),
                    if (subredditNames.length < 5)
                      for (int i = 0; i < subredditNames.length; i++)
                        PostToSubredditTile(
                          subredditName: subredditNames[i],
                          selectedSubredditName: selectedSubredditName,
                          subredditImage: subredditImages[i],
                          numOfOnlineUsers: numOfOnlineUsers[i],
                          onTap: () {
                            selectSubreddit(i);
                          },
                        ),
                    if (subredditNames.length > 5)
                      for (int i = 0; i < 5; i++)
                        PostToSubredditTile(
                          subredditName: subredditNames[i],
                          selectedSubredditName: selectedSubredditName,
                          subredditImage: subredditImages[i],
                          numOfOnlineUsers: numOfOnlineUsers[i],
                          onTap: () {
                            selectSubreddit(i);
                          },
                        ),
                    if (isSeeMore)
                      for (int i = 5; i < subredditNames.length; i++)
                        PostToSubredditTile(
                          subredditName: subredditNames[i],
                          selectedSubredditName: selectedSubredditName,
                          subredditImage: subredditImages[i],
                          numOfOnlineUsers: numOfOnlineUsers[i],
                          onTap: () {
                            selectSubreddit(i);
                          },
                        ),
                    if (subredditNames.length > 5 && !isSeeMore)
                      Padding(
                        padding: EdgeInsets.only(
                            top: ScreenSizeHandler.screenHeight * 0.02),
                        child: RoundedButton(
                          onTap: () {
                            setState(() {
                              isSeeMore = true;
                            });
                          },
                          buttonHeightRatio: 0.055,
                          buttonWidthRatio: 0.49,
                          buttonColor: kBackgroundColor,
                          borderColor: Colors.blue,
                          child: const Text(
                            'See More',
                            style: TextStyle(
                                color: Colors.blue,
                                decoration: TextDecoration.underline,
                                decorationThickness: 2,
                                decorationColor: Colors.blue,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                  ],
                )
              : Column(
                  children: [
                    SizedBox(
                      height: ScreenSizeHandler.screenHeight * 0.018,
                    ),
                    for (int i = 0; i < searchedSubredditNames.length; i++)
                      PostToSubredditTile(
                        subredditName: searchedSubredditNames[i],
                        selectedSubredditName: selectedSubredditName,
                        subredditImage: searchSubredditImages[i],
                        numOfOnlineUsers: searchNumOfOnlineUsers[i],
                        onTap: () {
                          selectSearchSubreddit(i);
                        },
                      ),
                  ],
                ),
        ),
      ),
    );
  }
}
