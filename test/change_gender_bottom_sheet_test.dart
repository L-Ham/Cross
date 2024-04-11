import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:reddit_bel_ham/components/settings_components/change_gender_bottom_sheet.dart';

void main() {
  testWidgets('ChangeGenderBottomSheet Test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: Builder(
          builder: (context) => ElevatedButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (context) => ChangeGenderBottomSheet(initialValue: 'Male'),
              );
            },
            child: Text('Show Bottom Sheet'),
          ),
        ),
      ),
    ));

    // Tap on the 'Show Bottom Sheet' button to show the ChangeGenderBottomSheet.
    await tester.tap(find.text('Show Bottom Sheet'));
    await tester.pumpAndSettle();

    // Verify that the initial value is selected
    expect(find.text('Man'), findsOneWidget);
    expect(find.text('Woman'), findsOneWidget);
    expect(find.text('Others'), findsOneWidget);
    expect(find.byKey(const Key('change_gender_done_button')), findsOneWidget);


  });
}