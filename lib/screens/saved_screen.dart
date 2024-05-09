import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:reddit_bel_ham/components/general_components/reddit_loading_indicator.dart';
import 'package:reddit_bel_ham/screens/comments_screen.dart';
import 'package:reddit_bel_ham/services/api_service.dart';
import '../constants.dart';
import '../components/empty_dog.dart';
import '../utilities/screen_size_handler.dart';
import 'package:reddit_bel_ham/utilities/token_decoder.dart';
import 'package:reddit_bel_ham/components/home_page_components/post_card.dart';

class SavedScreen extends StatefulWidget {
  const SavedScreen({Key? key}) : super(key: key);

  static const String id = 'saved_screen';

  @override
  _SavedScreenState createState() => _SavedScreenState();
}

class _SavedScreenState extends State<SavedScreen> {
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
    print(TokenDecoder.token);
    page = 1;
    print('ZZZZZ ABL HOME FEEED');
    getSavedFeed(TokenDecoder.username, page, 5);
    page++;
    print('ZZZZZ BA#D HOME FEEED');
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
            getSavedFeed(TokenDecoder.username, page, 2);
            page++;
            print(page);
            print("dddddddddddddddddddddddddddddddddddddddddddddddddddddddd");
          }
        });
      }
    }
  }

  Future<void> getSavedFeed(String sortType, int page, int limit) async {
    Map<String, dynamic> data = (await apiService.getSavedPosts(
            TokenDecoder.username, page.toString(), limit.toString())) ??
        {};
    if (data.containsKey('savedPosts')) {
      List<dynamic> jsonPosts = data['savedPosts'];
      setState(() {
        newPosts = jsonPosts.map((json) => Post.fromJson(json)).toList();
        if (page == 1) {
          feed = newPosts;
        } else {
          feed.addAll(newPosts);
        }
        isFeedCalled = true;
      });
      print("xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx");
      print(feed);
    } else {
      setState(() {
        isFeedFinished = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: kBackgroundColor,
        appBar: AppBar(
          backgroundColor: kAppBarColor,
          title: Text(
            'Saved',
            style: kPageTitleStyle.copyWith(
                fontSize: ScreenSizeHandler.bigger * kAppBarTitleFontSizeRatio),
          ),
          centerTitle: true,
          bottom: TabBar(
            labelColor: Colors.white,
            unselectedLabelColor: Colors.grey[600],
            indicatorColor: Colors.blue,
            labelStyle: TextStyle(
              fontSize: ScreenSizeHandler.bigger * 0.022,
              fontWeight: FontWeight.bold,
            ),
            tabs: [
              Tab(text: 'Posts'),
              Tab(text: 'Comments'),
            ],
          ),
        ),
        body: ModalProgressHUD(
          inAsyncCall: false,
          progressIndicator: RedditLoadingIndicator(),
          child: TabBarView(
            children: [
              SingleChildScrollView(
                controller: _scrollController,
                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: feed.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, CommentsScreen.id,
                            arguments: {"post": feed[index]});
                      },
                      child: PostCard(
                        post: feed[index],
                      ),
                    );
                  },
                ),
              ),
              EmptyDog(),
            ],
          ),
        ),
      ),
    );
  }
}