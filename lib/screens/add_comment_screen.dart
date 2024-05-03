import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:reddit_bel_ham/components/add_post_components/add_post_text_field.dart';
import 'package:reddit_bel_ham/components/general_components/interactive_text.dart';
import 'package:reddit_bel_ham/components/general_components/rounded_button.dart';
import 'package:reddit_bel_ham/constants.dart';
import 'package:reddit_bel_ham/utilities/is_valid_url.dart';
import 'package:reddit_bel_ham/utilities/screen_size_handler.dart';

class AddCommentScreen extends StatefulWidget {
  const AddCommentScreen({super.key});

  static const id = "add_comment_screen";

  @override
  State<AddCommentScreen> createState() => _AddCommentScreenState();
}

class _AddCommentScreenState extends State<AddCommentScreen> {
  TextEditingController urlNameController = TextEditingController();
  TextEditingController urlLinkController = TextEditingController();
  TextEditingController commentController = TextEditingController();
  ValueNotifier<bool> isButtonEnabled = ValueNotifier<bool>(false);
  late String postTitle;
  late String postContent;
  late String postType;
  late bool isReply;
  String userName = "Gintoki1204";
  String postTime = "2h";
  String replyString =
      "Brother come ti India 70% of all goat college seats are reserved for peiple who didn't earn it";

  @override
  void didChangeDependencies() {
    final Map<String, dynamic> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    postTitle = args['postTitle']!;
    postContent = args['postContent']!;
    postType = args['postType']!;
    isReply = args['isReply']! as bool;

    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
    urlNameController.addListener(updateButtonState);
    urlLinkController.addListener(updateButtonState);
  }

  @override
  void dispose() {
    urlNameController.removeListener(updateButtonState);
    urlLinkController.removeListener(updateButtonState);
    super.dispose();
  }

  void updateButtonState() {
    isButtonEnabled.value =
        urlNameController.text.isNotEmpty && isValidUrl(urlLinkController.text);
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
            size: ScreenSizeHandler.screenHeight * kCancelAppbarIconSizeRatio,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          isReply ? "Reply" : "Add comment",
          style: TextStyle(
              fontSize: ScreenSizeHandler.smaller *
                  kAppBarTitleSmallerFontRatio *
                  1.2,
              fontWeight: FontWeight.w500),
        ),
        actions: [
          Padding(
            padding:
                EdgeInsets.only(right: ScreenSizeHandler.screenWidth * 0.04),
            child: InteractiveText(
              text: "Post",
              onTap: () {
                //TODO: ADD COMENT HERE
              },
            ),
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.only(
          top: ScreenSizeHandler.screenHeight * 0.015,
        ),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: ScreenSizeHandler.screenWidth * 0.04),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: isReply
                                ? Column(
                                    children: [
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          userName + " • " + postTime,
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontSize:
                                                ScreenSizeHandler.bigger * 0.015,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(top: ScreenSizeHandler.screenHeight*0.02),
                                        child: Text(
                                          replyString,
                                          style: TextStyle(
                                            fontSize:
                                                ScreenSizeHandler.bigger * 0.016,
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                : Text(postTitle),
                          ),
                          if (postType == "text")
                            GestureDetector(
                              onTap: () {
                                showModalBottomSheet(
                                  context: context,
                                  backgroundColor: Colors.transparent,
                                  builder: (BuildContext context) {
                                    return SingleChildScrollView(
                                      child: Container(
                                        height: null,
                                        width: ScreenSizeHandler.screenWidth,
                                        color: kFillingColor,
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: ScreenSizeHandler
                                                      .screenWidth *
                                                  0.04,
                                              vertical: ScreenSizeHandler
                                                      .screenHeight *
                                                  0.02),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'ORIGINAL POST',
                                                style: TextStyle(
                                                  color: Colors.grey,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize:
                                                      ScreenSizeHandler.bigger *
                                                          0.013,
                                                ),
                                              ),
                                              const Divider(
                                                color: Colors.grey,
                                                thickness: 0.1,
                                              ),
                                              Text(
                                                postContent,
                                                style: TextStyle(
                                                  fontSize:
                                                      ScreenSizeHandler.bigger *
                                                          0.016,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                              child: Icon(
                                Icons.keyboard_arrow_down,
                                color: Colors.grey,
                                size: ScreenSizeHandler.bigger * 0.04,
                              ),
                            ),
                        ],
                      ),
                      const Divider(
                        color: Colors.grey,
                        thickness: 0.25,
                      ),
                      AddPostTextField(
                        controller: commentController,
                        hintText: isReply ? "Your Reply" : "Your comment",
                        fontSizeRatio: 0.018,
                        maxLines: null,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const Divider(
              color: Colors.grey,
              thickness: 0.25,
            ),
            Padding(
              padding: EdgeInsets.only(
                  bottom: ScreenSizeHandler.screenHeight * 0.01),
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        left: ScreenSizeHandler.screenWidth * 0.04),
                    child: GestureDetector(
                      onTap: () {
                        final result = showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.zero, // Add this line
                              ),
                              backgroundColor: kBackgroundColor,
                              shadowColor: kBackgroundColor,
                              surfaceTintColor: kBackgroundColor,
                              title: Text(
                                'Insert a link',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: ScreenSizeHandler.bigger * 0.024,
                                ),
                              ),
                              content: Padding(
                                padding: EdgeInsets.only(
                                    top: ScreenSizeHandler.screenHeight * 0.01),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    TextFormField(
                                      controller: urlNameController,
                                      decoration: InputDecoration(
                                          hintText: 'Name',
                                          border: InputBorder.none,
                                          hintStyle: TextStyle(
                                              fontSize:
                                                  ScreenSizeHandler.bigger *
                                                      0.018)),
                                    ),
                                    TextFormField(
                                      controller: urlLinkController,
                                      decoration: InputDecoration(
                                          hintText: 'Link',
                                          border: InputBorder.none,
                                          hintStyle: TextStyle(
                                              fontSize:
                                                  ScreenSizeHandler.bigger *
                                                      0.018)),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: ScreenSizeHandler.screenHeight *
                                              0.02),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          RoundedButton(
                                            onTap: () {
                                              Navigator.of(context).pop();
                                              urlLinkController.clear();
                                              urlNameController.clear();
                                            },
                                            buttonWidthRatio: 0.14,
                                            buttonHeightRatio: 0.065,
                                            buttonColor: kBackgroundColor,
                                            child: const Text('Cancel'),
                                          ),
                                          ValueListenableBuilder<bool>(
                                            valueListenable: isButtonEnabled,
                                            builder: (BuildContext context,
                                                bool isEnabled, Widget? child) {
                                              return RoundedButton(
                                                onTap: () {
                                                  Navigator.pop(
                                                    context,
                                                    {
                                                      'name': urlNameController
                                                          .text,
                                                      'link': urlLinkController
                                                          .text,
                                                    },
                                                  );
                                                  urlLinkController.clear();
                                                  urlNameController.clear();
                                                },
                                                buttonWidthRatio: 0.14,
                                                buttonHeightRatio: 0.06,
                                                buttonColor: Colors.blue,
                                                child: Text(
                                                  'Insert',
                                                  style: TextStyle(
                                                    color: isEnabled
                                                        ? Colors.white
                                                        : Colors.white
                                                            .withOpacity(0.5),
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                        result.then(
                          (value) {
                            if (value != null) {
                              commentController.text = commentController.text +
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
                      child: Icon(
                        FontAwesomeIcons.link,
                        size: ScreenSizeHandler.bigger * 0.028,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
