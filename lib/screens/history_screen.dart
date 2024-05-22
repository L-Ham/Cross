import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:reddit_bel_ham/components/home_page_components/post_card.dart';
import 'package:reddit_bel_ham/services/api_service.dart';
import 'package:reddit_bel_ham/utilities/screen_size_handler.dart';
import 'package:reddit_bel_ham/utilities/token_decoder.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  static const String id = 'history_screen';

  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  String authToken = TokenDecoder.token;
  ApiService apiService = ApiService(TokenDecoder.token);
  List<Post> feed = [];
  List<Post> newPosts = [];
  List<Post> upFeed = [];
  List<Post> upNewPosts = [];
  List<Post> downFeed = [];
  List<Post> downNewPosts = [];
  int page = 1;
  int limit = 5;
  final ScrollController _scrollController = ScrollController();
  bool isFeedCalled = false;
  bool isFeedFinished = false;
  String selectedMenuItem = "Recent";

  @override
  void initState() {
    super.initState();
    page = 1;
    getHistoryFeed();
    _scrollController.addListener(getNewPostsForFeed);
  }

  int getFeedLength() {
    switch (selectedMenuItem) {
      case 'Recent':
        return feed.length;
      case 'Upvoted':
        return upFeed.length;
      case 'Downvoted':
        return downFeed.length;
      default:
        return feed.length;
    }
  }

  Post getFeedItem(int index) {
    switch (selectedMenuItem) {
      case 'Recent':
        return feed[index];
      case 'Upvoted':
        return upFeed[index];
      case 'Downvoted':
        return downFeed[index];
      default:
        return feed[index];
    }
  }

  final List<DropdownMenuItem<String>> dropdownItems = [
    DropdownMenuItem<String>(
      value: 'Recent',
      child: Row(
        children: [
          const Text('Recent'),
        ],
      ),
    ),
    DropdownMenuItem<String>(
      value: 'Upvoted',
      child: Row(
        children: [
          const Text('Upvoted'),
        ],
      ),
    ),
    DropdownMenuItem<String>(
      value: 'Downvoted',
      child: Row(
        children: [
          const Text('Downvoted'),
        ],
      ),
    )
  ];

  void getNewPostsForFeed() {
    double diff = _scrollController.position.maxScrollExtent -
        _scrollController.position.pixels;

    if (diff < 250 && diff > 200) {
      if (isFeedCalled) {
        setState(() {
          isFeedCalled = false;
          if (!isFeedFinished) {
            getHistoryFeed();
          }
        });
      }
    }
  }

  Future<void> getHistoryFeed() async {
    Map<String, dynamic> data = (await apiService.getUserHistory()) ?? {};
    if (data.containsKey('historyPosts')) {
      List<dynamic> jsonPosts = data['historyPosts'];
      setState(() {
        newPosts = jsonPosts
            .map((json) => Post.fromJson(json))
            .toList()
            .reversed
            .toList();
        if (page == 1) {
          feed = newPosts;
        } else {
          feed.addAll(newPosts);
        }
        isFeedCalled = true;
      });
    } else {
      setState(() {
        isFeedFinished = true;
      });
    }
  }

  void getFeed() async {
    switch (selectedMenuItem) {
      case 'Recent':
        Map<String, dynamic> response = await apiService.getUserHistory();
        if (response.containsKey('historyPosts')) {
          setState(() {
            feed = (response['historyPosts'] as List)
                .map((item) => Post.fromJson(item))
                .toList();
          });
          print(feed);
        }
        break;
      case 'Upvoted':
        Map<String, dynamic> response = await apiService.getUpvotedPosts(
            TokenDecoder.username.toString(),
            page.toString(),
            limit.toString());
        if (response.containsKey('upvotedPosts')) {
          setState(() {
            upFeed = (response['upvotedPosts'] as List)
                .map((item) => Post.fromJson(item))
                .toList();
          });
        }
        break;
      case 'Downvoted':
        Map<String, dynamic> response = await apiService.getDownVotedPosts(
            TokenDecoder.username.toString(),
            page.toString(),
            limit.toString());
        print(response);
        if (response.containsKey('downvotedPosts')) {
          setState(() {
            downFeed = (response['downvotedPosts'] as List)
                .map((item) => Post.fromJson(item))
                .toList();
          });
          print(downFeed); // Add this line
        }
        break;
      default:
        Map<String, dynamic> response = await apiService.getUserHistory();
        if (response.containsKey('historyPosts')) {
          feed = (response['historyPosts'] as List)
              .map((item) => Post.fromJson(item))
              .toList();
        }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
            padding:
                EdgeInsets.only(left: ScreenSizeHandler.screenWidth * 0.21),
            child: Text('History',
                style:
                    TextStyle(fontSize: ScreenSizeHandler.screenWidth * 0.05))),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(ScreenSizeHandler.screenWidth * 0.02),
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.all(ScreenSizeHandler.screenWidth * 0.02),
                  child: Icon(
                    Icons.history,
                    size: ScreenSizeHandler.screenWidth * 0.05,
                  ),
                ),
                SizedBox(width: 8.0),
                DropdownButtonHideUnderline(
                  child: DropdownButton2(
                      value: selectedMenuItem,
                      items: dropdownItems,
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedMenuItem = newValue!;
                          getFeed();
                        });
                      }),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: getFeedLength(),
              itemBuilder: (context, index) {
                return PostCard(post: getFeedItem(index));
              },
            ),
          ),
        ],
      ),
    );
  }
}
