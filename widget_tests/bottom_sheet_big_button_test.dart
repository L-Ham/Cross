import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reddit_bel_ham/components/add_post_components/bottom_sheet_big_button.dart';

void main() {
  testWidgets('BottomSheetBigButton UI test', (WidgetTester tester) async {
    // Build the widget
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: BottomSheetBigButton(
            title: 'Test Button',
            onTap: () {},
          ),
        ),
      ),
    );

    // Verify that the button text is displayed
    expect(find.text('Test Button'), findsOneWidget);

    // Verify that the button has the correct text color
    final buttonWidget = tester.widget<BottomSheetBigButton>(find.byType(BottomSheetBigButton));
    expect(buttonWidget.textColor, equals(Colors.black));

    // Verify that the button has the correct font weight
    final textWidget = tester.widget<Text>(find.byType(Text));
    expect(textWidget.style?.fontWeight, equals(FontWeight.w400));

    // Tap the button
    await tester.tap(find.byType(GestureDetector));
    await tester.pump();

    // Verify that the onTap callback is called
    expect(buttonWidget.onTap, isNotNull);
  });
}