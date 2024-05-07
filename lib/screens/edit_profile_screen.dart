import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:reddit_bel_ham/components/general_components/rounded_button.dart';
import 'package:reddit_bel_ham/constants.dart';
import 'package:reddit_bel_ham/utilities/screen_size_handler.dart';
import '../components/create_community_components/community_name_text_box.dart';
import '../components/general_components/custom_switch.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});
  static const String id = 'edit_profile_screen';

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _picker = ImagePicker();
  XFile? chosenImage;
  XFile? chosenCoverImage;
  List<String> socialLinks = [];

  addUsernameLink(Widget child, String app) {
    bool isTextEmpty = true;
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        elevation: 0,
        builder: (BuildContext context) {
          return Container(
            height: 520,
            color: kBackgroundColor,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.arrow_back),
                        color: Colors.blue,
                      ),
                      Text(
                        'Add social link',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: kButtonSmallerFontRatio *
                                ScreenSizeHandler.smaller *
                                1.2),
                      ),
                      IconButton(
                        onPressed: () {
                          if (!isTextEmpty) {
                            setState(() {
                            socialLinks.add(app);
                            });
                            Navigator.pop(context);
                          }
                        },
                        icon: Icon(Icons.check),
                        color: isTextEmpty ? kFillingColor : Colors.blue,
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: child,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        isTextEmpty = value.isEmpty;
                      });
                    },
                    decoration: InputDecoration(
                      labelText: 'Username',
                      labelStyle: TextStyle(color: kHintTextColor),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: Colors.white, width: 2),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }

  addWebsiteLink(Widget child) {
    bool isText1Empty = true;
    bool isText2Empty = true;
    String url = '';
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        elevation: 0,
        builder: (BuildContext context) {
          return Container(
            color: kBackgroundColor,
            height: 620,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.arrow_back),
                        color: Colors.blue,
                      ),
                      Text(
                        'Add social link',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: kButtonSmallerFontRatio *
                                ScreenSizeHandler.smaller *
                                1.2),
                      ),
                      IconButton(
                        onPressed: () {
                          if (!isText1Empty && !isText2Empty) {
                            setState(() {
                            socialLinks.add(url);
                            });
                            Navigator.pop(context);
                          }
                        },
                        icon: Icon(Icons.check),
                        color: (isText1Empty || isText2Empty)
                            ? kFillingColor
                            : Colors.blue,
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: child,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    // controller: TextEditingController(),
                    onChanged: (value) {
                      setState(() {
                        isText1Empty = value.isEmpty;
                        url = value;
                      });
                    },
                    decoration: InputDecoration(
                      labelText: 'Display text',
                      labelStyle: TextStyle(color: kHintTextColor),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: Colors.white, width: 2),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    // controller: TextEditingController(),
                    onChanged: (value) {
                      setState(() {
                        isText2Empty = value.isEmpty;
                      });
                    },
                    decoration: InputDecoration(
                      labelText: 'https://website.com',
                      labelStyle: TextStyle(color: kHintTextColor),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: Colors.white, width: 2),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }

  addRedditLink(Widget child) {
    bool isTextEmpty = true;
    bool isTextValid = false;
    String url = '';
    showModalBottomSheet(
        context: context,
        elevation: 0,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return Container(
            color: kBackgroundColor,
            height: 520,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.arrow_back),
                        color: Colors.blue,
                      ),
                      Text(
                        'Add social link',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: kButtonSmallerFontRatio *
                                ScreenSizeHandler.smaller *
                                1.2),
                      ),
                      IconButton(
                        onPressed: () {
                          if (!isTextEmpty && isTextValid) {
                            setState(() {
                            socialLinks.add(url);
                            });
                            Navigator.pop(context);
                          }
                        },
                        icon: Icon(Icons.check),
                        color: isTextEmpty || !isTextValid
                            ? kFillingColor
                            : Colors.blue,
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: child,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        isTextEmpty = value.isEmpty;
                        isTextValid =
                            value.startsWith('r/') || value.startsWith('u/');
                        url = value;
                      });
                    },
                    decoration: InputDecoration(
                      labelText: 'r/Community, u/Username',
                      labelStyle: TextStyle(color: kHintTextColor),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: Colors.white, width: 2),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }

  void addImage() async {
    chosenImage = await _picker.pickImage(source: ImageSource.gallery);
    if (chosenImage != null) {
      setState(() {
        chosenImage = chosenImage;
      });
    }
  }

  void addCoverImage() async {
    chosenCoverImage = await _picker.pickImage(source: ImageSource.gallery);
    if (chosenCoverImage != null) {
      setState(() {
        chosenCoverImage = chosenCoverImage;
      });
    }
  }

  TextEditingController displayNameController = TextEditingController();
  bool isContentVisibilitySwitched = false;
  bool isShowActiveCommunitiesSwitched = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          ElevatedButton(
            onPressed: () {},
            child: Text(
              'Save',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 250,
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        child: chosenCoverImage != null
                            ? Image.file(File(chosenCoverImage!.path),
                                height: 200,
                                width: double.infinity,
                                fit: BoxFit.cover)
                            : Image.asset(
                                'assets/images/david_nayem.png',
                                height: 200,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              )),
                  ),
                  Positioned(
                    top: 10,
                    left: 350,
                    child: CircleAvatar(
                      backgroundColor: kFillingColor,
                      radius: 18,
                      child: IconButton(
                        icon: Icon(Icons.edit_outlined, size: 18),
                        onPressed: () {
                          addCoverImage();
                        },
                      ),
                    ),
                  ),
                  Positioned(
                    top: 140,
                    left: 155,
                    child: chosenImage != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(80),
                            child: Image(
                                image: FileImage(File(chosenImage!.path)),
                                height: 100,
                                width: 100,
                                fit: BoxFit.cover))
                        : Image.asset(
                            'assets/images/elham_final_logo.png',
                            height: 100,
                            width: 100,
                            fit: BoxFit.cover,
                          ),
                  ),
                  Positioned(
                    top: 210,
                    left: 210,
                    child: CircleAvatar(
                      backgroundColor: kFillingColor,
                      radius: 18,
                      child: IconButton(
                        icon: Icon(Icons.edit_outlined, size: 18),
                        onPressed: () {
                          addImage();
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      maxLength: 30,
                      maxLengthEnforcement: MaxLengthEnforcement.enforced,
                      decoration: InputDecoration(
                        labelText: 'Display name - optional',
                        labelStyle: TextStyle(color: kHintTextColor),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: Colors.white, width: 2),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 16,
                    top: 75,
                    child: Text(
                      'This will be displayed to viewers of your profile page \nand does not change your username.',
                      style: TextStyle(
                          color: kHintTextColor,
                          fontSize: kAcknowledgeTextSmallerFontRatio *
                              ScreenSizeHandler.smaller),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                maxLength: 200,
                maxLines: 8,
                maxLengthEnforcement: MaxLengthEnforcement.enforced,
                decoration: InputDecoration(
                  labelText: 'About you - optional',
                  labelStyle: TextStyle(
                    color: kHintTextColor,
                  ),
                  alignLabelWithHint: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: Colors.white, width: 2),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Social Links (5 max)',
                style: TextStyle(
                    color: Colors.white,
                    fontSize:
                        kButtonSmallerFontRatio * ScreenSizeHandler.smaller,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'People who visit your Reddit-byLham profile will see your social links.',
                style: TextStyle(
                    color: kHintTextColor,
                    fontSize: kAcknowledgeTextSmallerFontRatio *
                        ScreenSizeHandler.smaller),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return Container(
                              height: 300,
                              color: kBackgroundColor,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 16.0),
                                      child: Row(
                                        children: [
                                          IconButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            icon: Icon(Icons.close),
                                            color: Colors.blue,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 90.0),
                                            child: Text(
                                              'Add social link',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize:
                                                      kButtonSmallerFontRatio *
                                                          ScreenSizeHandler
                                                              .smaller *
                                                          1.2),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: RoundedButton(
                                            onTap: () {
                                              addRedditLink(
                                                Row(
                                                  children: [
                                                    Icon(Icons.reddit,
                                                        color:
                                                            Colors.deepOrange,
                                                        size: 18),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 8.0),
                                                      child: Text(
                                                        'Reddit',
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 13),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            },
                                            buttonHeightRatio: 0.05,
                                            buttonWidthRatio: 0.1,
                                            child: const Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Icon(Icons.reddit,
                                                    color: Colors.deepOrange,
                                                    size: 18),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 8.0),
                                                  child: Text(
                                                    'Reddit',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 13),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: RoundedButton(
                                            onTap: () {
                                              addUsernameLink(
                                                  Row(
                                                    children: [
                                                      Icon(
                                                          FontAwesomeIcons
                                                              .paypal,
                                                          color: Colors.blue,
                                                          size: 18),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                left: 8.0),
                                                        child: Text(
                                                          'PayPal',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 13),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  'www.paypal.com/');
                                            },
                                            buttonHeightRatio: 0.05,
                                            buttonWidthRatio: 0.12,
                                            child: const Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Icon(FontAwesomeIcons.paypal,
                                                    color: Colors.blue,
                                                    size: 18),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 8.0),
                                                  child: Text(
                                                    'PayPal',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 13),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: RoundedButton(
                                            onTap: () {
                                              addWebsiteLink(
                                                Row(
                                                  children: [
                                                    Icon(
                                                        FontAwesomeIcons
                                                            .discord,
                                                        color: Colors.blue,
                                                        size: 18),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 8.0),
                                                      child: Text(
                                                        'Discord',
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 13),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            },
                                            buttonHeightRatio: 0.05,
                                            buttonWidthRatio: 0.12,
                                            child: const Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Icon(FontAwesomeIcons.discord,
                                                    color: Colors.blue,
                                                    size: 18),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 8.0),
                                                  child: Text(
                                                    'Discord',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 13),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: RoundedButton(
                                            onTap: () {
                                              addWebsiteLink(
                                                Row(
                                                  children: [
                                                    Icon(
                                                        FontAwesomeIcons
                                                            .facebook,
                                                        color: Colors.blue,
                                                        size: 18),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 8.0),
                                                      child: Text(
                                                        'Facebook',
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 13),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            },
                                            buttonHeightRatio: 0.05,
                                            buttonWidthRatio: 0.13,
                                            child: const Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Icon(Icons.facebook,
                                                    color: Colors.blue,
                                                    size: 18),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 8.0),
                                                  child: Text(
                                                    'Facebook',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 13),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: RoundedButton(
                                            onTap: () {
                                              addUsernameLink(
                                                  Row(
                                                    children: [
                                                      Icon(
                                                          FontAwesomeIcons
                                                              .instagram,
                                                          color: Colors.purple,
                                                          size: 18),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                left: 8.0),
                                                        child: Text(
                                                          'Instagram',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 13),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  'www.instagram.com/');
                                            },
                                            buttonHeightRatio: 0.05,
                                            buttonWidthRatio: 0.13,
                                            child: const Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Icon(FontAwesomeIcons.instagram,
                                                    color: Colors.purple,
                                                    size: 18),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 8.0),
                                                  child: Text(
                                                    'Instagram',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 13),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: RoundedButton(
                                            onTap: () {
                                              addUsernameLink(
                                                  Row(
                                                    children: [
                                                      Icon(
                                                          FontAwesomeIcons
                                                              .tiktok,
                                                          color: Colors.white,
                                                          size: 18),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                left: 8.0),
                                                        child: Text(
                                                          'Tiktok',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 13),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  'www.tiktok.com/@');
                                            },
                                            buttonHeightRatio: 0.05,
                                            buttonWidthRatio: 0.11,
                                            child: const Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Icon(FontAwesomeIcons.tiktok,
                                                    color: Colors.white,
                                                    size: 18),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 8.0),
                                                  child: Text(
                                                    'Tiktok',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 13),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: RoundedButton(
                                            onTap: () {
                                              addUsernameLink(
                                                  Row(
                                                    children: [
                                                      Icon(
                                                          FontAwesomeIcons
                                                              .twitter,
                                                          color: Colors.blue,
                                                          size: 18),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                left: 8.0),
                                                        child: Text(
                                                          'Twitter',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 13),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  'www.twitter.com/');
                                            },
                                            buttonHeightRatio: 0.05,
                                            buttonWidthRatio: 0.1,
                                            child: const Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Icon(FontAwesomeIcons.twitter,
                                                    color: Colors.blue,
                                                    size: 18),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 8.0),
                                                  child: Text(
                                                    'Twitter',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 13),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: RoundedButton(
                                            onTap: () {
                                              addUsernameLink(
                                                  Row(
                                                    children: [
                                                      Icon(
                                                          FontAwesomeIcons
                                                              .soundcloud,
                                                          color:
                                                              Colors.deepOrange,
                                                          size: 18),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                left: 8.0),
                                                        child: Text(
                                                          'Soundcloud',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 13),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  'www.soundcloud.com/');
                                            },
                                            buttonHeightRatio: 0.05,
                                            buttonWidthRatio: 0.14,
                                            child: const Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Icon(
                                                    FontAwesomeIcons.soundcloud,
                                                    color: Colors.deepOrange,
                                                    size: 18),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 8.0),
                                                  child: Text(
                                                    'Soundcloud',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 13),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: RoundedButton(
                                            onTap: () {
                                              addUsernameLink(
                                                  Row(
                                                    children: [
                                                      Icon(
                                                          FontAwesomeIcons
                                                              .paypal,
                                                          color: Colors.purple,
                                                          size: 18),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                left: 8.0),
                                                        child: Text(
                                                          'Twitch',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 13),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  'www.twitch.tv/');
                                            },
                                            buttonHeightRatio: 0.05,
                                            buttonWidthRatio: 0.12,
                                            child: const Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Icon(FontAwesomeIcons.twitch,
                                                    color: Colors.purple,
                                                    size: 18),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 8.0),
                                                  child: Text(
                                                    'Twitch',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 13),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: RoundedButton(
                                            onTap: () {
                                              addWebsiteLink(
                                                Row(
                                                  children: [
                                                    Icon(
                                                        FontAwesomeIcons
                                                            .youtube,
                                                        color: Colors.red,
                                                        size: 18),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 8.0),
                                                      child: Text(
                                                        'Youtube',
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 13),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            },
                                            buttonHeightRatio: 0.05,
                                            buttonWidthRatio: 0.12,
                                            child: const Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Icon(FontAwesomeIcons.youtube,
                                                    color: Colors.red,
                                                    size: 18),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 8.0),
                                                  child: Text(
                                                    'Youtube',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 13),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: RoundedButton(
                                            onTap: () {
                                              addWebsiteLink(
                                                Row(
                                                  children: [
                                                    Icon(
                                                        FontAwesomeIcons
                                                            .spotify,
                                                        color: Colors.green,
                                                        size: 18),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 8.0),
                                                      child: Text(
                                                        'Spotify',
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 13),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            },
                                            buttonHeightRatio: 0.05,
                                            buttonWidthRatio: 0.12,
                                            child: const Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Icon(FontAwesomeIcons.spotify,
                                                    color: Colors.green,
                                                    size: 18),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 8.0),
                                                  child: Text(
                                                    'Spotify',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 13),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: RoundedButton(
                                            onTap: () {
                                              addWebsiteLink(
                                                Row(
                                                  children: [
                                                    Icon(FontAwesomeIcons.link,
                                                        color: Colors.black,
                                                        size: 18),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 8.0),
                                                      child: Text(
                                                        'Custom',
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 13),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            },
                                            buttonHeightRatio: 0.05,
                                            buttonWidthRatio: 0.12,
                                            child: const Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Icon(FontAwesomeIcons.link,
                                                    color: Colors.black,
                                                    size: 18),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 8.0),
                                                  child: Text(
                                                    'Custom',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 13),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          });
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.add, color: Colors.white),
                        Text('Add social link',
                            style:
                                TextStyle(color: Colors.white, fontSize: 13)),
                      ],
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kBackgroundColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100.0),
                      ),
                    ),
                  ),
                  if (socialLinks.isNotEmpty)
                    ElevatedButton(onPressed: (){},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: kBackgroundColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100.0),
                        ),
                      )

                    , child: Row(
                      children: [
                        Text(socialLinks[0], style: TextStyle(
                          color: Colors.white,
                          fontSize: 13
                        ),),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              socialLinks.removeAt(0);
                            });
                          },
                          icon: Icon(Icons.close, color: Colors.white, size:20),
                        ),
                      ]
                    )
                    )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16, right: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          'Content Visibility',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: kButtonSmallerFontRatio *
                                  ScreenSizeHandler.smaller,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          'All posts to this profile will appear in r/all \nand your profile can be discovered in /users.',
                          style: TextStyle(
                              color: kHintTextColor,
                              fontSize: kAcknowledgeTextSmallerFontRatio *
                                  ScreenSizeHandler.smaller),
                        ),
                      ),
                    ],
                  ),
                  CustomSwitch(
                      isSwitched: isContentVisibilitySwitched,
                      onChanged: (value) {
                        setState(() {
                          isContentVisibilitySwitched =
                              !isContentVisibilitySwitched;
                        });
                      }),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16, right: 8.0, bottom: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          'Show active communities',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: kButtonSmallerFontRatio *
                                  ScreenSizeHandler.smaller,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          'Decide wether to show the communities \nyou are active in on your profile.',
                          style: TextStyle(
                              color: kHintTextColor,
                              fontSize: kAcknowledgeTextSmallerFontRatio *
                                  ScreenSizeHandler.smaller),
                        ),
                      ),
                    ],
                  ),
                  CustomSwitch(
                      isSwitched: isShowActiveCommunitiesSwitched,
                      onChanged: (value) {
                        setState(() {
                          isShowActiveCommunitiesSwitched =
                              !isShowActiveCommunitiesSwitched;
                        });
                      }),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
