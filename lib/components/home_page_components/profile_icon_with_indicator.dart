import 'package:flutter/material.dart';
import '../../utilities/screen_size_handler.dart';

class ProfileIconWithIndicator extends StatefulWidget {
  
  ProfileIconWithIndicator({
    required this.isOnline,
    required this.imageURL,
    this.radius = 20,
    super.key,
  });

  final bool isOnline;
  final String imageURL;
  final double radius;

  @override
  State<ProfileIconWithIndicator> createState() => _ProfileIconWithIndicatorState();
}

class _ProfileIconWithIndicatorState extends State<ProfileIconWithIndicator> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: widget.radius,
          child: CircleAvatar(
            backgroundImage: widget.imageURL != 'assets/images/reddit_logo.png'
                ? NetworkImage(widget.imageURL)
                : AssetImage(widget.imageURL) as ImageProvider,
            radius: 18,
          ),
        ),
        if (widget.isOnline)
          Positioned(
            bottom: -widget.radius * 0,
            left: widget.radius * 0,
            child: CircleAvatar(
              backgroundColor: Colors.black,
              radius: widget.radius * 0.32,
              child: CircleAvatar(
                backgroundColor: Colors.green,
                radius: widget.radius * 0.23,
              ),
            ),
          ),
      ],
    );
  }
}
