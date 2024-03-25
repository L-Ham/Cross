// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import '../constants.dart';
import '../components/empty_dog.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../utilities/screen_size_handler.dart';

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
        title: Center(
          child: Text(
            'Blocked Accounts',
            style: kPageTitleStyle.copyWith(
                fontSize: ScreenSizeHandler.bigger * kAppBarTitleFontSizeRatio),
          ),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
          Row(
            children: [
              Expanded(
                flex: _isKeyboardVisible ? 6 : 7,
                child: Padding(
                  padding: EdgeInsets.all(
                      MediaQuery.of(context).size.height * 0.006),
                  child: Container(
                    height: 40,
                    child: TextFormField(
                      controller: _controller,
                      focusNode: _focusNode,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.01),
                        filled: true,
                        fillColor: Color.fromARGB(199, 35, 35, 35),
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
                            fontWeight: FontWeight.normal),
                        suffixIcon: _isTextFieldEmpty
                            ? null
                            : IconButton(
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
          if (_isBlockedAccountsEmpty) EmptyDog()
          else
          Column(
            children: [
              Row(
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: ,
                      )
                    ],
                  )
                ],
                
              )

            ],
          )
          
        ],
      ),
    );
  }
}
