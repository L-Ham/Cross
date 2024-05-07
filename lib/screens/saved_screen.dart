
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:reddit_bel_ham/components/general_components/reddit_loading_indicator.dart';
import '../constants.dart';
import '../components/empty_dog.dart';
import '../utilities/screen_size_handler.dart';
import 'package:reddit_bel_ham/services/api_service.dart';
import 'package:reddit_bel_ham/utilities/token_decoder.dart';

class SavedScreen extends StatefulWidget {
  const SavedScreen({Key? key}) : super(key: key);

  static const String id = 'saved_screen';

  @override
  _SavedScreenState createState() => _SavedScreenState();
}

class _SavedScreenState extends State<SavedScreen> {
  String authToken = TokenDecoder.token;

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
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    SizedBox(
                      height: ScreenSizeHandler.screenHeight * 0.5,
                      child: TabBarView(
                        children: [
                          EmptyDog(),
                          EmptyDog(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
