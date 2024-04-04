import 'dart:io';
import 'package:flutter/material.dart';
import 'package:reddit_bel_ham/components/general_components/interactive_text.dart';
import 'package:reddit_bel_ham/constants.dart';
import 'package:reddit_bel_ham/utilities/is_valid_url.dart';
import 'package:reddit_bel_ham/utilities/screen_size_handler.dart';
import 'package:image_picker/image_picker.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';

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
  FocusNode titleFocus = FocusNode();
  FocusNode bodyFocus = FocusNode();
  FocusNode urlFocus = FocusNode();
  List<XFile> chosenImages = [];
  final ImagePicker _picker = ImagePicker();
  bool areIconsEnabled = true;
  bool isLinkChosen = false;
  bool isImageChosen = false;
  bool isVideoChosen = false;
  bool isPollChosen = false;
  bool showLinkError = false;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    titleFocus.addListener(() {
      setState(() {});
    });
    bodyFocus.addListener(() {
      setState(() {});
    });
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
              onPressed: () {
                //TODO: SHOW BOTTOM SHEET
              },
              icon: const Icon(Icons.more_horiz_sharp)),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: ScreenSizeHandler.screenWidth * 0.02,
                vertical: ScreenSizeHandler.screenHeight * 0.013),
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  isPostButtonActivated = !isPostButtonActivated;
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    isPostButtonActivated ? kSwitchOnColor : kSwitchOffColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: ScreenSizeHandler.smaller * 0.005),
                child: Text(
                  isFromSubreddit ? "Post" : "Next",
                  style: TextStyle(
                    fontSize: ScreenSizeHandler.screenHeight * 0.019,
                    fontWeight: FontWeight.bold,
                    color: isPostButtonActivated ? Colors.white : Colors.grey,
                  ),
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
                    horizontal: ScreenSizeHandler.screenHeight * 0.03,
                  ),
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: [
                          CircleAvatar(
                            radius: ScreenSizeHandler.screenHeight * 0.013,
                            child: Image(
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
                      Padding(
                        padding: EdgeInsets.only(
                            top: ScreenSizeHandler.screenHeight * 0.01),
                        child: AddPostTextField(
                          textFocus: titleFocus,
                          hintText: "Title",
                          fontSizeRatio: 0.035,
                          isTitle: true,
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: ElevatedButton(
                          onPressed: () {
                            //TODO: ADD TAGS BOTTOM SHEET
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: kFillingColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: const Text('Add tags (optional)'),
                        ),
                      ),
                      Visibility(
                        visible: isLinkFieldVisible,
                        child: AddPostTextField(
                          textFocus: urlFocus,
                          hintText: "URL",
                          hasClearButton: true,
                          onClearTap: () {
                            setState(() {
                              isLinkFieldVisible = false;
                              areIconsEnabled = true;
                              isLinkChosen = false;
                              urlFocus.unfocus();
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
                        child: Container(
                          decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                              color: kFillingColor),
                          width: double.infinity,
                          height: ScreenSizeHandler.screenHeight * 0.036,
                          child: Center(
                            child: Text(
                              "Oops, this link isn't valid. Double-check, and try again.",
                              style: TextStyle(
                                  fontSize: ScreenSizeHandler.bigger * 0.016),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: ScreenSizeHandler.screenHeight * 0.01),
                        child: Stack(
                          children: [
                            Visibility(
                              visible: isImageChosen,
                              child: CarouselSlider(
                                options: CarouselOptions(
                                  autoPlay: false,
                                  enableInfiniteScroll: false,
                                  aspectRatio: 1.0,
                                  viewportFraction: 1.0,
                                  onPageChanged: (index, reason) {
                                    setState(() {
                                      _currentIndex = index;
                                    });
                                  },
                                ),
                                items: chosenImages
                                    .map(
                                      (file) => Stack(
                                        children: [
                                          Center(
                                            child: Image.file(File(file.path),
                                                fit: BoxFit.cover,
                                                width: double.infinity),
                                          ),
                                        ],
                                      ),
                                    )
                                    .toList(),
                              ),
                            ),
                            Positioned(
                              right: 0,
                              child: IconButton(
                                icon: Icon(
                                  Icons.cancel,
                                  color: Colors.black.withOpacity(0.5),
                                  size: ScreenSizeHandler.smaller * 0.09,
                                ),
                                onPressed: () async {
                                  if (chosenImages.length == 1) {
                                    setState(() {
                                      chosenImages.clear();
                                      isImageChosen = false;
                                      areIconsEnabled = true;
                                    });
                                  } else {
                                    final option = await showModalBottomSheet(
                                      backgroundColor: Colors.transparent,
                                      context: context,
                                      builder: (BuildContext context) {
                                        return const ImageDeletionBottomSheet();
                                      },
                                    );
                                    if (option == "current") {
                                      setState(() {
                                        chosenImages.removeAt(_currentIndex);
                                      });
                                    } else if (option == "all") {
                                      setState(() {
                                        chosenImages.clear();
                                        isImageChosen = false;
                                        areIconsEnabled = true;
                                      });
                                    }
                                  }
                                },
                              ),
                            ),
                            Positioned(
                              right: ScreenSizeHandler.screenWidth * 0.03,
                              bottom: ScreenSizeHandler.screenHeight * 0.01,
                              child: GestureDetector(
                                onTap: () async {
                                  List<XFile>? moreImages =
                                      await _picker.pickMultiImage();
                                  setState(() {
                                    chosenImages.addAll(moreImages);
                                  });
                                },
                                child: Container(
                                  width: ScreenSizeHandler.bigger * 0.08,
                                  height: ScreenSizeHandler.bigger * 0.04,
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.5),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Icon(
                                        Icons.image,
                                        color: Colors.white,
                                        size: ScreenSizeHandler.smaller * 0.05,
                                      ),
                                      Text(
                                        "Add",
                                        style: TextStyle(
                                            fontSize: ScreenSizeHandler.bigger *
                                                0.015),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            if (chosenImages.length > 1)
                              Positioned(
                                bottom: ScreenSizeHandler.screenHeight * 0.01,
                                left: 0.0,
                                right: 0.0,
                                child: Center(
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          color: Colors.black.withOpacity(0.6),
                                        ),
                                        child: DotsIndicator(
                                          position: _currentIndex,
                                          dotsCount: chosenImages.length,
                                          mainAxisSize: MainAxisSize.min,
                                          decorator: DotsDecorator(
                                            size: Size.square(
                                                ScreenSizeHandler.bigger *
                                                    0.007), // Size of each dot
                                            activeSize: Size(
                                                ScreenSizeHandler.bigger *
                                                    0.007,
                                                ScreenSizeHandler.bigger *
                                                    0.007), // Size of active dot
                                            color: Colors.grey,
                                            activeColor: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                      AddPostTextField(
                          textFocus: bodyFocus,
                          hintText: "body text (optional)",
                          maxLines: 20),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (!bodyFocus.hasFocus && !titleFocus.hasFocus && !urlFocus.hasFocus)
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: ScreenSizeHandler.screenHeight / 7,
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
                          areIconsEnabled
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
                              onTap: () {
                                setState(() {
                                  isLinkFieldVisible = true;
                                  isLinkChosen = true;
                                  areIconsEnabled = false;
                                  urlFocus.requestFocus();
                                });
                              },
                              isIconChosen: isLinkChosen,
                              isIconEnabled: areIconsEnabled,
                            ),
                            IconButtonWithCaption(
                              icon: Icons.image,
                              caption: "Image",
                              onTap: () async {
                                //TODO: SHOW THE LINK FIELD
                                chosenImages = await _picker.pickMultiImage();
                                if (chosenImages.isNotEmpty) {
                                  setState(() {
                                    isImageChosen = true;
                                    areIconsEnabled = false;
                                  });
                                }
                              },
                              isIconChosen: isImageChosen,
                              isIconEnabled: areIconsEnabled,
                            ),
                            IconButtonWithCaption(
                              icon: Icons.play_arrow,
                              caption: "Video",
                              onTap: () {
                                //TODO: SHOW THE LINK FIELD
                              },
                              isIconChosen: isVideoChosen,
                              isIconEnabled: areIconsEnabled,
                            ),
                            IconButtonWithCaption(
                              icon: Icons.poll_outlined,
                              caption: "Poll",
                              onTap: () {
                                //TODO: SHOW THE LINK FIELD
                              },
                              isIconChosen: isPollChosen,
                              isIconEnabled: areIconsEnabled,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          if (bodyFocus.hasFocus || titleFocus.hasFocus || urlFocus.hasFocus)
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
                          isLinkFieldVisible = true;
                          isLinkChosen = true;
                          areIconsEnabled = false;
                          urlFocus.requestFocus();
                        });
                      },
                      icon: Icon(
                        Icons.link,
                        color:
                            areIconsEnabled ? Colors.white : Colors.grey[700],
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        //TODO: SHOW THE PHOTO FIELD
                      },
                      icon: Icon(
                        Icons.photo_outlined,
                        color:
                            areIconsEnabled ? Colors.white : Colors.grey[700],
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        //TODO: SHOW THE LINK FIELD
                      },
                      icon: Icon(
                        Icons.play_arrow,
                        color:
                            areIconsEnabled ? Colors.white : Colors.grey[700],
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        //TODO: SHOW THE PHOTO FIELD
                      },
                      icon: Icon(
                        Icons.poll_outlined,
                        color:
                            areIconsEnabled ? Colors.white : Colors.grey[700],
                      ),
                    ),
                    const Expanded(child: SizedBox()),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          titleFocus.unfocus();
                          bodyFocus.unfocus();
                          urlFocus.unfocus();
                        });
                      },
                      icon: Icon(Icons.arrow_drop_down_outlined),
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
    titleFocus.dispose();
    bodyFocus.dispose();
    urlFocus.dispose();
    super.dispose();
  }
}

class BottomSheetBigButton extends StatelessWidget {
  const BottomSheetBigButton(
      {super.key,
      required this.title,
      this.textColor = Colors.black,
      this.isBold = false,
      required this.onTap});

  final String title;
  final Color textColor;
  final bool isBold;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: kFillingColor,
        height: ScreenSizeHandler.screenHeight * 0.067,
        child: Center(
          child: Text(
            title,
            style: TextStyle(
                fontSize: ScreenSizeHandler.bigger * 0.023,
                color: textColor,
                fontWeight: isBold ? FontWeight.bold : FontWeight.w400),
          ),
        ),
      ),
    );
  }
}

class AddPostTextField extends StatelessWidget {
  const AddPostTextField({
    super.key,
    required this.textFocus,
    required this.hintText,
    this.fontSizeRatio = 0.02,
    this.maxLines = 1,
    this.isTitle = false,
    this.hasClearButton = false,
    this.onClearTap = defaultFunction,
    this.onChanged,
  });

  static void defaultFunction() {}

  final FocusNode textFocus;
  final String hintText;
  final double fontSizeRatio;
  final int maxLines;
  final bool isTitle;
  final bool hasClearButton;
  final Function() onClearTap;
  final Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      focusNode: textFocus,
      maxLines: null,
      minLines: maxLines,
      decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
              fontSize: ScreenSizeHandler.bigger * fontSizeRatio,
              fontWeight: isTitle ? FontWeight.bold : FontWeight.normal),
          border: InputBorder.none,
          suffixIcon: hasClearButton
              ? IconButtonWithCaption(
                  icon: Icons.clear,
                  onTap: onClearTap,
                  backgroundColor: kFillingColor,
                  iconRadiusRatio: 0.018,
                  isIconEnabled: true,
                )
              : null),
      onChanged: onChanged,
    );
  }
}

class IconButtonWithCaption extends StatelessWidget {
  const IconButtonWithCaption({
    required this.icon,
    this.backgroundColor = kBackgroundColor,
    this.caption = "",
    required this.onTap,
    this.iconRadiusRatio = 0.026,
    this.isIconEnabled = false,
    this.isIconChosen = false,
    super.key,
  });

  final IconData icon;
  final Color backgroundColor;
  final String caption;
  final Function() onTap;
  final double iconRadiusRatio;
  final bool isIconEnabled;
  final bool isIconChosen;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          CircleAvatar(
            radius: ScreenSizeHandler.screenHeight * iconRadiusRatio,
            backgroundColor: isIconChosen ? kSwitchOnColor : backgroundColor,
            child: Icon(
              icon,
              color: isIconChosen
                  ? Colors.white
                  : isIconEnabled
                      ? Colors.grey
                      : Colors.grey[700],
            ),
          ),
          Padding(
            padding:
                EdgeInsets.only(top: ScreenSizeHandler.screenHeight * 0.005),
            child: Text(
              caption,
              style: TextStyle(
                  fontSize: ScreenSizeHandler.bigger * 0.015,
                  color: isIconChosen
                      ? kSwitchOnColor
                      : isIconEnabled
                          ? Colors.grey
                          : Colors.grey[700],
                  fontWeight: FontWeight.w500),
            ),
          )
        ],
      ),
    );
  }
}

class ImageDeletionBottomSheet extends StatelessWidget {
  const ImageDeletionBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: ScreenSizeHandler.screenWidth * 0.05),
      child: Wrap(
        children: <Widget>[
          BottomSheetBigButton(
            title: "Delete current Image",
            textColor: Colors.red[400]!,
            onTap: () {
              Navigator.pop(context, "current");
            },
          ),
          Divider(
            height: 0,
            thickness: 1,
            color: Colors.grey[800],
          ),
          BottomSheetBigButton(
            title: "Delete all Images",
            textColor: Colors.red[400]!,
            onTap: () {
              Navigator.pop(context, "all");
            },
          ),
          Container(
            color: Colors.transparent,
            height: ScreenSizeHandler.screenHeight * 0.01,
          ),
          BottomSheetBigButton(
            title: "Cancel",
            textColor: Colors.blue,
            isBold: true,
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
