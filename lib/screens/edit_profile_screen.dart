import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:reddit_bel_ham/components/general_components/rounded_button.dart';
import 'package:reddit_bel_ham/constants.dart';
import 'package:reddit_bel_ham/services/api_service.dart';
import 'package:reddit_bel_ham/utilities/screen_size_handler.dart';
import '../components/create_community_components/community_name_text_box.dart';
import '../components/general_components/custom_switch.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:reddit_bel_ham/utilities/token_decoder.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import '../components/general_components/reddit_loading_indicator.dart';


class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});
  static const String id = 'edit_profile_screen';

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  ApiService apiService = ApiService(TokenDecoder.token);
  final _picker = ImagePicker();
  XFile? chosenImage;
  XFile? chosenCoverImage;
  List<Map<String, dynamic>> socialLinks = [];
  List<Icon> socialIcons = [];
  List<String> socialType = [];
  bool isAddSocialLinkPressed = false;
  String avatarImage = '';
  String bannerImage = '';
  String displayName='';
  String about='';
  String displayTextField='';
  String aboutTextField='';
  bool contentVisibility=false;
  bool communitiesVisibility=false;
  bool hasCalledAddSocialLink = false;
  bool isLoading = false;
  bool isContentVisibilityToggled = false;
  bool isShowActiveCommunitiesToggled = false;
  FocusNode displayFocusNode = FocusNode();
  FocusNode aboutFocusNode = FocusNode();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Map<String, dynamic> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    isAddSocialLinkPressed = args['isAddSocialLinkPressed'] as bool;
    setState(() {
      
    avatarImage = args['avatarImage'] as String;
    bannerImage = args['bannerImage'] as String;
    getSocialLinks();
    getProfileSettings();
    });

if (isAddSocialLinkPressed && !hasCalledAddSocialLink) {
  WidgetsBinding.instance.addPostFrameCallback((_) {
    setState(() {
      isAddSocialLinkPressed = false;
      hasCalledAddSocialLink = true;
    });
    addSocialLink();
  });
}
  }

    Future<void> getSocialLinks() async {
    Map<String, dynamic> data = (await apiService.getProfileSettings()) ?? {};
    if (mounted) {
      setState(() {
        socialLinks = (data['profileSettings']['socialLinks'] as List<dynamic>)
                ?.map((item) => item as Map<String, dynamic>)
                ?.toList() ??
            [];
      });
    }
  }

  Future<void> getProfileSettings() async {
    Map<String, dynamic> data = (await apiService.getProfileSettings()) ?? {};
    if (mounted) {
      setState(() {
        displayName = data['profileSettings']['displayName'] as String;
        about = data['profileSettings']['about'] as String;
        isContentVisibilitySwitched = data['profileSettings']['contentVisibility'] as bool;
        isShowActiveCommunitiesSwitched = data['profileSettings']['communitiesVisibility'] as bool;
        print(displayName);
        print(about);
        print(contentVisibility);
        print(communitiesVisibility);
      });
    }
  }

  void uploadAvatarImageAPI(XFile chosenImage) async {
    await apiService.uploadAvatarImage(File(chosenImage.path));
    getAvatarImage();
  }
    void uploadBannerImageAPI(XFile chosenImage) async {
    await apiService.uploadBannerImage(File(chosenImage.path));
    getBannerImage();

  }

  Future<void> getAvatarImage() async {
    Map<String, dynamic> data = (await apiService.getAvatarImage()) ?? {};
    if (mounted) {
      setState(() {
        avatarImage = data['url'] as String;
        isLoading = false;
      });
    }
  }
    Future<void> getBannerImage() async {
    Map<String, dynamic> data = (await apiService.getBannerImage()) ?? {};
    if (mounted) {
      setState(() {
        bannerImage = data['url'] as String;
        isLoading = false;
      });
    }
  }

  Future<void> removeSocialLinkAPI(linkId) async {
    Map<String, dynamic> data =
        (await apiService.deleteSocialLink(linkId)) ?? {};
    print(data);
    setState(() {
      print(socialLinks.length);
      getSocialLinks();
    });
  }

  Future<void> editProfileInfo(displayName, about, contentVisibility, communitiesVisibility) async {
        print(displayName);
        print(about);
        print(contentVisibility);
        print(communitiesVisibility);
    Map<String, dynamic> data =
        (await apiService.editProfileInfo(displayName,about,contentVisibility, communitiesVisibility)) ?? {};
    print(data);
    setState(() {
      isLoading=false;
    });
    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      getSocialLinks();
      
    });
  }
    final iconMapping = {
    'reddit': Icon(
      FontAwesomeIcons.reddit,
      color: Colors.deepOrange,
    ),
    'facebook': Icon(
      FontAwesomeIcons.facebook,
      color: Colors.blue,
    ),
    'twitter': Icon(FontAwesomeIcons.twitter, color: Colors.blue),
    'youtube': Icon(FontAwesomeIcons.youtube, color: Colors.red),
    'paypal': Icon(FontAwesomeIcons.paypal, color: Colors.blue),
    'discord': Icon(
      FontAwesomeIcons.discord,
      color: Colors.blue,
    ),
    'instagram': Icon(FontAwesomeIcons.instagram, color: Colors.purple),
    'tiktok': Icon(FontAwesomeIcons.tiktok, color: Colors.white),
    'soundcloud': Icon(FontAwesomeIcons.soundcloud, color: Colors.deepOrange),
    'twitch': Icon(
      FontAwesomeIcons.twitch,
      color: Colors.purple,
    ),
    'spotify': Icon(
      FontAwesomeIcons.spotify,
      color: Colors.green,
    ),
    'link': Icon(FontAwesomeIcons.link, color: Colors.black),
    // Add more mappings as needed...
  };

  Future<void> addSocialLinkAPI(linkOrUsername, appName, displayText) async {
    final Map<String, dynamic> body = {
      'linkOrUsername': linkOrUsername,
      'appName': appName,
      'displayText': displayText,
    };
        Map<String, dynamic> data =
        (await apiService.addSocialLink(body)) ?? {};

      setState(() {
        
      getSocialLinks();
      });
    

  }

  addSocialLink() {
    isAddSocialLinkPressed = false;
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 300,
            color: kBackgroundColor,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
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
                          padding: const EdgeInsets.only(left: 90.0),
                          child: Text(
                            'Add social link',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: kButtonSmallerFontRatio *
                                    ScreenSizeHandler.smaller *
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
                                      color: Colors.deepOrange, size: 18),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Text(
                                      'Reddit',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 13),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                          buttonHeightRatio: 0.05,
                          buttonWidthRatio: 0.1,
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.reddit,
                                  color: Colors.deepOrange, size: 18),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text(
                                  'Reddit',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 13),
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
                                    Icon(FontAwesomeIcons.paypal,
                                        color: Colors.blue, size: 18),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Text(
                                        'PayPal',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 13),
                                      ),
                                    ),
                                  ],
                                ),
                                'paypal',
                                Icon(FontAwesomeIcons.paypal,
                                    color: Colors.blue, size: 18));
                          },
                          buttonHeightRatio: 0.05,
                          buttonWidthRatio: 0.12,
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(FontAwesomeIcons.paypal,
                                  color: Colors.blue, size: 18),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text(
                                  'PayPal',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 13),
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
                                    Icon(FontAwesomeIcons.discord,
                                        color: Colors.blue, size: 18),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Text(
                                        'Discord',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 13),
                                      ),
                                    ),
                                  ],
                                ),
                                Icon(FontAwesomeIcons.discord,
                                    color: Colors.blue, size: 18),
                                'discord.com','discord');
                          },
                          buttonHeightRatio: 0.05,
                          buttonWidthRatio: 0.12,
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(FontAwesomeIcons.discord,
                                  color: Colors.blue, size: 18),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text(
                                  'Discord',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 13),
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
                                    Icon(FontAwesomeIcons.facebook,
                                        color: Colors.blue, size: 18),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Text(
                                        'Facebook',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 13),
                                      ),
                                    ),
                                  ],
                                ),
                                Icon(FontAwesomeIcons.facebook,
                                    color: Colors.blue, size: 18),
                                'facebook.com','facebook');
                          },
                          buttonHeightRatio: 0.05,
                          buttonWidthRatio: 0.13,
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.facebook,
                                  color: Colors.blue, size: 18),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text(
                                  'Facebook',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 13),
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
                                    Icon(FontAwesomeIcons.instagram,
                                        color: Colors.purple, size: 18),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Text(
                                        'Instagram',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 13),
                                      ),
                                    ),
                                  ],
                                ),
                                'instagram',
                                Icon(FontAwesomeIcons.instagram,
                                    color: Colors.purple, size: 18));
                          },
                          buttonHeightRatio: 0.05,
                          buttonWidthRatio: 0.13,
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(FontAwesomeIcons.instagram,
                                  color: Colors.purple, size: 18),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text(
                                  'Instagram',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 13),
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
                                    Icon(FontAwesomeIcons.tiktok,
                                        color: Colors.white, size: 18),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Text(
                                        'Tiktok',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 13),
                                      ),
                                    ),
                                  ],
                                ),
                                'tiktok',
                                Icon(FontAwesomeIcons.tiktok,
                                    color: Colors.white, size: 18));
                          },
                          buttonHeightRatio: 0.05,
                          buttonWidthRatio: 0.11,
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(FontAwesomeIcons.tiktok,
                                  color: Colors.white, size: 18),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text(
                                  'Tiktok',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 13),
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
                                    Icon(FontAwesomeIcons.twitter,
                                        color: Colors.blue, size: 18),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Text(
                                        'Twitter',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 13),
                                      ),
                                    ),
                                  ],
                                ),
                                'twitter',
                                Icon(FontAwesomeIcons.twitter,
                                    color: Colors.blue, size: 18));
                          },
                          buttonHeightRatio: 0.05,
                          buttonWidthRatio: 0.1,
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(FontAwesomeIcons.twitter,
                                  color: Colors.blue, size: 18),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text(
                                  'Twitter',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 13),
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
                                    Icon(FontAwesomeIcons.soundcloud,
                                        color: Colors.deepOrange, size: 18),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Text(
                                        'Soundcloud',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 13),
                                      ),
                                    ),
                                  ],
                                ),
                                'soundcloud',
                                Icon(FontAwesomeIcons.soundcloud,
                                    color: Colors.deepOrange, size: 18));
                          },
                          buttonHeightRatio: 0.05,
                          buttonWidthRatio: 0.14,
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(FontAwesomeIcons.soundcloud,
                                  color: Colors.deepOrange, size: 18),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text(
                                  'Soundcloud',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 13),
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
                                    Icon(FontAwesomeIcons.paypal,
                                        color: Colors.purple, size: 18),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Text(
                                        'Twitch',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 13),
                                      ),
                                    ),
                                  ],
                                ),
                                'twitch',
                                Icon(FontAwesomeIcons.twitch,
                                    color: Colors.purple, size: 18));
                          },
                          buttonHeightRatio: 0.05,
                          buttonWidthRatio: 0.12,
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(FontAwesomeIcons.twitch,
                                  color: Colors.purple, size: 18),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text(
                                  'Twitch',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 13),
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
                                    Icon(FontAwesomeIcons.youtube,
                                        color: Colors.red, size: 18),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Text(
                                        'Youtube',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 13),
                                      ),
                                    ),
                                  ],
                                ),
                                Icon(FontAwesomeIcons.youtube,
                                    color: Colors.red, size: 18),
                                'youtube.com','youtube');
                          },
                          buttonHeightRatio: 0.05,
                          buttonWidthRatio: 0.12,
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(FontAwesomeIcons.youtube,
                                  color: Colors.red, size: 18),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text(
                                  'Youtube',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 13),
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
                                    Icon(FontAwesomeIcons.spotify,
                                        color: Colors.green, size: 18),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Text(
                                        'Spotify',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 13),
                                      ),
                                    ),
                                  ],
                                ),
                                Icon(FontAwesomeIcons.spotify,
                                    color: Colors.green, size: 18),
                                'spotify.com','spotify');
                          },
                          buttonHeightRatio: 0.05,
                          buttonWidthRatio: 0.12,
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(FontAwesomeIcons.spotify,
                                  color: Colors.green, size: 18),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text(
                                  'Spotify',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 13),
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
                                        color: Colors.black, size: 18),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Text(
                                        'Custom',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 13),
                                      ),
                                    ),
                                  ],
                                ),
                                Icon(FontAwesomeIcons.link,
                                    color: Colors.black, size: 18),
                                '.','link');
                          },
                          buttonHeightRatio: 0.05,
                          buttonWidthRatio: 0.12,
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(FontAwesomeIcons.link,
                                  color: Colors.black, size: 18),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text(
                                  'Custom',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 13),
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
  }

  addUsernameLink(Widget child, String app, Icon icon) {
    bool isTextEmpty = true;
    FocusNode focusNode = FocusNode();
    String username = '';
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
                            focusNode.unfocus();
                            setState(() {
                              addSocialLinkAPI('https://www.$app.com/$username', app, username);
                              // socialLinks.add(username);
                              socialIcons.add(icon);
                              socialType.add('username');
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
                    focusNode: focusNode,
                    onChanged: (value) {
                      setState(() {
                        username = value;
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

  addWebsiteLink(Widget child, Icon icon, String website, String app) {
    bool isText1Empty = true;
    bool isText2Empty = true;
    bool isWebsiteRegex = false;
    bool isEnabled = false;
    FocusNode focusNode1 = FocusNode();
    FocusNode focusNode2 = FocusNode();
    String displayName='';
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
                          focusNode1.unfocus();
                          focusNode2.unfocus();
                          if (!isText1Empty &&
                              !isText2Empty &&
                              isWebsiteRegex) {
                            setState(() {
                              addSocialLinkAPI(displayName, app, url);
                              // socialLinks.add(url);
                              socialIcons.add(icon);
                              socialType.add('link');
                              Navigator.pop(context);
                            });
                          }
                        },
                        icon: Icon(Icons.check),
                        color: !isEnabled ? kFillingColor : Colors.blue,
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
                    focusNode: focusNode1,
                    // controller: TextEditingController(),
                    onChanged: (value) {
                      setState(() {
                        isText1Empty = value.isEmpty;
                        isEnabled = !isText2Empty && !isText1Empty;
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
                    focusNode: focusNode2,
                    // controller: TextEditingController(),
                    onChanged: (value) {
                      setState(() {
                        isText2Empty = value.isEmpty;
                        isEnabled = !isText2Empty && !isText1Empty;
                        isWebsiteRegex = value.contains(website) && value.contains('https://www.') && value.contains('.com');
                        displayName = value;
                      });
                    },
                    decoration: InputDecoration(
                      labelText: 'https://www.website.com',
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
                Visibility(
                    visible: !isWebsiteRegex && !isText2Empty,
                    child: Text('Invalid domain',
                        style: TextStyle(
                          color: Colors.red[200],
                          fontSize: kErrorMessageSmallerFontRatio *
                              ScreenSizeHandler.smaller,
                        )))
              ],
            ),
          );
        });
  }

  addRedditLink(Widget child) {
    bool isTextEmpty = true;
    bool isTextValid = false;
    FocusNode focusNode = FocusNode();
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
                            focusNode.unfocus();
                            setState(() {
                              addSocialLinkAPI(url, 'reddit', url);
                              // socialLinks.add(url);
                              socialIcons.add(Icon(Icons.reddit,
                                  color: Colors.deepOrange, size: 18));
                              socialType.add('reddit');
                            });
                            Navigator.pop(context);
                          }
                        },
                        icon: Icon(Icons.check),
                        color: !isTextValid || isTextEmpty
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
                    focusNode: focusNode,
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
  final filePath = chosenImage!.path;
  final lastIndex = filePath.lastIndexOf(new RegExp(r'.jp'));
  final splitted = filePath.substring(0, (lastIndex));
  final outPath = "${splitted}_compressed.jpg";

  final compressedImage = await FlutterImageCompress.compressAndGetFile(
    chosenImage!.path,
    outPath,
    quality: 88,
  );
    if (chosenImage != null) {
      setState(() {
        isLoading = true;
        chosenImage = compressedImage;
        uploadAvatarImageAPI(compressedImage!);
      });
    }
  }

  void addCoverImage() async {
  chosenCoverImage = await _picker.pickImage(source: ImageSource.gallery);
  final filePath = chosenCoverImage!.path;
  final lastIndex = filePath.lastIndexOf(new RegExp(r'.jp'));
  final splitted = filePath.substring(0, (lastIndex));
  final outPath = "${splitted}_compressed.jpg";

  final compressedImage = await FlutterImageCompress.compressAndGetFile(
    chosenCoverImage!.path,
    outPath,
    quality: 88,
  );
    if (chosenCoverImage != null) {
      setState(() {
        isLoading = true;
        chosenCoverImage = compressedImage;
        uploadBannerImageAPI(chosenCoverImage!);
      });
    }
  }

  TextEditingController displayNameController = TextEditingController();
  bool isContentVisibilitySwitched = false;
  bool isShowActiveCommunitiesSwitched = false;
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      progressIndicator: const RedditLoadingIndicator(),
      blur: 0,
      opacity: 0,
      offset: Offset(ScreenSizeHandler.screenWidth * 0.38,
          ScreenSizeHandler.screenHeight * 0.6),
      child: Scaffold(
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
              
              onPressed: () {
                if (displayTextField.isEmpty && aboutTextField.isEmpty && !isContentVisibilityToggled && !isShowActiveCommunitiesToggled) {
                  return;
                }
                setState(() {
                displayFocusNode.unfocus();
                aboutFocusNode.unfocus();
                isLoading=true;
                
                editProfileInfo(displayTextField.isEmpty?displayName:displayTextField, aboutTextField.isEmpty?about:aboutTextField,isContentVisibilitySwitched,isShowActiveCommunitiesSwitched);
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: displayTextField.isEmpty && aboutTextField.isEmpty && !isContentVisibilityToggled && !isShowActiveCommunitiesToggled
                    ? kDisabledButtonColor
                    : Colors.blue,
              ),
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
                          child: bannerImage.isEmpty
                              ? Container(
                                  color: Colors.grey,
                                  height: 200,
                                  width: double.infinity,
                                )
                              : Image.network(
                                  bannerImage,
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
                      left: 150,
                      child: avatarImage.isEmpty
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(80),
                              child: Icon(
                                Icons.account_circle,
                                size: 100,
                                color: Colors.white,
                              ),
                              )
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(80),
                              child: Image.network(
                                avatarImage,
                                height: 100,
                                width: 100,
                                fit: BoxFit.cover,
                              ),
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
                        focusNode: displayFocusNode,
                        onChanged: (value)
                        {
                        setState(() {
                          displayTextField = value;
                        });
                        },
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
                  focusNode: aboutFocusNode,
                  onChanged: (value)
                  {
                    setState(() {
                      
                  aboutTextField = value;
                    });
                  },
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
                    // ElevatedButton(
                    //   onPressed: () {
                    //     addSocialLink();
                    //   },
                    //   child: Row(
                    //     mainAxisSize: MainAxisSize.min,
                    //     children: [
                    //       Icon(Icons.add, color: Colors.white),
                    //       Text('Add social link',
                    //           style:
                    //               TextStyle(color: Colors.white, fontSize: 13)),
                    //     ],
                    //   ),
                    //   style: ElevatedButton.styleFrom(
                    //     backgroundColor: kBackgroundColor,
                    //     shape: RoundedRectangleBorder(
                    //       borderRadius: BorderRadius.circular(100.0),
                    //     ),
                    //   ),
                    // ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: socialLinks.length < 2
                              ? 50
                              : socialLinks.length < 4
                                  ? 100
                                  : 150,
                          child: GridView.builder(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2, mainAxisExtent: 50),
                              itemCount: socialLinks.length + 1,
                              itemBuilder: (context, index) {
                                var iconName =
                                              index < socialLinks.length
                                                  ? socialLinks[index]['appName']
                                                  : '';
                                          var icon = iconMapping[iconName];
                                return index == socialLinks.length
                                    ? Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: ElevatedButton(
                                          onPressed: () {
                                            if (socialLinks.length > 4) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(SnackBar(
                                                behavior:
                                                    SnackBarBehavior.floating,
                                                margin: EdgeInsets.only(
                                                    bottom: ScreenSizeHandler
                                                            .screenHeight *
                                                        0.12,
                                                    left: ScreenSizeHandler
                                                            .screenWidth *
                                                        0.04,
                                                    right: ScreenSizeHandler
                                                            .screenWidth *
                                                        0.04),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(30.0),
                                                ),
                                                content: Center(
                                                    child: Text('You can'
                                                        't add more than 5 links')),
                                                duration:
                                                    const Duration(seconds: 3),
                                              ));
                                            } else {
                                              addSocialLink();
                                            }
                                          },
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Icon(Icons.add,
                                                  color: Colors.white),
                                              Text('Add social link',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 13)),
                                            ],
                                          ),
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: kBackgroundColor,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(100.0),
                                            ),
                                          ),
                                        ),
                                      )
                                    : Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: RoundedButton(
                                          onTap: () {},
                                          buttonHeightRatio: 0.06,
                                          buttonWidthRatio: 0.1,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              icon!,
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 8.0),
                                                child: Text(
                                                  socialLinks[index]['displayText'],
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 13),
                                                ),
                                              ),
                                              IconButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      // socialLinks.removeAt(index);
                                                      // socialIcons.removeAt(index);
                                                      // socialType.removeAt(index);
                                                      removeSocialLinkAPI(socialLinks[index]['_id']);
                                                    });
                                                  },
                                                  icon: Icon(Icons.clear))
                                            ],
                                          ),
                                        ),
                                      );
                              }),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16, right: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
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
                    ),
                    CustomSwitch(
                        isSwitched: isContentVisibilitySwitched,
                        onChanged: (value) {
                          setState(() {
                            isContentVisibilityToggled=true;
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
                            isShowActiveCommunitiesToggled=true;
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
      ),
    );
  }
}
