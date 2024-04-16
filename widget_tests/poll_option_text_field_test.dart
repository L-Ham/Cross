import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reddit_bel_ham/components/add_post_components/poll_option_text_field.dart';

void main() {
  testWidgets('PollOptionTextField test', (WidgetTester tester) async {
    // Build the widget
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: PollOptionTextField(
            i: 3,
            onTap: () {},
            controller: TextEditingController(),
            onChanged: (value) {},
          ),
        ),
      ),
    );

    // Verify that the widget is rendered correctly
    expect(find.text('Option 3'), findsOneWidget);
    expect(find.byType(TextField), findsOneWidget);
    expect(find.byType(Icon), findsWidgets);
    expect(find.byIcon(Icons.clear_sharp), findsOneWidget);
  });
}