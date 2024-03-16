import 'package:flutter/material.dart';
class AcknowledgementText extends StatelessWidget {
  const AcknowledgementText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.04,
          vertical: MediaQuery.of(context).size.height * 0.02),
      child: Text(
        'By continuing, you agree to our User Agreement and acknowlege that you understand the Privacy Policy',
        style: TextStyle(
          fontSize: MediaQuery.of(context).size.width * 0.035,
          color: Colors.white,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
