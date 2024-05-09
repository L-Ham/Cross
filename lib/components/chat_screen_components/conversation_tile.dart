import 'package:flutter/material.dart';
import 'package:reddit_bel_ham/utilities/screen_size_handler.dart';

class ChatTile extends StatelessWidget {
  final dynamic conversation;

  ChatTile({required this.conversation});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(
          conversation['participantsAvatarUrls'][0]!=null? conversation['participantsAvatarUrls'][0]:'https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png',
        ),
      ),
      title: Text(conversation['chatName'] != null
          ? conversation['chatName']
          : 'chatName',
          style:TextStyle(fontSize: ScreenSizeHandler.screenWidth * 0.035,)),
      subtitle: Text(
          'Recently visited', style:TextStyle(fontSize: ScreenSizeHandler.screenWidth * 0.03,)), // Replace 'recentlyVisited' with the actual key
    );
  }
}
