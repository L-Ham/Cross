import 'package:flutter_test/flutter_test.dart';
testWidgets('Change gender to female',
  (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Material(
        child: Builder(builder: (context) {
          return SettingsTile(
            key: const Key('change_gender_tile'),
            trailingWidget: const SettingsTileTrailingIcon(
              trailingIcon: Icons.arrow_back,
            ),
            titleText: "Change Gender",
            onTap: () async {
              final result = await showModalBottomSheet(
                context: context,
                builder: (BuildContext bc) {
                  return const ClipRRect(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20.0),
                    ),
                    child: ChangeGenderBottomSheet(
                      initialValue: 'Male',
                    ),
                  );
                });
  
              // Log the result
              print('Result from showModalBottomSheet: $result');
              
              // Check that the result is 'Female'
              expect(result, 'Female');
            },
            leadingIcon: const SettingsTileLeadingIcon(
              leadingIcon: Icons.person,
            ),
          );
        }),
      ),
    ));

    // Tap the button to open the ChangeGenderBottomSheet
    await tester.tap(find.byKey(const Key('change_gender_tile')));
    await tester.pumpAndSettle();

    // Tap the female_radio_button_tile to select the female gender
    await tester.tap(find.byKey(const Key('female_radio_button_tile')));
    await tester.pumpAndSettle();

    // Scroll to ensure the done_button is visible
    await tester.ensureVisible(find.byKey(const Key('done_button')));
    
    // Tap the Done button to close the ChangeGenderBottomSheet
    await tester.tap(find.byKey(const Key('done_button')));
    await tester.pumpAndSettle();
});
