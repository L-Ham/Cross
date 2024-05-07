import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

Widget linkifiedText(String text,
    [TextStyle normalStyle = const TextStyle(color: Colors.black),
    TextStyle linkStyle = const TextStyle(color: Colors.blue)]) {
  final RegExp pattern = RegExp(r'\[(.+?)\]\((.+?)\)');
  final Iterable<RegExpMatch> matches = pattern.allMatches(text);
  final List<InlineSpan> spans = [];

  int start = 0;
  for (final RegExpMatch match in matches) {
    if (match.start > start) {
      spans.add(TextSpan(
        text: text.substring(start, match.start),
      ));
    }
    spans.add(TextSpan(
      text: match.group(1),
      style: linkStyle,
      recognizer: TapGestureRecognizer()
        ..onTap = () async {
          final String url = match.group(2)!;
          try {
            if (!await launchUrl(Uri.parse(url))) {
              throw 'Could not launch $url';
            }
          } catch (e) {
            print(e);
          }
        },
    ));
    start = match.end;
  }
  if (start < text.length) {
    spans.add(TextSpan(
      text: text.substring(start),
    ));
  }

  return RichText(
    text: TextSpan(
      style: normalStyle,
      children: spans,
    ),
  );
}
