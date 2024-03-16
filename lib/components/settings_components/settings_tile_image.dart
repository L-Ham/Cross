import 'package:flutter/material.dart';

class SettingsTileImage extends StatelessWidget {
  const SettingsTileImage({
    super.key,
    required this.assetImageData,
  });

  final String assetImageData;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        right: MediaQuery.of(context).size.width * 0.04,
      ),
      child: Image(
        image: AssetImage(
          assetImageData,
        ),
        width: MediaQuery.of(context).size.width * 0.06,
        height: MediaQuery.of(context).size.height * 0.045,
      ),
    );
  }
}