import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reddit_bel_ham/components/add_post_components/invalid_link_error.dart';

void main() {
  testWidgets('InvalidLinkError widget test', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: InvalidLinkError(),
        ),
      ),
    );

    // Verify that the error container is displayed
    expect(find.byType(Container), findsOneWidget);

    // Verify that the error text is displayed
    expect(find.text("Oops, this link isn't valid. Double-check, and try again."), findsOneWidget);
  });
}