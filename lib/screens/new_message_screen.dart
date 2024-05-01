import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:reddit_bel_ham/components/general_components/interactive_text.dart';
import 'package:reddit_bel_ham/components/general_components/reddit_loading_indicator.dart';
import 'package:reddit_bel_ham/constants.dart';
import 'package:reddit_bel_ham/main.dart';
import 'package:reddit_bel_ham/services/api_service.dart';
import 'package:reddit_bel_ham/utilities/screen_size_handler.dart';
import 'package:reddit_bel_ham/utilities/token_decoder.dart';

import '../components/general_components/insert_link_popup.dart';

class NewMessageScreen extends StatefulWidget {
  const NewMessageScreen({super.key});

  static const id = "new_message_screen";

  @override
  State<NewMessageScreen> createState() => _NewMessageScreenState();
}

class _NewMessageScreenState extends State<NewMessageScreen> {
  TextEditingController userNameController = TextEditingController();
  TextEditingController subjectController = TextEditingController();
  TextEditingController messageController = TextEditingController();

  FocusNode userNameFocus = FocusNode();
  FocusNode subjectFocus = FocusNode();
  FocusNode messageFocus = FocusNode();

  bool isReply = false;
  bool isLoading = false;

  void showSnackBar(String snackBarText) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Center(child: Text(snackBarText)),
          backgroundColor: Colors.white,
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.only(
            left: ScreenSizeHandler.screenWidth * kButtonWidthRatio,
            right: ScreenSizeHandler.screenWidth * kButtonWidthRatio,
            bottom: ScreenSizeHandler.screenHeight * 0.05,
          ),
          duration: const Duration(seconds: 3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
        ),
      );
    });
  }

  @override
  void initState() {
    super.initState();

    userNameFocus.addListener(() {
      setState(() {});
    });

    subjectFocus.addListener(() {
      setState(() {});
    });

    messageFocus.addListener(() {
      setState(() {});
    });
  }

  @override
  void didChangeDependencies() {
    Map<String, dynamic> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    isReply = args["isReply"];
    if (isReply) {
      subjectController.text = args["subject"];
      userNameController.text = args["userName"];
      messageFocus.requestFocus();
    } else {
      userNameFocus.requestFocus();
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: kBackgroundColor,
        leading: IconButton(
          icon: Icon(
            Icons.clear_sharp,
            size: ScreenSizeHandler.bigger * 0.04,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          Padding(
            padding:
                EdgeInsets.only(right: ScreenSizeHandler.screenWidth * 0.04),
            child: InteractiveText(
              text: "SEND",
              isUnderlined: true,
              fontSizeRatio: 0.0155,
              onTap: () async {
                if (userNameController.text.isEmpty) {
                  showSnackBar("Please enter a username");
                } else if (subjectController.text.isEmpty) {
                  showSnackBar("Please enter a subject");
                } else if (messageController.text.isEmpty) {
                  showSnackBar("Please enter a message");
                } else {
                  Map<String, dynamic> args = {
                    "receiverName": userNameController.text,
                    "subject": subjectController.text,
                    "message": messageController.text,
                    "isSubreddit": false,
                  };
                  ApiService apiService = ApiService(TokenDecoder.token);
                  setState(() {
                    isLoading = true;
                  });
                  var response = await apiService.composeMessage(args);
                  setState(() {
                    isLoading = false;
                  });
                  if (response['message'] == "Message sent") {
                    if (mounted) {
                      Navigator.pop(context);
                    }
                  } else if (response['message'] == "Receiver not found") {
                    showSnackBar("Reciever not found");
                  }
                }
              },
            ),
          )
        ],
      ),
      body: ModalProgressHUD(
        color: Colors.black,
        opacity: 0.5,
        inAsyncCall: isLoading,
        progressIndicator: const RedditLoadingIndicator(),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: ScreenSizeHandler.screenWidth * 0.05),
                  child: Column(
                    children: [
                      Visibility(
                        visible: !isReply,
                        child: Column(
                          children: [
                            NewMessageTextField(
                              controller: userNameController,
                              focusNode: userNameFocus,
                              hasPrefix: true,
                              hintText: "username",
                              maxLines: 1,
                              maxLength: 20,
                            ),
                            Divider(
                                color: Colors.grey[800],
                                height: 0,
                                thickness: 0.25),
                            NewMessageTextField(
                              hintText: "Subject",
                              controller: subjectController,
                              focusNode: subjectFocus,
                            ),
                            Divider(
                                color: Colors.grey[800],
                                height: 0,
                                thickness: 0.25),
                          ],
                        ),
                      ),
                      NewMessageTextField(
                        hintText: isReply ? "Your message" : "Message",
                        minLines: 15,
                        controller: messageController,
                        focusNode: messageFocus,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Divider(color: Colors.grey[800], height: 0, thickness: 0.25),
            Center(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    vertical: ScreenSizeHandler.screenHeight * 0.014,
                    horizontal: ScreenSizeHandler.screenWidth * 0.04),
                child: userNameFocus.hasFocus || subjectFocus.hasFocus
                    ? InteractiveText(
                        text: "NEXT",
                        isUnderlined: true,
                        fontSizeRatio: 0.0155,
                        onTap: () {
                          if (userNameFocus.hasFocus) {
                            userNameFocus.unfocus();
                            subjectFocus.requestFocus();
                          } else {
                            subjectFocus.unfocus();
                            messageFocus.requestFocus();
                          }
                        },
                      )
                    : GestureDetector(
                        onTap: () {
                          final result = showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return const InsertLinkPopUp();
                            },
                          );
                          result.then(
                            (value) {
                              if (value != null) {
                                // ignore: prefer_interpolation_to_compose_strings
                                messageController.text =
                                    messageController.text +
                                        "[" +
                                        value['name'] +
                                        "]" +
                                        "(" +
                                        value['link'] +
                                        ")";
                              }
                            },
                          );
                        },
                        child: Align(
                          alignment:
                              isReply ? Alignment.centerLeft : Alignment.center,
                          child: Icon(
                            FontAwesomeIcons.link,
                            size: ScreenSizeHandler.bigger * 0.025,
                            color: Colors.grey,
                          ),
                        ),
                      ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class NewMessageTextField extends StatelessWidget {
  const NewMessageTextField({
    this.hasPrefix = false,
    required this.hintText,
    this.maxLength = 1000,
    this.maxLines = null,
    this.minLines = null,
    required this.controller,
    required this.focusNode,
    super.key,
  });

  final bool hasPrefix;
  final String hintText;
  final int maxLength;
  final int? maxLines;
  final int? minLines;
  final TextEditingController controller;
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (hasPrefix)
          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Text(
              "u/ ",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: ScreenSizeHandler.bigger * 0.018),
            ),
          ),
        Expanded(
          child: TextField(
            controller: controller,
            focusNode: focusNode,
            maxLines: maxLines,
            minLines: minLines,
            maxLength: maxLength,
            style: TextStyle(fontSize: ScreenSizeHandler.bigger * 0.018),
            cursorColor: const Color.fromARGB(255, 81, 109, 237),
            decoration: InputDecoration(
              counterText: "",
              hintText: hintText,
              hintStyle: TextStyle(
                  color: Colors.grey[600],
                  fontSize: ScreenSizeHandler.bigger * 0.018),
              border: InputBorder.none,
            ),
          ),
        ),
      ],
    );
  }
}
