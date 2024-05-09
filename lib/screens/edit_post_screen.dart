import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:reddit_bel_ham/components/subreddit_components/subreddit_ellipsis_bottom_sheet.dart';
import 'package:reddit_bel_ham/screens/new_message_screen.dart';

import '../components/general_components/insert_link_popup.dart';
import '../components/general_components/interactive_text.dart';
import '../components/general_components/reddit_loading_indicator.dart';
import '../constants.dart';
import '../utilities/screen_size_handler.dart';

class EditPostScreen extends StatefulWidget {
  const EditPostScreen({super.key});

  static const id = "edit_post_screen";

  @override
  State<EditPostScreen> createState() => _EditPostScreenState();
}

class _EditPostScreenState extends State<EditPostScreen> {
  TextEditingController messageController = TextEditingController();
  late String title;
  late String postId;
  late String content;

  FocusNode messageFocus = FocusNode();
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
    messageFocus.addListener(() {
      setState(() {});
    });
  }

  @override
  void didChangeDependencies() {
    Map<String, dynamic> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    title = args['title'];
    postId = args['postId'];
    content = args['content'];
    messageController.text = content;
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
        title: Text(
          "Edit Post",
          style: TextStyle(
            fontSize: ScreenSizeHandler.bigger * 0.025,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding:
                EdgeInsets.only(right: ScreenSizeHandler.screenWidth * 0.04),
            child: InteractiveText(
              text: "DONE",
              isUnderlined: true,
              fontSizeRatio: 0.0155,
              onTap: () async {
                if (messageController.text.isEmpty) {
                  showSnackBar("Please enter a message");
                } else {
                  //TODO: Edit Post
                  setState(() {
                    isLoading = true;
                  });
                  var response = await apiService.editPost(
                      {"postId": postId, "text": messageController.text});
                  setState(() {
                    isLoading = false;
                  });
                  if (response['message'] == "Post updated successfully") {
                    Navigator.pop(context);
                  } else {
                    showSnackBar(response['message']);
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
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          title,
                          style: TextStyle(
                              fontSize: ScreenSizeHandler.bigger * 0.022,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      NewMessageTextField(
                        hintText: "Message",
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
                child: GestureDetector(
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
                          messageController.text = messageController.text +
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
                    alignment: Alignment.centerLeft,
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
