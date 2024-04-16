import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reddit_bel_ham/components/add_post_components/icon_button_with_caption.dart';

void main() {
  testWidgets('IconButtonWithCaption test', (WidgetTester tester) async {
    // Build the IconButtonWithCaption widget
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: IconButtonWithCaption(
            icon: Icons.add,
            caption: 'Add',
            onTap: () {},
          ),
        ),
      ),
    );

    // Verify that the icon is displayed
    expect(find.byIcon(Icons.add), findsOneWidget);

    // Verify that the caption is displayed
    expect(find.text('Add'), findsOneWidget);

    // Verify that the onTap function is called when the widget is tapped
    await tester.tap(find.byType(IconButtonWithCaption));
    await tester.pump();
    // Add your verification code here

  });
}