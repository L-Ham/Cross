import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reddit_bel_ham/components/add_post_components/add_post_text_field.dart';
import 'package:reddit_bel_ham/components/add_post_components/icon_button_with_caption.dart';

void main() {
  testWidgets('AddPostTextField test', (WidgetTester tester) async {
    // Build the AddPostTextField widget
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: AddPostTextField(
            hintText: 'Enter text',
            fontSizeRatio: 0.02,
            maxLines: 1,
            isTitle: false,
            hasClearButton: true,
            onClearTap: () {},
            onChanged: (value) {},
            controller: TextEditingController(),
          ),
        ),
      ),
    );

    // Verify that the AddPostTextField widget is displayed
    expect(find.byType(AddPostTextField), findsOneWidget);

    // Verify that the TextField widget is displayed
    expect(find.byType(TextField), findsOneWidget);

    // Verify that the hintText is displayed
    expect(find.text('Enter text'), findsOneWidget);

    // Verify that the IconButtonWithCaption widget is displayed
    expect(find.byType(IconButtonWithCaption), findsOneWidget);
  });
}