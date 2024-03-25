import 'package:flutter/material.dart';
import '../constants.dart';

class EmptyDog extends StatelessWidget {
  const EmptyDog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/empty_dog.png',
            width: MediaQuery.of(context).size.width * 0.5,
            height: MediaQuery.of(context).size.height * 0.15,
          ),
          Text(
            'WOW, SUCH EMPTY',
            style: TextStyle(
              color: Colors.grey,
              fontSize: MediaQuery.of(context).size.height *
                  kPageSubtitleFontSizeHeightRatio,
            ),
          )
        ],
      ),
    );
  }
}
