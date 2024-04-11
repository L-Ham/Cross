// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import '../constants.dart';
import '../components/empty_dog.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../utilities/screen_size_handler.dart';
import 'package:reddit_bel_ham/components/blocked_accounts_components/blocked_acoount_tile.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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
  bool _isBlockedAccountsEmpty = false;
  String authToken =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjoiNjYwMDczMTU4NzBiMmY5OWQzZDNlZmFjIiwidHlwZSI6Im5vcm1hbCJ9LCJpYXQiOjE3MTI1MjYzODAsImV4cCI6NTAxNzEyNTI2MzgwfQ.UCh8pA6PaGGHCpEhxffFpj46iWpBtNSuVeOIad9NPiE';
  List<BlockedUser> blockedUsers = [];

  final TextEditingController _controller = TextEditingController();

  void printing() {
    print('Unblock button pressed');
  }

  void parseBlockedUsers(String responseBody) {
    final parsed = json.decode(responseBody);

    // Extract blockedUsers array from the parsed JSON
    final blockedUsersList = parsed['blockedUsers'] as List<dynamic>;

    // Convert each item in the blockedUsersList to BlockedUser object
    blockedUsers =
        blockedUsersList.map((json) => BlockedUser.fromJson(json)).toList();
  }

  Future<void> getAllBlockedUsers(String authToken) async {
    final url = Uri.parse('http://localhost:5000/user/getAllBlockedUsers');

    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization':
              'Bearer $authToken', // Include the authorization token here
        },
      );

      if (response.statusCode == 200) {
        // Successful GET request
        print('Response body: ${response.body}');
        parseBlockedUsers(response.body);
        // You can parse and handle the response data here
      } else {
        // Error handling
        print('Failed to get blocked users: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      // Exception handling
      print('Exception occurred while getting blocked users: $e');
    }
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
      });
    });
    getAllBlockedUsers(authToken);
    if (blockedUsers.isEmpty) {
      _isBlockedAccountsEmpty = true;
    }
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
                        fontSize: MediaQuery.of(context).size.height *
                            kPageSubtitleFontSizeHeightRatio,
                      ),
                    ),
                  ),
                )
            ],
          ),
          if (_isBlockedAccountsEmpty)
            EmptyDog()
          else
            SizedBox(
              height: ScreenSizeHandler.screenHeight * 0.035,
            ),
          Column(
            children: [
              if (_isTextFieldEmpty)
                for (BlockedUser blockedUser in blockedUsers)
                  BlockedAccountTile(
                    imagePath: 'assets/images/reddit_logo.png',
                    username: blockedUser.userName,
                    isAccountBlocked: true,
                  ),
            ],
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
