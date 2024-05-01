import 'package:flutter/material.dart';

class Avatar extends StatelessWidget {
  const Avatar(
      {required this.avatar,
      this.radius = 35,
      this.defaultImg = 'assets/images/planet3.png',
      super.key});

  final String avatar;
  final double radius;
  final String defaultImg;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: Colors.white,
      child: avatar != defaultImg
          ? ClipRRect(
              borderRadius: BorderRadius.circular(35),
              child: Image.network(
                avatar,
                fit: BoxFit.cover,
              ),
            )
          : ClipRRect(
              borderRadius: BorderRadius.circular(35),
              child: Image.asset(
                defaultImg,
                fit: BoxFit.cover,
              ),
            ),
    );
  }
}
