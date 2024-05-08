import 'package:flutter/material.dart';
import 'package:reddit_bel_ham/utilities/screen_size_handler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../screens/home_page_seach_screen.dart';

import '../constants.dart';

class SubredditSearchScreen extends StatefulWidget {
  const SubredditSearchScreen({Key? key}) : super(key: key);

  static const String id = 'subreddit_search_screen';
  @override
  State<SubredditSearchScreen> createState() => _SubredditSearchScreenState();
}

class _SubredditSearchScreenState extends State<SubredditSearchScreen> {
  late FocusNode _focusNode;
  bool _isKeyboardVisible = false;
  bool _isTextFieldEmpty = true;

  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(() {
      setState(() {
        _isKeyboardVisible = _focusNode.hasFocus;
      });
    });
    _controller.addListener(() {
      setState(() {
        _isTextFieldEmpty = _controller.text.isEmpty;
      });
    });

    // Request focus for the text field when the page is first entered
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(_focusNode);
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Builder(
        builder: (context) {
          return CustomScrollView(
            slivers: [
              SliverAppBar(
                automaticallyImplyLeading: false,
                flexibleSpace: FlexibleSpaceBar(
                  background: Container(
                    color: Color.fromARGB(255, 121, 131, 139),
                  ),
                ),
                title: Row(
                  children: [
                    Expanded(
                      flex: _isKeyboardVisible ? 6 : 7,
                      child: Padding(
                        padding:
                            EdgeInsets.all(ScreenSizeHandler.bigger * 0.009),
                        child: Container(
                          height: ScreenSizeHandler.screenHeight * 0.04,
                          child: TextFormField(
                            key:
                                const Key('blocked_accounts_screen_text_field'),
                            controller: _controller,
                            focusNode: _focusNode,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(
                                top: ScreenSizeHandler.bigger * 0.01,
                              ),
                              filled: true,
                              fillColor: Color.fromARGB(130, 40, 40, 40),
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                              ),
                              prefixIcon: Padding(
                                padding: EdgeInsets.only(left: 8.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.search,
                                      size: ScreenSizeHandler.bigger * 0.03,
                                      color: Colors.grey[500],
                                    ),
                                    SizedBox(
                                      width:
                                          ScreenSizeHandler.screenWidth * 0.03,
                                    ),
                                    FaIcon(
                                      FontAwesomeIcons.file,
                                      size: ScreenSizeHandler.bigger * 0.03,
                                      color: Colors.white,
                                    ),
                                    Text(
                                      ' r/AskEngineers ',
                                      style: TextStyle(
                                        fontSize:
                                            ScreenSizeHandler.bigger * 0.019,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              hintStyle: TextStyle(
                                  color: kHintTextColor,
                                  fontSize: ScreenSizeHandler.bigger * 0.02,
                                  fontWeight: FontWeight.normal),
                              suffixIcon: IconButton(
                                key: const Key(
                                    'blocked_accounts_screen_text_field_clear_button'),
                                icon: FaIcon(
                                  FontAwesomeIcons.circleXmark,
                                  color: Colors.grey[500],
                                  size: ScreenSizeHandler.bigger * 0.02,
                                ),
                                onPressed: () {
                                  setState(() {
                                    if (_isTextFieldEmpty) {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                SearchScreen()),
                                      );
                                    } else {
                                      _controller.clear();
                                    }
                                  });
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    if (_isKeyboardVisible)
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            _focusNode.unfocus();
                            Navigator.pop(context);
                          },
                          child: Center(
                            child: Text(
                              "Cancel",
                              style: TextStyle(
                                color: Color.fromARGB(101, 255, 255, 255),
                                fontSize: ScreenSizeHandler.bigger * 0.017,
                              ),
                            ),
                          ),
                        ),
                      )
                  ],
                ),
              ),
              SliverToBoxAdapter(
                child: Container(
                  color: Color.fromARGB(130, 40, 40, 40),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: ScreenSizeHandler.screenHeight * 0.015,
                            horizontal: ScreenSizeHandler.screenWidth * 0.03),
                        child: Row(
                          children: [
                            Icon(
                              Icons.rocket_outlined,
                              size: ScreenSizeHandler.bigger * 0.04,
                            ),
                            Text(
                              ' Best of ',
                              style: TextStyle(
                                  fontSize: ScreenSizeHandler.bigger * 0.02),
                            ),
                            Text(
                              'r/AskEngineers',
                              style: TextStyle(
                                  fontSize: ScreenSizeHandler.bigger * 0.02,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: ScreenSizeHandler.screenHeight * 0.015,
                            horizontal: ScreenSizeHandler.screenWidth * 0.03),
                        child: Row(
                          children: [
                            Icon(
                              Icons.settings_outlined,
                              size: ScreenSizeHandler.bigger * 0.04,
                            ),
                            Text(
                              ' New in ',
                              style: TextStyle(
                                  fontSize: ScreenSizeHandler.bigger * 0.02),
                            ),
                            Text(
                              'r/AskEngineers',
                              style: TextStyle(
                                  fontSize: ScreenSizeHandler.bigger * 0.02,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
