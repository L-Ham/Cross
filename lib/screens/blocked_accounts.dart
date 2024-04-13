// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../constants.dart';
import '../components/empty_dog.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../utilities/screen_size_handler.dart';
import 'package:reddit_bel_ham/components/blocked_accounts_components/blocked_acoount_tile.dart';
import 'package:reddit_bel_ham/services/api_service.dart';
import 'package:reddit_bel_ham/utilities/token_decoder.dart';

class BlockedAccount extends StatefulWidget {
  const BlockedAccount({Key? key}) : super(key: key);

  static const String id = 'blocked_account_screen';

  @override
  _BlockedAccountState createState() => _BlockedAccountState();
}

class _BlockedAccountState extends State<BlockedAccount> {
  late FocusNode _focusNode;
  bool _isKeyboardVisible = false;
  bool _isTextFieldEmpty = true;
  bool _isBlockedAccountsEmpty = true;
  String authToken = TokenDecoder.token;
  List<BlockedUser> blockedUsers = [];
  List<SearchedUser> searchedUsers = [];

  final TextEditingController _controller = TextEditingController();

  void printing() {
    print('Unblock button pressed');
  }

  void parseBlockedUsers(responseBody) {
    final blockedUsersList = responseBody['blockedUsers'] as List<dynamic>;

    setState(() {
      blockedUsers =
          blockedUsersList.map((json) => BlockedUser.fromJson(json)).toList();
      if (blockedUsers.isEmpty) {
        _isBlockedAccountsEmpty = true;
      } else {
        _isBlockedAccountsEmpty = false;
      }
    });
  }

  void parseSearchedUsers(responseBody) {
    final searchedUsersList =
        responseBody['matchingUsernames'] as List<dynamic>;
    print(searchedUsersList);

    setState(() {
      searchedUsers =
          searchedUsersList.map((json) => SearchedUser.fromJson(json)).toList();
    });
    print(searchedUsers);
  }

  Future<void> getAllBlockedUsers(String authToken) async {
    ApiService apiService = ApiService(authToken);
    final response = await apiService.getAllBlockedUsers();
    print(response);
    if (response != null) parseBlockedUsers(response);
  }

  Future<void> getSearchedForUsers(String authToken) async {
    ApiService apiService = ApiService(authToken);
    final response =
        await apiService.getSearchedForBlockedUsers(_controller.text);
    print(_controller.text);
    print(response);
    if (response != null) parseSearchedUsers(response);
  }

  void _refreshScreen(bool isBlocked) {
    setState(() {
      getAllBlockedUsers(authToken);
    });
  }

  void _refreshSearchingScreen(bool isBlocked) {
    setState(() {
      _controller.clear();
      getAllBlockedUsers(authToken);
    });
  }

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
        if (!_isTextFieldEmpty) getSearchedForUsers(authToken);
      });
    });
    getAllBlockedUsers(authToken);
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
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: kBackgroundColor,
        title: Text(
          'Blocked Accounts',
          style: kPageTitleStyle.copyWith(
              fontSize: ScreenSizeHandler.bigger * kAppBarTitleFontSizeRatio),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: ScreenSizeHandler.screenHeight * 0.01,
          ),
          Row(
            children: [
              Expanded(
                flex: _isKeyboardVisible ? 6 : 7,
                child: Padding(
                  padding: EdgeInsets.all(ScreenSizeHandler.bigger * 0.009),
                  child: Container(
                    height: ScreenSizeHandler.screenHeight * 0.054,
                    child: TextFormField(
                      key: const Key('blocked_accounts_screen_text_field'),
                      controller: _controller,
                      focusNode: _focusNode,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(
                          top: ScreenSizeHandler.bigger * 0.01,
                        ),
                        filled: true,
                        fillColor: Color.fromARGB(74, 40, 40, 40),
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                        ),
                        prefixIcon: Icon(
                          Icons.search,
                          size: ScreenSizeHandler.bigger *
                              kSettingsLeadingIconRatio,
                          color: kHintTextColor,
                        ),
                        hintText: 'Block new account',
                        hintStyle: TextStyle(
                            color: kHintTextColor,
                            fontSize: ScreenSizeHandler.bigger * 0.02,
                            fontWeight: FontWeight.normal),
                        suffixIcon: _isTextFieldEmpty
                            ? null
                            : IconButton(
                                key: const Key(
                                    'blocked_accounts_screen_text_field_clear_button'),
                                icon: FaIcon(
                                  FontAwesomeIcons.circleXmark,
                                  color: kHintTextColor,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _controller.clear();
                                    _refreshScreen(false);
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
                    },
                    child: Text(
                      "Cancel",
                      style: TextStyle(
                        color: kHintTextColor,
                        fontSize: ScreenSizeHandler.bigger * 0.02,
                      ),
                    ),
                  ),
                )
            ],
          ),
          if (_isBlockedAccountsEmpty && _isTextFieldEmpty)
            SizedBox(
              height: ScreenSizeHandler.screenHeight * 0.25,
            ),
          if (_isBlockedAccountsEmpty && _isTextFieldEmpty)
            EmptyDog()
          else
            SizedBox(
              height: ScreenSizeHandler.screenHeight * 0.035,
            ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  if (_isTextFieldEmpty)
                    for (BlockedUser blockedUser in blockedUsers)
                      BlockedAccountTile(
                        imagePath: 'assets/images/reddit_logo.png',
                        username: blockedUser.userName,
                        isAccountBlocked: true,
                        onActionComplete: _refreshScreen,
                      )
                  else
                    for (SearchedUser searchedUser in searchedUsers)
                      BlockedAccountTile(
                        imagePath: 'assets/images/reddit_logo.png',
                        username: searchedUser.userName,
                        isAccountBlocked: searchedUser.isBlocked,
                        onActionComplete: _refreshSearchingScreen,
                      )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class BlockedUser {
  final String id;
  final String userName;
  final String? avatarImage;

  BlockedUser({
    required this.id,
    required this.userName,
    this.avatarImage,
  });

  factory BlockedUser.fromJson(Map<String, dynamic> json) {
    return BlockedUser(
      id: json['id'],
      userName: json['userName'],
      avatarImage: json['avatarImage'],
    );
  }
}

class SearchedUser {
  final String id;
  final String userName;
  final bool isBlocked;
  final String? avatarImage;

  SearchedUser({
    required this.id,
    required this.userName,
    required this.isBlocked,
    this.avatarImage,
  });

  factory SearchedUser.fromJson(Map<String, dynamic> json) {
    print('kkkkkkk');
    print(json);
    return SearchedUser(
      id: json['_id'] ?? '',
      userName: json['userName'] ?? '',
      isBlocked: json['isBlocked'] ?? false,
      avatarImage: json['avatarImage'] ?? '',
    );
  }
}
