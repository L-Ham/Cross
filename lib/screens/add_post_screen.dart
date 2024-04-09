import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:reddit_bel_ham/components/general_components/custom_switch.dart';
import 'package:reddit_bel_ham/components/general_components/interactive_text.dart';
import 'package:reddit_bel_ham/components/settings_components/settings_tile.dart';
import 'package:reddit_bel_ham/components/settings_components/settings_tile_leading_icon.dart';
import 'package:reddit_bel_ham/constants.dart';
import 'package:reddit_bel_ham/utilities/is_valid_url.dart';
import 'package:reddit_bel_ham/utilities/screen_size_handler.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';
import '../components/add_post_components/add_post_tags_row.dart';
import '../components/add_post_components/add_post_text_field.dart';
import '../components/add_post_components/add_tags_bottom_sheet.dart';
import '../components/add_post_components/change_post_type_bottom_sheet.dart';
import '../components/add_post_components/icon_button_with_caption.dart';
import '../components/add_post_components/image_edit_viewer.dart';
import '../components/add_post_components/invalid_link_error.dart';
import '../components/add_post_components/poll_edit.dart';
import '../components/add_post_components/video_viewer.dart';
import '../components/general_components/rounded_button.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({
    Key? key,
  }) : super(key: key);

  static const String id = 'add_post_screen';

  @override
  _AddPostScreenState createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  bool isPostButtonActivated = false;
  bool isFromSubreddit = true;
  bool isLinkFieldVisible = false;
  FocusNode urlFocus = FocusNode();
  List<XFile> chosenImages = [];
  final ImagePicker _picker = ImagePicker();
  bool isLinkEnabled = true;
  bool isImageEnabled = true;
  bool isVideoEnabled = true;
  bool isPollEnabled = true;
  bool isLinkChosen = false;
  bool isImageChosen = false;
  bool isVideoChosen = false;
  bool isPollChosen = false;
  bool showLinkError = false;
  VideoPlayerController _controller =
      VideoPlayerController.asset("assets/images/avatarDaniel.png");
  String pollDays = "3 days";
  int numOfPollOptions = 2;
  List<TextEditingController>? controllers;
  bool isSpoiler = false;
  bool isBrandAffiliate = false;

  void addURL() {
    isLinkFieldVisible = true;
    isLinkChosen = true;
    setAllIcons(false);
    urlFocus.requestFocus();
  }

  void addImage() async {
    chosenImages = await _picker.pickMultiImage();
    if (chosenImages.isNotEmpty) {
      setState(() {
        isImageChosen = true;
        setAllIcons(false);
      });
    }
  }

  void pickVideo() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: FileType.video);
    if (result != null) {
      File file = File(result.files.single.path!);
      _controller = VideoPlayerController.file(file)
        ..initialize().then((_) {
          setState(() {
            isVideoChosen = true;
            setAllIcons(false);
          });
        });
    }
  }

  void addPoll() {
    setState(() {
      isPollChosen = true;
      setAllIcons(false);
    });
  }

  void setAllIcons(bool choice) {
    setState(() {
      isLinkEnabled = choice;
      isImageEnabled = choice;
      isVideoEnabled = choice;
      isPollEnabled = choice;
    });
  }

  bool areIconsEnabled() {
    return isLinkEnabled && isImageEnabled && isVideoEnabled && isPollEnabled;
  }

  bool isIconChosen() {
    return isLinkChosen || isImageChosen || isVideoChosen || isPollChosen;
  }

  void removeURL() {
    setState(() {
      showLinkError = false;
      isLinkFieldVisible = false;
      setAllIcons(true);
      isLinkChosen = false;
      urlFocus.unfocus();
    });
  }

  void removeImage() {
    setState(() {
      chosenImages.clear();
      isImageChosen = false;
      setAllIcons(true);
    });
  }

  void removeAllAttatchmens() {
    setState(() {
      removeImage();
      removeURL();
      removeVideo();
      removePoll();
    });
  }

  void removeVideo() {
    setState(() {
      isVideoChosen = false;
      _controller.pause();
      setAllIcons(true);
      debugPrint(isVideoChosen.toString());
    });
  }

  void removePoll() {
    setState(() {
      isPollChosen = false;
      setAllIcons(true);
      numOfPollOptions = 2;
      pollDays = "3 days";
      controllers?.clear();
    });
  }

  void updatePollOptions(
      int newNumOfPollOptions, List<TextEditingController> newList) {
    numOfPollOptions = newNumOfPollOptions;
    controllers = newList;
  }

  void updateNumOfDays(String newPollDays) {
    pollDays = newPollDays;
  }

  void updateXFileList(List<XFile> newList) {
    chosenImages = newList;
  }

  void setIsSpoilerCallback(bool newVal) {
    setState(() {
      isSpoiler = newVal;
    });
  }

  void setIsBrandAffiliateCallback(bool newVal) {
    setState(() {
      isBrandAffiliate = newVal;
    });
  }

  @override
  void initState() {
    super.initState();
    urlFocus.addListener(() {
      setState(() {});
    });
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
            size: ScreenSizeHandler.screenHeight * 0.04,
          ),
          onPressed: () {},
        ),
        actions: <Widget>[
          IconButton(
              onPressed: () {}, icon: const Icon(Icons.more_horiz_sharp)),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: ScreenSizeHandler.screenWidth * 0.02,
                vertical: ScreenSizeHandler.screenHeight * 0.013),
            child: RoundedButton(
              buttonHeightRatio: 0.05,
              buttonWidthRatio: 0.085,
              onTap: () {
                //TODO: CONTINUE
              },
              buttonColor:
                  isPostButtonActivated ? kSwitchOnColor : Colors.grey[900]!,
              child: Text(
                isFromSubreddit ? "Post" : "Next",
                style: TextStyle(
                  fontSize: ScreenSizeHandler.screenHeight * 0.019,
                  fontWeight: FontWeight.bold,
                  color:
                      isPostButtonActivated ? Colors.white : Colors.grey[700],
                ),
              ),
            ),
          )
        ],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: ScreenSizeHandler.screenHeight * 0.015,
                    horizontal: ScreenSizeHandler.screenHeight * 0.026,
                  ),
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(
                            bottom: ScreenSizeHandler.screenHeight * 0.01),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: ScreenSizeHandler.screenHeight * 0.013,
                              child: Image(
                                //TODO: Make the image dynamic
                                image:
                                    AssetImage('assets/images/reddit_logo.png'),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: ScreenSizeHandler.screenWidth * 0.045),
                              child: GestureDetector(
                                onTap: () {
                                  //TODO:SHOW POST TO
                                },
                                child: Row(
                                  children: [
                                    Text(
                                      "r/redditBelham",
                                      style: TextStyle(
                                          fontSize:
                                              ScreenSizeHandler.bigger * 0.022,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const Icon(Icons.arrow_drop_down_outlined),
                                  ],
                                ),
                              ),
                            ),
                            const Expanded(child: SizedBox()),
                            InteractiveText(
                              text: "RULES",
                              fontSizeRatio: 0.018,
                              onTap: () {
                                //TODO: show rules sheet
                              },
                              isUnderlined: true,
                            )
                          ],
                        ),
                      ),
                      AddPostTagsRow(
                          isSpoiler: isSpoiler,
                          isBrandAffiliate: isBrandAffiliate),
                      const AddPostTextField(
                        hintText: "Title",
                        fontSizeRatio: 0.032,
                        isTitle: true,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: RoundedButton(
                          onTap: () async {
                            final result = await showModalBottomSheet(
                              context: context,
                              builder: (BuildContext context) {
                                return AddTagsBottomSheet(
                                  isSpoiler: isSpoiler,
                                  isBrandAffiliate: isBrandAffiliate,
                                  setIsBrandAffiliate:
                                      setIsBrandAffiliateCallback,
                                  setIsSpoiler: setIsSpoilerCallback,
                                );
                              },
                            );
                            if (result != null) {
                              setState(() {
                                isSpoiler = result['isSpoiler']!;
                                isBrandAffiliate = result['isBrandAffiliate']!;
                              });
                            }
                          },
                          buttonColor: kFillingColor,
                          buttonHeightRatio: 0.038,
                          buttonWidthRatio: 0.17,
                          child: Text(
                            'Add tags (optional)',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: ScreenSizeHandler.bigger * 0.015,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                      Visibility(
                        visible: isLinkFieldVisible,
                        child: AddPostTextField(
                          focusNode: urlFocus,
                          hintText: "URL",
                          hasClearButton: true,
                          onClearTap: () {
                            setState(() {
                              removeURL();
                            });
                          },
                          onChanged: (p0) {
                            setState(() {
                              if (isValidUrl(p0) || p0.isEmpty) {
                                showLinkError = false;
                              } else {
                                showLinkError = true;
                              }
                            });
                          },
                        ),
                      ),
                      Visibility(
                        visible: showLinkError,
                        child: const InvalidLinkError(),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: ScreenSizeHandler.screenHeight * 0.01),
                        child: Visibility(
                          visible: isImageChosen,
                          child: ImageEditViewer(
                            initialChoices: chosenImages,
                            removeImage: () {
                              removeImage();
                            },
                            updateXFileList: (newList) {
                              updateXFileList(newList);
                            },
                          ),
                        ),
                      ),
                      Visibility(
                        visible: isVideoChosen,
                        child: VideoViewer(
                          removeVideo: removeVideo,
                          controller: _controller,
                        ),
                      ),
                      AddPostTextField(
                          hintText: "body text (optional)",
                          maxLines: isPollChosen ? 1 : 20),
                      Visibility(
                        visible: isPollChosen,
                        child: PollEdit(
                          removePoll: () {
                            removePoll();
                          },
                          updateNumOfDays: (newPollDays) {
                            updateNumOfDays(newPollDays);
                          },
                          updatePollOptions: (int newNumOfPollOptions,
                              List<TextEditingController> newList) {
                            updatePollOptions(newNumOfPollOptions, newList);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (MediaQuery.of(context).viewInsets.bottom == 0)
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: ScreenSizeHandler.bigger / 7,
                width: ScreenSizeHandler.screenWidth,
                color: kFillingColor,
                child: Padding(
                  padding: EdgeInsets.only(
                      top: ScreenSizeHandler.screenHeight * 0.01),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            bottom: ScreenSizeHandler.screenHeight * 0.028),
                        child: Text(
                          areIconsEnabled()
                              ? "What do you want to add?"
                              : 'You can only add one type of attachment for now.',
                          style: TextStyle(
                              fontSize: ScreenSizeHandler.bigger * .015,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: ScreenSizeHandler.screenWidth * 0.07),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButtonWithCaption(
                              icon: Icons.link,
                              caption: "Link",
                              onTap: () async {
                                if (!isIconChosen()) {
                                  setState(() {
                                    addURL();
                                  });
                                } else {
                                  final choice = await showModalBottomSheet(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return const ChangePostTypeBottomSheet();
                                    },
                                  );
                                  if (choice == "continue") {
                                    removeAllAttatchmens();
                                    addURL();
                                  }
                                }
                              },
                              isIconChosen: isLinkChosen,
                              isIconEnabled: areIconsEnabled(),
                            ),
                            IconButtonWithCaption(
                              icon: Icons.image,
                              caption: "Image",
                              onTap: () async {
                                if (!isIconChosen()) {
                                  addImage();
                                } else {
                                  final choice = await showModalBottomSheet(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return const ChangePostTypeBottomSheet();
                                    },
                                  );
                                  if (choice == "continue") {
                                    removeAllAttatchmens();
                                    addImage();
                                  }
                                }
                              },
                              isIconChosen: isImageChosen,
                              isIconEnabled: areIconsEnabled(),
                            ),
                            IconButtonWithCaption(
                              icon: Icons.play_arrow,
                              caption: "Video",
                              onTap: () async {
                                if (!isIconChosen()) {
                                  pickVideo();
                                } else {
                                  final choice = await showModalBottomSheet(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return const ChangePostTypeBottomSheet();
                                    },
                                  );
                                  if (choice == "continue") {
                                    removeAllAttatchmens();
                                    pickVideo();
                                  }
                                }
                              },
                              isIconChosen: isVideoChosen,
                              isIconEnabled: areIconsEnabled(),
                            ),
                            IconButtonWithCaption(
                              icon: Icons.poll_outlined,
                              caption: "Poll",
                              onTap: () async {
                                if (!isIconChosen()) {
                                  addPoll();
                                } else {
                                  final choice = await showModalBottomSheet(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return const ChangePostTypeBottomSheet();
                                    },
                                  );
                                  if (choice == "continue") {
                                    removeAllAttatchmens();
                                    addPoll();
                                  }
                                }
                              },
                              isIconChosen: isPollChosen,
                              isIconEnabled: areIconsEnabled(),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          if (MediaQuery.of(context).viewInsets.bottom != 0)
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                color: kFillingColor,
                height: ScreenSizeHandler.screenHeight * 0.05,
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        setState(() {
                          if (areIconsEnabled()) {
                            addURL();
                          }
                        });
                      },
                      icon: Icon(
                        Icons.link,
                        color:
                            areIconsEnabled() ? Colors.white : Colors.grey[700],
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        if (areIconsEnabled()) {
                          addImage();
                        }
                      },
                      icon: Icon(
                        Icons.photo_outlined,
                        color:
                            areIconsEnabled() ? Colors.white : Colors.grey[700],
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        if (areIconsEnabled()) pickVideo();
                      },
                      icon: Icon(
                        Icons.play_arrow,
                        color:
                            areIconsEnabled() ? Colors.white : Colors.grey[700],
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        if (areIconsEnabled()) addPoll();
                      },
                      icon: Icon(
                        Icons.poll_outlined,
                        color:
                            areIconsEnabled() ? Colors.white : Colors.grey[700],
                      ),
                    ),
                    const Expanded(child: SizedBox()),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          FocusScope.of(context).unfocus();
                        });
                      },
                      icon: const Icon(Icons.arrow_drop_down_outlined),
                    )
                  ],
                ),
              ),
            )
        ],
      ),
    );
  }

  @override
  void dispose() {
    urlFocus.dispose();
    super.dispose();
  }
}