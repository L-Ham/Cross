import 'package:flutter/material.dart';
import 'package:reddit_bel_ham/components/general_components/rounded_button.dart';
import 'package:reddit_bel_ham/components/searching_components/sort_bottom_sheet.dart';
import 'package:reddit_bel_ham/components/searching_components/sort_time_bottom_sheet.dart';
import 'package:reddit_bel_ham/screens/comments_search_screen.dart';
import 'package:reddit_bel_ham/screens/communities_search_screen.dart';
import 'package:reddit_bel_ham/screens/people_search_screen.dart';
import 'package:reddit_bel_ham/screens/post_search_screen.dart';
import 'package:reddit_bel_ham/services/api_service.dart';
import 'package:reddit_bel_ham/utilities/token_decoder.dart';
import '../components/general_components/reddit_loading_indicator.dart';
import '../constants.dart';
import '../utilities/screen_size_handler.dart';
import '../utilities/time_ago.dart';

class SearchingScreen extends StatefulWidget {
  const SearchingScreen({super.key});

  static const id = 'searching_screen';

  @override
  State<SearchingScreen> createState() => _SearchingScreenState();
}

class CommentSearchCard {
  final String commentId;
  final String postId;
  final String userId;
  final String subredditName;
  final String postCreationDate;
  final DateTime actualPostCreationDate;
  final String postTitle;
  final int postUpvotes;
  final int numberOfComments;
  final String userAvatarImage;
  final String commentCreationDate;
  final DateTime actualCommentCreationDate;
  final String commentText;
  final int commentUpvotes;
  final String subredditImage;
  final String userName;

  CommentSearchCard({
    required this.userId,
    required this.commentId,
    required this.postId,
    required this.subredditName,
    required this.postCreationDate,
    required this.postTitle,
    required this.postUpvotes,
    required this.numberOfComments,
    required this.userAvatarImage,
    required this.commentCreationDate,
    required this.commentText,
    required this.commentUpvotes,
    required this.actualPostCreationDate,
    required this.actualCommentCreationDate,
    required this.subredditImage,
    required this.userName,
  });
}

class PostSearchCard {
  final String postId;
  final String title;
  final String text;
  final String type;
  final String image;
  final String video;
  final String subredditName;
  final String subredditId;
  final String avatarImageSubreddit;
  final String userName;
  final String userAvatarImage;
  final DateTime createdAt;
  final int score;
  final int commentCount;
  final String displayDate;

  PostSearchCard(
      {required this.postId,
      required this.title,
      required this.text,
      required this.type,
      required this.image,
      required this.video,
      required this.subredditName,
      required this.subredditId,
      required this.avatarImageSubreddit,
      required this.createdAt,
      required this.score,
      required this.commentCount,
      required this.displayDate,
      required this.userAvatarImage,
      required this.userName});
}

TextEditingController _searchController = TextEditingController();

class _SearchingScreenState extends State<SearchingScreen>
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

  ApiService apiService = ApiService(TokenDecoder.token);

  void getSearchesFromBack() async {
    setState(() {
      isLoading = true;
    });
    Map<String, dynamic> results =
        await apiService.searchSubredditByName(_searchController.text);
    List<dynamic> resultsList = results['matchingNames'];
    searchSubreddit(resultsList);
    Map<String, dynamic> commentsResponse = await apiService.searchComments({
      "search": _searchController.text,
      "relevance":
          sortValue == "Most relevant" ? true.toString() : false.toString(),
      "top": sortValue == "Top" ? true.toString() : false.toString(),
      "new": sortValue == "New" ? true.toString() : false.toString(),
    });
    searchComments(commentsResponse['comments'] as List<dynamic>);
    Map<String, dynamic> response =
        await apiService.getSearchedForBlockedUsers(_searchController.text);
    Map<String, dynamic> postsResponse = await apiService.searchPosts({
      "search": _searchController.text,
      "relevance":
          sortValue == "Most relevant" ? true.toString() : false.toString(),
      "top": sortValue == "Top" ? true.toString() : false.toString(),
      "new": sortValue == "New" ? true.toString() : false.toString(),
      "mediaOnly": false.toString(),
      "isNSFW": true.toString(),
    });
    print("pppppppppppppppppppppp");
    print(sortValue == "New");
    searchPosts(postsResponse['posts'] as List<dynamic>);
    searchPeople(response['matchingUsernames'] as List<dynamic>);
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
        image: resultsList[i]["image"]?? "",
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

  void searchPeople(List<dynamic> resultsList) {
    userNames.clear();
    userAvatarImages.clear();
    for (int i = 0; i < resultsList.length; i++) {
      mounted
          ? setState(() {
              if (resultsList[i]["avatarImage"] != null) {
                userAvatarImages.add(resultsList[i]["avatarImageUrl"]);
              } else {
                userAvatarImages.add('assets/images/redditAvata2.png');
              }
              // userAvatarImages.add('assets/images/redditAvata2.png');
              userNames.add(resultsList[i]["userName"]);
            })
          : null;
    }
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
  }

  @override
  void initState() {
    _tabController = TabController(length: 4, vsync: this);
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
      _searchController.text =
          ModalRoute.of(context)!.settings.arguments as String;
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
          if (_tabController.index == 0 || _tabController.index == 2)
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
                      CommunitiesSearchScreen(
                        subredditAvatarImages: subredditAvatarImages,
                        subredditMembers: subredditMembers,
                        subredditNames: subredditNames,
                      ),
                      CommentsSearchScreen(
                        commentSearchCards: searchedComments,
                      ),
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
