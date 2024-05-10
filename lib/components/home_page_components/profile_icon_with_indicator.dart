import 'package:flutter/material.dart';
import '../../utilities/screen_size_handler.dart';

class ProfileIconWithIndicator extends StatelessWidget {
  const ProfileIconWithIndicator({
    required this.isOnline,
    this.imageURL,
    this.radius = 20,
    super.key,
  });

  final bool isOnline;
  final String? imageURL;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: radius,
          child: CircleAvatar(
            backgroundImage: imageURL != "assets/images/reddit_logo.png"
                ? NetworkImage(imageURL!)
                : const AssetImage("assets/images/reddit_logo.png")
                    as ImageProvider,
            radius: 18,
          ),
        ),
        if (isOnline)
          Positioned(
            bottom: -radius * 0,
            left: radius * 0,
            child: CircleAvatar(
              backgroundColor: Colors.black,
              radius: radius * 0.32,
              child: CircleAvatar(
                backgroundColor: Colors.green,
                radius: radius * 0.23,
              ),
            ),
          ),
      ],
    );
  }
}
