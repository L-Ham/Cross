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
  int page = 1;
  final ScrollController _scrollController = ScrollController();
  bool isFeedCalled = false;
  bool isFeedFinished = false;

  @override
  void initState() {
    super.initState();
    page = 1;
    getHistoryFeed(TokenDecoder.username, page, 5);
    page++;
    _scrollController.addListener(getNewPostsForFeed);
  }

  void getNewPostsForFeed() {
    double diff = _scrollController.position.maxScrollExtent -
        _scrollController.position.pixels;

    if (diff < 250 && diff > 200) {
      if (isFeedCalled) {
        setState(() {
          isFeedCalled = false;
          if (!isFeedFinished) {
            getHistoryFeed(TokenDecoder.username, page, 2);
            page++;
          }
        });
      }
    }
  }

  Future<void> getHistoryFeed(String sortType, int page, int limit) async {
    Map<String, dynamic> data = (await apiService.getUserHistory()) ?? {};
    if (data.containsKey('historyPosts')) {
      List<dynamic> jsonPosts = data['historyPosts'];
      setState(() {
        newPosts = jsonPosts.map((json) => Post.fromJson(json)).toList();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: EdgeInsets.only(left: ScreenSizeHandler.screenWidth * 0.21),
          child: Text("History",
              style: TextStyle(fontSize: ScreenSizeHandler.screenWidth * 0.05)),
        ),
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
                Text("Recent"),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: feed.length,
              itemBuilder: (context, index) {
                return PostCard(post: feed[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}
