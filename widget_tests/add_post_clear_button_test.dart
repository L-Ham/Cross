import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reddit_bel_ham/components/add_post_components/add_post_clear_button.dart';
import 'package:reddit_bel_ham/utilities/screen_size_handler.dart';

void main() {
  testWidgets('AddPostClearButton test', (WidgetTester tester) async {
    bool onPressedCalled = false;

    // Build the AddPostClearButton widget
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Center(
            child: AddPostClearButton(
              onPressed: () {
                onPressedCalled = true;
              },
              buttonSizeRatio: 0.09,
              hasBackround: true,
            ),
          ),
        ),
      ),
    );

    // Verify that the IconButton is displayed
    expect(find.byType(IconButton), findsOneWidget);

    // Verify that the correct icon is displayed
    expect(find.byIcon(Icons.cancel), findsOneWidget);

    // Verify that the correct color is applied to the icon
    final iconButton = tester.widget<Icon>(find.byType(Icon));
    expect(iconButton.color, Colors.black.withOpacity(0.5));

    // Verify that the correct size is applied to the icon
    final icon = tester.widget<Icon>(find.byType(Icon));
    expect(icon.size, equals(0.09 * ScreenSizeHandler.smaller));

    // Verify that the onPressed callback is triggered when the button is pressed
    await tester.tap(find.byType(IconButton));
    await tester.pump();
    expect(onPressedCalled, true);
  });
}
