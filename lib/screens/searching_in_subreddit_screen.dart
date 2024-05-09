import 'package:flutter/material.dart';
import 'package:reddit_bel_ham/components/general_components/rounded_button.dart';
import 'package:reddit_bel_ham/components/searching_components/sort_bottom_sheet.dart';
import 'package:reddit_bel_ham/components/searching_components/sort_time_bottom_sheet.dart';
import 'package:reddit_bel_ham/screens/comments_search_screen.dart';
import 'package:reddit_bel_ham/screens/communities_search_screen.dart';
import 'package:reddit_bel_ham/screens/people_search_screen.dart';
import 'package:reddit_bel_ham/screens/post_search_screen.dart';
import 'package:reddit_bel_ham/screens/searching_screen.dart';
import 'package:reddit_bel_ham/services/api_service.dart';
import 'package:reddit_bel_ham/utilities/token_decoder.dart';
import '../components/general_components/reddit_loading_indicator.dart';
import '../constants.dart';
import '../utilities/screen_size_handler.dart';
import '../utilities/time_ago.dart';

class SearchingInSubreddit extends StatefulWidget {
  const SearchingInSubreddit({super.key});

  static const id = 'searching_in_subreddit_screen';

  @override
  State<SearchingInSubreddit> createState() => _SearchingInSubredditState();
}

TextEditingController _searchController = TextEditingController();

class _SearchingInSubredditState extends State<SearchingInSubreddit>
    with SingleTickerProviderStateMixin {
  String sortValue = "Most relevant";
  bool isSorted = false;
  String sortTimeValue = "All time";
  bool isTimeSorted = false;
  late TabController _tabController;
  late Map<String, dynamic> args;

  List<String> subredditNames = [];
  List<int> subredditMembers = [];
  List<String> subredditAvatarImages = [];

  List<String> userNames = [];
  List<String> userAvatarImages = [];
  List<PostSearchCard> searchedPosts = [];
  List<CommentSearchCard> searchedComments = [];
  List<PostSearchCard> originalList = [];

  bool firstTime = true;
  bool isLoading = false;
  String subredditImage = 'assets/images/planet3.png';
  late String subredditName;

  ApiService apiService = ApiService(TokenDecoder.token);

  void getSearchesFromBack() async {
    setState(() {
      isLoading = true;
    });
    Map<String, dynamic> commentsResponse =
        await apiService.searchCommentsInSubreddit({
      "search": _searchController.text,
      "relevance":
          sortValue == "Most relevant" ? true.toString() : false.toString(),
      "top": sortValue == "Top" ? true.toString() : false.toString(),
      "new": sortValue == "New" ? true.toString() : false.toString(),
      "subredditName": subredditName,
    });
    searchComments(commentsResponse['comments'] as List<dynamic>);
    // Map<String, dynamic> postsResponse =
    //     await apiService.searchPostsInSubreddit({
    //   "search": _searchController.text,
    //   "subRedditName": subredditName,
    //   "relevance":
    //       sortValue == "Most relevant" ? true.toString() : false.toString(),
    //   "top": sortValue == "Top" ? true.toString() : false.toString(),
    //   "new": sortValue == "New" ? true.toString() : false.toString(),
    //   "mediaOnly": false.toString(),
    //   "isNSFW": true.toString(),
    // });
    // print(postsResponse);
    // searchPosts(postsResponse['posts'] as List<dynamic>);
    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  void searchPosts(List<dynamic> resultsList) {
    searchedPosts.clear();
    for (int i = 0; i < resultsList.length; i++) {
      PostSearchCard postSearchCard = PostSearchCard(
        userName: resultsList[i]["userName"],
        userAvatarImage:
            resultsList[i]["userAvatar"] ?? "assets/images/redditAvata2.png",
        postId: resultsList[i]["postId"],
        title: resultsList[i]["title"],
        text: resultsList[i]["text"] ?? "",
        type: resultsList[i]["type"],
        image: resultsList[i]["image"],
        video: resultsList[i]["video"] ?? "",
        subredditName: resultsList[i]["subreddit"] ?? "",
        subredditId: resultsList[i]["subRedditId"] ?? "f",
        avatarImageSubreddit: resultsList[i]["avatarImageSubReddit"] ??
            "assets/images/planet3.png",
        createdAt: DateTime.parse(resultsList[i]["createdAt"]),
        displayDate: timeAgo(resultsList[i]["createdAt"]),
        score: resultsList[i]["score"],
        commentCount: resultsList[i]["commentCount"],
      );
      searchedPosts.add(postSearchCard);
    }
    originalList = searchedPosts;
  }

  void sortAndFilterPosts(String sortTimeVal) {
    searchedPosts = originalList;
    searchedPosts.sort((a, b) => b.createdAt.compareTo(a.createdAt));

    DateTime cutoff;

    switch (sortTimeVal) {
      case 'All time':
        return;
      case 'Past hour':
        cutoff = DateTime.now().subtract(const Duration(hours: 1));
        break;
      case 'Today':
        cutoff = DateTime.now().subtract(const Duration(days: 1));
        break;
      case 'Past week':
        cutoff = DateTime.now().subtract(const Duration(days: 7));
        break;
      case 'Past month':
        cutoff = DateTime.now().subtract(const Duration(days: 30));
        break;
      case 'Past year':
        cutoff = DateTime.now().subtract(const Duration(days: 365));
        break;
      default:
        throw Exception('Invalid sortTimeVal: $sortTimeVal');
    }

    setState(() {
      searchedPosts = searchedPosts
          .where((post) => post.createdAt.isAfter(cutoff))
          .toList();
    });
  }

  void searchComments(List<dynamic> resultsList) {
    searchedComments.clear();
    for (int i = 0; i < resultsList.length; i++) {
      CommentSearchCard commentSearchCard = CommentSearchCard(
        commentId: resultsList[i]["_id"],
        postId: resultsList[i]["postId"],
        userId: resultsList[i]["userId"],
        subredditName: resultsList[i]["subRedditName"] ?? "",
        postCreationDate: timeAgo(resultsList[i]["postCreatedAt"]),
        postTitle: resultsList[i]["postTitle"],
        postUpvotes: resultsList[i]["postUpvotes"],
        numberOfComments: resultsList[i]["commentUpvotes"],
        userAvatarImage:
            resultsList[i]["userAvatar"] ?? "assets/images/redditAvata2.png",
        commentCreationDate: timeAgo(resultsList[i]["commentCreatedAt"]),
        commentText: resultsList[i]["commentText"],
        commentUpvotes: resultsList[i]["commentUpvotes"] -
            resultsList[i]["commentDownvotes"],
        actualPostCreationDate: DateTime.parse(resultsList[i]["postCreatedAt"]),
        actualCommentCreationDate:
            DateTime.parse(resultsList[i]["commentCreatedAt"]),
        subredditImage:
            resultsList[i]["subRedditAvatar"] ?? "assets/images/planet3.png",
        userName: resultsList[i]["userName"],
      );
      print(commentSearchCard.commentCreationDate);
      searchedComments.add(commentSearchCard);
    }
  }

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(_handleTabSelection);
    super.initState();
  }

  void _handleTabSelection() {
    if (_tabController.indexIsChanging) {
      setState(() {});
    }
  }

  @override
  void didChangeDependencies() {
    setState(() {
      Map<String, dynamic> args =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
      _searchController.text = args['search'] as String;
      if (args['subredditName'] != null) {
        subredditName = args['subredditName'] as String;
      } else {
        subredditName = '';
      }
      if (args['subredditImage'] != null) {
        subredditImage = args['subredditImage'] as String;
      }
      if (args['searchType'] != null) {
        sortValue = args['searchType'] as String;
        isSorted = true;
      }
    });
    if (firstTime) {
      getSearchesFromBack();
      firstTime = false;
    }
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
                      CircleAvatar(
                        radius: ScreenSizeHandler.bigger * 0.01,
                        foregroundImage: subredditImage !=
                                'assets/images/planet3.png'
                            ? NetworkImage(subredditImage)
                            : Image.asset('assets/images/planet3.png').image,
                      ),
                      Text(
                        ' r/$subredditName ',
                        style: TextStyle(
                          fontSize: ScreenSizeHandler.bigger * 0.019,
                          fontWeight: FontWeight.w600,
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
              Tab(text: 'Comments'),
            ],
          ),
          if (_tabController.index == 0 || _tabController.index == 1)
            Padding(
              padding: EdgeInsets.only(
                  top: ScreenSizeHandler.screenHeight * 0.01,
                  left: ScreenSizeHandler.screenWidth * 0.02),
              child: Row(
                children: [
                  if (isSorted || isTimeSorted && _tabController.index == 0)
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isSorted = false;
                          isTimeSorted = false;
                          sortValue = "Most relevant";
                          sortTimeValue = "All time";
                          getSearchesFromBack();
                        });
                      },
                      child: Icon(
                        Icons.cancel_outlined,
                        size: ScreenSizeHandler.bigger * 0.025,
                        color: Colors.grey[400],
                      ),
                    ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: ScreenSizeHandler.screenWidth * 0.01),
                    child: RoundedButton(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return SortBottomSheet(
                              isPosts: _tabController.index == 0,
                              groupValueNotifierVal: sortValue,
                            );
                          },
                        ).then((value) {
                          if (value != null) {
                            setState(() {
                              isSorted = true;
                              sortValue = value;
                              getSearchesFromBack();
                            });
                          }
                        });
                      },
                      buttonHeightRatio: 0.045,
                      buttonWidthRatio:
                          (sortValue == "Most relevant" && isSorted)
                              ? 0.15
                              : sortValue == "Comment count"
                                  ? 0.16
                                  : 0.07,
                      child: Text(
                        isSorted ? sortValue : "Sort",
                        style: TextStyle(
                            fontSize: ScreenSizeHandler.bigger * 0.019,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                  if (_tabController.index == 0)
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: ScreenSizeHandler.screenWidth * 0.01),
                      child: RoundedButton(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (BuildContext context) {
                              return SortTimeBottomSheet(
                                groupValueNotifierVal: sortTimeValue,
                              );
                            },
                          ).then((value) {
                            if (value != null) {
                              setState(() {
                                isTimeSorted = true;
                                sortTimeValue = value;
                                sortAndFilterPosts(sortTimeValue);
                              });
                            }
                          });
                        },
                        buttonHeightRatio: 0.045,
                        buttonWidthRatio: isTimeSorted ? 0.12 : 0.07,
                        child: Text(
                          isTimeSorted ? sortTimeValue : "Time",
                          style: TextStyle(
                              fontSize: ScreenSizeHandler.bigger * 0.019,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          isLoading
              ? const Center(child: RedditLoadingIndicator())
              : Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      PostSearchScreen(
                        postSearchCards: searchedPosts,
                      ),
                      CommentsSearchScreen(
                        commentSearchCards: searchedComments,
                      ),
                    ],
                  ),
                ),
        ],
      ),
    );
  }
}
